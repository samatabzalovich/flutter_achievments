import 'package:flutter_achievments/core/common/avatar/avatar.dart';
import 'package:flutter_achievments/core/utils/typedefs.dart';
import 'package:flutter_achievments/features/task/domain/entities/task_entities/task_entity.dart';

abstract class TaskRepo {
  ResultFuture<List<TaskEntity>> getTasks();
  ResultFuture<void> createTask(TaskEntity task);
  ResultFuture<void> updateTask(TaskEntity task);
  ResultFuture<void> deleteTask(String id);
  ResultFuture<void> completeTask(
      String
          id); // for child then parent sees it in pending which means he can accept or reject it
  ResultFuture<void> acceptTask(String id);
  ResultFuture<void> refuseTask(String id); //child refused the task
  ResultFuture<void> rejectTask(String id); // parent rejected the task
  ResultFuture<void> redoTask(String id);
  ResultFuture<void> suggestTask(TaskEntity task);
  ResultFuture<void> attachPhotoReport(
      {required String filePath,
      Sink<double>? progressSink,
      required String taskId,
      required NetworkAvatarEntity photo});
}
