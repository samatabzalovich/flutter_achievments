// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_achievments/core/common/avatar/avatar.dart';
import 'package:flutter_achievments/core/common/avatar/frame_avatar.dart';
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
import 'package:flutter_achievments/features/task/domain/usecases/task_use_cases/upload_avatar.dart';
import 'package:flutter_achievments/features/task/presentation/provider/task_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  final GetTaskUseCase _getTaskUseCase;
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
  final UploadAvatarUseCase _uploadAvatarUseCase;
  final _getTasksSubject = PublishSubject<GetTaskWithDebounceParams>();
  late StreamSubscription<GetTaskWithDebounceParams> _getTasksSubscription;

  TaskCubit(
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
    this._uploadAvatarUseCase,
  ) : super(const TaskInitial()) {
    _getTasksSubscription = _getTasksSubject //TODO: listener dispose if needed
        .distinct(
          (previous, next) =>
              previous.selectedDate == next.selectedDate &&
              previous.limit == next.limit &&
              previous.userId == next.userId &&
              previous.performer == next.performer,
        )
        .debounceTime(const Duration(milliseconds: 700))
        .listen(
      (event) {
        _getTasksWithDebounce(
          selectedDate: event.selectedDate,
          limit: event.limit,
          userId: event.userId,
          performer: event.performer,
          context: event.context,
        );
      },
    );
  }

  void getTasks(
      {required DateTime selectedDate,
      int limit = 50,
      required String userId,
      String performer = '',
      required BuildContext context}) {
    emit(const GettingTasks());
    _getTasksSubject.add(GetTaskWithDebounceParams(
      selectedDate: selectedDate,
      limit: limit,
      userId: userId,
      performer: performer,
      context: context,
    ));
  }

  void _getTasksWithDebounce(
      {required DateTime selectedDate,
      int limit = 50,
      required String userId,
      String performer = '',
      required BuildContext context}) async {
    final startOfDay = DateTime(
        selectedDate.year, selectedDate.month, selectedDate.day, 0, 0, 0);
    final tasksFromProvider =
        context.read<TaskProvider>().getTasksForSelectedDate(startOfDay);
    if (tasksFromProvider == null) {
      final result = await _getTaskUseCase(GetTaskUseCaseParams(
          selectedDate, limit,
          userId: userId, performer: performer));

      result.fold(
        (failure) => emit(
            const TaskError(dialogTitle: 'Error', dialogTitleText: 'Error')),
        (tasks) {
          context.read<TaskProvider>().setTasks(tasks, startOfDay);
          emit(TaskLoaded(
              tasks: tasks,
              userId: userId,
              performer: performer,
              selectedDate: selectedDate));
        },
      );
      return;
    }
    emit(TaskLoaded(
        tasks: tasksFromProvider,
        userId: userId,
        performer: performer,
        selectedDate: selectedDate));
  }

  void createTask(TaskEntity task) async {
    emit(const TaskLoading());
    final result = await _createTaskUseCase(task);
    result.fold(
      (failure) =>
          emit(const TaskError(dialogTitle: 'Error', dialogTitleText: 'Error')),
      (id) => emit(TaskCreated(
        task,
        id,
      )),
    );
  }

  // void acceptTask(String id) async {
  //   emit(const TaskLoading());
  //   final result = await _acceptTaskUseCase(id);
  //   result.fold(
  //     (failure) =>
  //         emit(const TaskError(dialogTitle: 'Error', dialogTitleText: 'Error')),
  //     (_) => getTasks(
  //       selectedDate: DateTime.now(),
  //     ),
  //   );
  // }

  void attachPhotoReport(
      {required String taskId,
      required NetworkAvatarEntity photoReport}) async {
    emit(const TaskLoadingProress(0));

    final reportUploadProgress = BehaviorSubject<double>();
    double progress = 0;
    final sub = reportUploadProgress.listen((value) {
      emit(TaskLoadingProress(value == 100 ? 99.9 : value));
      progress = value;
    });
    final result = await _attachPhotoReportUseCase(AttachPhotoReportParams(
        progressSink: reportUploadProgress,
        photo: photoReport,
        taskId: taskId));
    await sub.cancel();
    await reportUploadProgress.close();
    emit(TaskLoadingProress(progress));
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

  void uploadAvatar(
      {required TaskEntity task,
      required FrameAvatarEntity photo,
      required String taskId}) async {
    emit(const TaskLoadingProress(0));
    final reportUploadProgress = BehaviorSubject<double>();
    double progress = 0;
    final sub = reportUploadProgress.listen((value) {
      emit(TaskLoadingProress(value == 100 ? 99 : value));
      progress = value;
    });
    final result = await _uploadAvatarUseCase(UploadAvatarUseCaseParams(
        progressSink: reportUploadProgress, photo: photo, taskId: taskId));

    await sub.cancel();
    await reportUploadProgress.close();
    emit(TaskLoadingProress(progress));
    result.fold(
      (failure) => emit(TaskError(
          dialogTitle: failure.dialogTitle,
          dialogTitleText: failure.dialogText)),
      (_) => emit(TaskAvatarUploaded(photo, task, taskId)),
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
      (id) => TaskCreated(taskEntity, id),
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

  @override
  Future<void> close() {
    _getTasksSubscription.cancel();
    _getTasksSubject.close();
    return super.close();
  }
}

class GetTaskWithDebounceParams {
  final DateTime selectedDate;
  final int limit;
  final String userId;
  final String performer;
  final BuildContext context;
  GetTaskWithDebounceParams({
    required this.selectedDate,
    this.limit = 50,
    required this.userId,
    this.performer = '',
    required this.context,
  });
}
