import 'package:flutter_achievments/core/common/avatar/avatar.dart';
import 'package:flutter_achievments/features/task/data/models/task_models/task_model.dart';

abstract class RemoteTaskDataSource {
  Future<List<TaskModel>> getTasks({required DateTime selectedDate,
    int limit = 50,});
  Future<void> createTask(TaskModel task);
  Future<void> updateTask(TaskModel task);
  Future<void> deleteTask(String id);
  Future<void> completeTask(String id); // for child then parent sees it in pending which means he can accept or  it
  Future<void> acceptTask(String id);
  Future<void> refuseTask(String id);//child refused the task
  Future<void> rejectTask(String id);// parent rejected the task
  Future<void> redoTask(String id);
  Future<void> suggestTask(TaskModel task);
  Future<void> attachPhotoReport({required String filePath, Sink<double>? progressSink, required String taskId, required NetworkAvatarEntity photo});
}