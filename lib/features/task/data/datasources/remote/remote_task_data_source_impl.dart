import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_achievments/core/common/avatar/avatar.dart';
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
      final file = File(filePath);
      final fileRef = _firebaseStorage.ref().child('tasks/reports/$taskId');
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
      await _firestore
          .collection('tasks')
          .doc(taskId)
          .update({'photoReport': photo.copyWith(downloadUrl!)});
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
  Future<void> createTask(TaskModel task) async {
    try {
      await _firestore.collection('tasks').add(task.toMap());
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
  Future<List<TaskModel>> getTasks() async {
    try {
      final tasksMap = await _firestore.collection('tasks').get();
      final taskModels = tasksMap.docs.map((e) {
        final data = e.data();
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
      await _firestore.collection('tasks').doc(id).update({'state': 'rejected'});
    } on FirebaseException catch (e) {
      throw FireStoreError.from(e);
    }
  }

  @override
  Future<void> suggestTask(TaskModel task) async {
    try {
      await _firestore.collection('tasks').add(task.toMap());
    } on FirebaseException catch (e) {
      throw FireStoreError.from(e);
    }
  }

  @override
  Future<void> updateTask(TaskModel task) async {
    try {
      await _firestore
          .collection('tasks')
          .doc(task.id)
          .update(task.toMap());
    } on FirebaseException catch (e) {
      throw FireStoreError.from(e);
    }
  }
}
