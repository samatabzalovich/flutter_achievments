part of 'task_bloc.dart';

sealed class TaskState extends Equatable {
  const TaskState();

  @override
  List<Object> get props => [];
}

class TaskInitial extends TaskState {
  const TaskInitial();
}

class TaskLoading extends TaskState {
  const TaskLoading();
}

class GettingTasks extends TaskState {
  const GettingTasks();
}

class TaskLoadingProress extends TaskState {
  final double progress;
  const TaskLoadingProress(this.progress);

  @override
  List<Object> get props => [
        progress,
      ];
}

class TaskEntityUpdated extends TaskState {
  final TaskEntity task;
  const TaskEntityUpdated(this.task);

  @override
  List<Object> get props => [
        task,
      ];
}

class TaskLoaded extends TaskState {
  final List<TaskEntity> tasks;
  const TaskLoaded({required this.tasks});
}

class TaskError extends TaskState {
  final String dialogTitle;
  final String dialogTitleText;
  const TaskError({required this.dialogTitle, required this.dialogTitleText});

  @override
  List<Object> get props => [dialogTitle, dialogTitleText, ];
}

class TaskTemlateSaved extends TaskState {
  const TaskTemlateSaved();
}

class TaskCreated extends TaskState {
  final TaskEntity task;
  final String taskId;
  const TaskCreated(
    this.task,
    this.taskId,
  );
}

class TaskPhotoReportAttached extends TaskState {
  final NetworkAvatarEntity photoReport;
  final String taskId;
  const TaskPhotoReportAttached(this.photoReport, this.taskId);

  @override
  List<Object> get props => [photoReport, taskId];
}

class TaskAvatarUploaded extends TaskState {
  final FrameAvatarEntity taskAvatar;
  final String taskId;
  const TaskAvatarUploaded(this.taskAvatar, this.taskId);

  @override
  List<Object> get props => [taskAvatar, taskId];
}

class TaskDeleted extends TaskState {
  final String taskId;
  const TaskDeleted(
    this.taskId,
  );
}