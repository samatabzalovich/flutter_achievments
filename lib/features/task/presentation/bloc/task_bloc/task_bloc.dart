import 'package:equatable/equatable.dart';
import 'package:flutter_achievments/core/common/avatar/avatar.dart';
import 'package:flutter_achievments/features/task/domain/entities/task_entities/task_entity.dart';
import 'package:flutter_achievments/features/task/domain/usecases/task_use_cases/accept_task.dart';
import 'package:flutter_achievments/features/task/domain/usecases/task_use_cases/attach_photo_report.dart';
import 'package:flutter_achievments/features/task/domain/usecases/task_use_cases/complete_task.dart';
import 'package:flutter_achievments/features/task/domain/usecases/task_use_cases/create_task.dart';
import 'package:flutter_achievments/features/task/domain/usecases/task_use_cases/delete_task.dart';
import 'package:flutter_achievments/features/task/domain/usecases/task_use_cases/get_task.dart';
import 'package:flutter_achievments/features/task/domain/usecases/task_use_cases/redo_task.dart';
import 'package:flutter_achievments/features/task/domain/usecases/task_use_cases/refuse_task.dart';
import 'package:flutter_achievments/features/task/domain/usecases/task_use_cases/reject_task.dart';
import 'package:flutter_achievments/features/task/domain/usecases/task_use_cases/suggest_task.dart';
import 'package:flutter_achievments/features/task/domain/usecases/task_use_cases/update_task.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Cubit<TaskState> {
  final  GetTaskUseCase _getTaskUseCase;
  final CreateTaskUseCase _createTaskUseCase;
  final AcceptTaskUseCase _acceptTaskUseCase;
  final AttachPhotoReportUseCase _attachPhotoReportUseCase;
  final CompleteTaskUseCase _completeTaskUseCase;
  final DeleteTaskUseCase _deleteTaskUseCase;
  final RedoTaskUseCase _redoTaskUseCase;
  final RefuseTaskUseCase _refuseTaskUseCase;
  final RejectTaskUseCase _rejectTaskUseCase;
  final SuggestTaskUseCase _suggestTaskUseCase;
  final UpdateTaskUseCase _updateTaskUseCase;

  TaskBloc(
    this._getTaskUseCase,
    this._createTaskUseCase,
    this._acceptTaskUseCase,
    this._attachPhotoReportUseCase,
    this._completeTaskUseCase,
    this._deleteTaskUseCase,
    this._redoTaskUseCase,
    this._refuseTaskUseCase,
    this._rejectTaskUseCase,
    this._suggestTaskUseCase,
    this._updateTaskUseCase,
  ) : super(const TaskInitial());

  void getTasks({required DateTime selectedDate, int limit = 50}) async {
    emit(const TaskLoading());
    final result =
        await _getTaskUseCase(GetTaskUseCaseParams(selectedDate, limit));
    result.fold(
      (failure) =>
          emit(const TaskError(dialogTitle: 'Error', dialogTitleText: 'Error')),
      (tasks) => emit(TaskLoaded(tasks: tasks)),
    );
  }

  void createTask(TaskEntity task) async {
    emit(const TaskLoading());
    final result = await _createTaskUseCase(task);
    result.fold(
      (failure) =>
          emit(const TaskError(dialogTitle: 'Error', dialogTitleText: 'Error')),
      (_) => emit(TaskCreated(
        task,
      )),
    );
  }

  void acceptTask(String id) async {
    emit(const TaskLoading());
    final result = await _acceptTaskUseCase(id);
    result.fold(
      (failure) =>
          emit(const TaskError(dialogTitle: 'Error', dialogTitleText: 'Error')),
      (_) => getTasks(
        selectedDate: DateTime.now(),
      ),
    );
  }

  void attachPhotoReport(
      {required String taskId,
      required NetworkAvatarEntity photoReport}) async {
    emit(const TaskLoadingProress(0));
    final reportUploadProgress = BehaviorSubject<double>();
    final result = await _attachPhotoReportUseCase(AttachPhotoReportParams(
        progressSink: reportUploadProgress,
        photo: photoReport,
        taskId: taskId));
    double progress = 0;
    final sub = reportUploadProgress.listen((value) {
      emit(TaskLoadingProress(value == 100 ? 99.9 : value));
      progress = value;
    });
    emit(TaskLoadingProress(progress));
    sub.cancel();
    reportUploadProgress.close();
    result.fold(
      (failure) => emit(TaskError(
          dialogTitle: failure.dialogTitle,
          dialogTitleText: failure.dialogText)),
      (_) => TaskPhotoReportAttached(
        photoReport,
        taskId,
      ),
    );
  }

  void completeTask(TaskEntity task) async {
    emit(const TaskLoading());
    final result = await _completeTaskUseCase(task.id);
    result.fold(
      (failure) =>
          emit(const TaskError(dialogTitle: 'Error', dialogTitleText: 'Error')),
      (_) => TaskEntityUpdated(task),
    );
  }

  void deleteTask(String id) async {
    emit(const TaskLoading());
    final result = await _deleteTaskUseCase(id);
    result.fold(
      (failure) =>
          emit(const TaskError(dialogTitle: 'Error', dialogTitleText: 'Error')),
      (_) => TaskDeleted(id),
    );
  }

  void redoTask(TaskEntity taskEntity) async {
    emit(const TaskLoading());
    final result = await _redoTaskUseCase(taskEntity.id);
    result.fold(
      (failure) =>
          emit(const TaskError(dialogTitle: 'Error', dialogTitleText: 'Error')),
      (_) => TaskEntityUpdated(taskEntity),
    );
  }

  void refuseTask(TaskEntity taskEntity) async {
    emit(const TaskLoading());
    final result = await _refuseTaskUseCase(taskEntity.id);
    result.fold(
      (failure) =>
          emit(const TaskError(dialogTitle: 'Error', dialogTitleText: 'Error')),
      (_) => TaskEntityUpdated(taskEntity),
    );
  }

  void rejectTask(TaskEntity taskEntity) async {
    emit(const TaskLoading());
    final result = await _rejectTaskUseCase(taskEntity.id);
    result.fold(
      (failure) =>
          emit(const TaskError(dialogTitle: 'Error', dialogTitleText: 'Error')),
      (_) => TaskEntityUpdated(taskEntity),
    );
  }

  void suggestTask(TaskEntity taskEntity) async {
    emit(const TaskLoading());
    final result = await _suggestTaskUseCase(taskEntity);
    result.fold(
      (failure) =>
          emit(const TaskError(dialogTitle: 'Error', dialogTitleText: 'Error')),
      (_) => TaskCreated(taskEntity),
    );
  }

  void updateTask(TaskEntity taskEntity) async {
    emit(const TaskLoading());
    final result = await _updateTaskUseCase(taskEntity);
    result.fold(
      (failure) =>
          emit(const TaskError(dialogTitle: 'Error', dialogTitleText: 'Error')),
      (_) => TaskEntityUpdated(taskEntity),
    );
  }
}
