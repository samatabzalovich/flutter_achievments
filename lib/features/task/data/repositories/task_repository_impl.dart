import 'package:dartz/dartz.dart';
import 'package:flutter_achievments/core/common/avatar/avatar.dart';
import 'package:flutter_achievments/core/common/avatar/frame_avatar.dart';
import 'package:flutter_achievments/core/error/exception.dart';
import 'package:flutter_achievments/core/error/failure.dart';
import 'package:flutter_achievments/core/utils/typedefs.dart';
import 'package:flutter_achievments/features/task/data/datasources/remote/remote_task_data_source.dart';
import 'package:flutter_achievments/features/task/data/models/task_models/task_model.dart';
import 'package:flutter_achievments/features/task/domain/entities/task_entities/task_entity.dart';
import 'package:flutter_achievments/features/task/domain/repositories/task_repository.dart';

class TaskRepoImpl implements TaskRepo {
  final RemoteTaskDataSource _taskDataSource;
  const TaskRepoImpl(this._taskDataSource);
  @override
  ResultFuture<void> acceptTask(String id) async {
    try {
      await _taskDataSource.acceptTask(id);
      return const Right(null);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }

  @override
  ResultFuture<void> attachPhotoReport(
      {required String filePath,
      Sink<double>? progressSink,
      required String taskId,
      required NetworkAvatarEntity photo}) async {
    try {
      await _taskDataSource.attachPhotoReport(
          filePath: filePath,
          progressSink: progressSink,
          taskId: taskId,
          photo: photo);
      return const Right(null);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }

  @override
  ResultFuture<void> uploadAvatar(
      {required String filePath,
      Sink<double>? progressSink,
      required String taskId,
      required FrameAvatarEntity photo}) async {
    try {
      await _taskDataSource.uploadTaskAvatar(
          filePath: filePath,
          progressSink: progressSink,
          taskId: taskId,
          taskAvatar: photo);
      return const Right(null);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }


  @override
  ResultFuture<void> completeTask(String id) async {
    try {
      await _taskDataSource.completeTask(id);
      return const Right(null);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }

  @override
  ResultFuture<String> createTask(TaskEntity task) async {
    try {
      final id = await _taskDataSource.createTask(task.toModel());
      return  Right(id);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }

  @override
  ResultFuture<void> deleteTask(String id) async {
    try {
      await _taskDataSource.deleteTask(id);
      return const Right(null);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<TaskModel>> getTasks({required DateTime selectedDate,
    int limit = 50, required String userId, required String performer}) async {
    try {
      final tasks = await _taskDataSource.getTasks(selectedDate: selectedDate, limit: limit,userId: userId, performer: performer);
      return Right(tasks);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }

  @override
  ResultFuture<void> redoTask(String id) async {
    try {
      await _taskDataSource.redoTask(id);
      return const Right(null);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }

  @override
  ResultFuture<void> refuseTask(String id) async {
    try {
      await _taskDataSource.refuseTask(id);
      return const Right(null);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }

  @override
  ResultFuture<void> rejectTask(String id) async {
    try {
      await _taskDataSource.rejectTask(id);
      return const Right(null);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }

  @override
  ResultFuture<String> suggestTask(TaskEntity task) async {
    try {
      final id = await _taskDataSource.suggestTask(task.toModel());
      return  Right(id);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }

  @override
  ResultFuture<void> updateTask(TaskEntity task) async {
    try {
      await _taskDataSource.updateTask(task as TaskModel);
      return const Right(null);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }
}
