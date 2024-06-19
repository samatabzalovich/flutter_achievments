import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_achievments/core/common/avatar/avatar.dart';
import 'package:flutter_achievments/core/common/avatar/frame_avatar.dart';
import 'package:flutter_achievments/core/enums/task_type.dart';
import 'package:flutter_achievments/core/error/firestore_errors/firestore_errors.dart';
import 'package:flutter_achievments/core/error/storage_errors/storage_error.dart';
import 'package:flutter_achievments/core/services/get_it.dart';
import 'package:flutter_achievments/core/utils/image_utils.dart';
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
      final downloadUrl = await sl<ImageUtils>().getDownloadUrl(
        bucketPath: 'tasks/reports/',
        filePath: filePath,
        id: taskId,
        progressSink: progressSink,
        firebaseStorage: _firebaseStorage,
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
      final downloadUrl = await sl<ImageUtils>().getDownloadUrl(
        bucketPath: 'tasks/avatars/',
        filePath: filePath,
        id: taskId,
        progressSink: progressSink,
        firebaseStorage: _firebaseStorage,
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
