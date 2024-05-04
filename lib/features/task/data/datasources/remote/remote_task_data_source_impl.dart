import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_achievments/core/common/avatar/avatar.dart';
import 'package:flutter_achievments/core/common/avatar/frame_avatar.dart';
import 'package:flutter_achievments/core/enums/task_type.dart';
import 'package:flutter_achievments/core/error/firestore_errors/firestore_errors.dart';
import 'package:flutter_achievments/core/error/storage_errors/storage_error.dart';
import 'package:flutter_achievments/features/task/data/datasources/remote/remote_task_data_source.dart';
import 'package:flutter_achievments/features/task/data/models/task_models/one_time_task_model.dart';
import 'package:flutter_achievments/features/task/data/models/task_models/permanent_task_model.dart';
import 'package:flutter_achievments/features/task/data/models/task_models/repeatable_task_model.dart';
import 'package:flutter_achievments/features/task/data/models/task_models/task_model.dart';

class RemoteTaskDataSourceImpl implements RemoteTaskDataSource {
  final FirebaseFirestore _firestore;
  final FirebaseStorage _firebaseStorage;

  DocumentSnapshot? _lastDoc;
  DateTime? _selectedDate;

  RemoteTaskDataSourceImpl(this._firestore, this._firebaseStorage);

  @override
  Future<void> acceptTask(String id) {
    try {
      return _firestore
          .collection('tasks')
          .doc(id)
          .update({'state': 'completed'});
    } on FirebaseException catch (e) {
      throw FireStoreError.from(e);
    }
  }

  @override
  Future<void> attachPhotoReport(
      {required String filePath,
      Sink<double>? progressSink,
      required String taskId,
      required NetworkAvatarEntity photo}) async {
    try {
      final downloadUrl = await _getDownloadUrl(
        bucketPath: 'tasks/reports/',
        filePath: filePath,
        taskId: taskId,
        progressSink: progressSink,
      );
      await _firestore
          .collection('tasks')
          .doc(taskId)
          .update({'photoReport': photo.copyWith(downloadUrl)});
    } on StorageError {
      rethrow;
    } on FirebaseException catch (e) {
      throw FireStoreError.from(e);
    }
  }

  @override
  Future<void> uploadTaskAvatar(
      {required String filePath,
      Sink<double>? progressSink,
      required String taskId,
      required FrameAvatarEntity taskAvatar}) async {
    try {
      final downloadUrl = await _getDownloadUrl(
        bucketPath: 'tasks/avatars/',
        filePath: filePath,
        taskId: taskId,
        progressSink: progressSink,
      );
      final avatar =
          (taskAvatar.avatar as NetworkAvatarEntity).copyWith(downloadUrl);
      await _firestore.collection('tasks').doc(taskId).update({
        'avatar': taskAvatar
            .copyWith(
              avatar: avatar,
            )
            .toMap()
      });
    } on StorageError {
      rethrow;
    } on FirebaseException catch (e) {
      throw FireStoreError.from(e);
    }
  }

  Future<String> _getDownloadUrl({
    required String filePath,
    required String taskId,
    required String bucketPath,
    Sink<double>? progressSink,
  }) async {
    try {
      final file = File(filePath);
      final fileRef = _firebaseStorage.ref().child('$bucketPath$taskId');
      final uploadTask = fileRef.putFile(file);
      // Listen to changes in the upload task
      final subscription = uploadTask.snapshotEvents.listen(
        (TaskSnapshot snapshot) {
          final totalBytes = snapshot.totalBytes == 0 ? 1 : snapshot.totalBytes;
          double progress = ((snapshot.bytesTransferred / totalBytes) * 100);
          progressSink!.add(progress);
        },
        onError: (e) {
          progressSink!.add(0);
          progressSink.close();
          throw const StorageErrorUnknown();
        },
      );
      String? downloadUrl;
      // Handle completion
      await uploadTask.whenComplete(() async {
        try {
          if (uploadTask.snapshot.state == TaskState.success) {
            downloadUrl = await uploadTask.snapshot.ref.getDownloadURL();
            // Emit completion state with download URL
            progressSink!.add(100);
          } else {
            // Emit error if upload didn't succeed
            progressSink!.add(0);
          }
        } catch (e) {
          // Emit error
          progressSink!.add(0);
          throw const StorageErrorUnknown();
        } finally {
          // Always close the controller
          progressSink!.close();
          subscription.cancel();
        }
      });
      return downloadUrl!;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> completeTask(String id) async {
    try {
      await _firestore.collection('tasks').doc(id).update({'state': 'pending'});
    } on FirebaseException catch (e) {
      throw FireStoreError.from(e);
    }
  }

  @override
  Future<String> createTask(TaskModel task) async {
    try {
      final res = await _firestore.collection('tasks').add(task.toMap());
      return res.id;
    } on FirebaseException catch (e) {
      throw FireStoreError.from(e);
    }
  }

  @override
  Future<void> deleteTask(String id) async {
    try {
      await _firestore.collection('tasks').doc(id).delete();
    } on FirebaseException catch (e) {
      throw FireStoreError.from(e);
    }
  }

  @override
  Future<List<TaskModel>> getTasks({
    required DateTime selectedDate,
    required String userId,
    required String performer,
    int limit = 50,
  }) async {
    try {
      final startOfDay = DateTime(
          selectedDate.year, selectedDate.month, selectedDate.day, 0, 0, 0);

      final query = _firestore
          .collection('tasks')
          .where(
            Filter.and(
              Filter(
                "parentId",
                isEqualTo: userId,
              ),
              Filter.or(
                Filter(
                  "repeatOnDays",
                  arrayContains: selectedDate.weekday,
                ),
                Filter(
                  'startTime',
                  isGreaterThan: startOfDay,
                ),
                Filter(
                  'type',
                  isEqualTo: TaskType.permanent.name,
                ),
              ),
            ),
          )
          // .orderBy('createdAt')
          .limit(limit);

      if (_lastDoc != null && _selectedDate == selectedDate) {
        query.startAfterDocument(_lastDoc!);
      }

      final tasksMap = await query.get();
      final taskModels = tasksMap.docs.map((e) {
        final data = e.data();
        data['id'] = e.id;
        switch (data['type']) {
          case 'oneTime':
            return OneTimeTaskModel.fromMap(data);
          case 'permanent':
            return PermanentTaskModel.fromMap(data);
          case 'repeatable':
            return RepeatableTaskModel.fromMap(data);
          default:
            throw const FirestoreErrorUnknown();
        }
      }).toList();
      if (tasksMap.docs.isNotEmpty) {
        _lastDoc = tasksMap.docs.last;
      }
      _selectedDate = selectedDate;
      return taskModels;
    } on FirebaseException catch (e) {
      throw FireStoreError.from(e);
    }
  }

  @override
  Future<void> redoTask(String id) async {
    try {
      await _firestore.collection('tasks').doc(id).update({'state': 'redo'});
    } on FirebaseException catch (e) {
      throw FireStoreError.from(e);
    }
  }

  @override
  Future<void> refuseTask(String id) async {
    try {
      await _firestore.collection('tasks').doc(id).update({'state': 'refused'});
    } on FirebaseException catch (e) {
      throw FireStoreError.from(e);
    }
  }

  @override
  Future<void> rejectTask(String id) async {
    try {
      await _firestore
          .collection('tasks')
          .doc(id)
          .update({'state': 'rejected'});
    } on FirebaseException catch (e) {
      throw FireStoreError.from(e);
    }
  }

  @override
  Future<String> suggestTask(TaskModel task) async {
    try {
      final res = await _firestore.collection('tasks').add(task.toMap());
      return res.id;
    } on FirebaseException catch (e) {
      throw FireStoreError.from(e);
    }
  }

  @override
  Future<void> updateTask(TaskModel task) async {
    try {
      await _firestore.collection('tasks').doc(task.id).update(task.toMap());
    } on FirebaseException catch (e) {
      throw FireStoreError.from(e);
    }
  }
}
