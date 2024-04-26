import 'package:equatable/equatable.dart';
import 'package:flutter_achievments/core/common/avatar/frame_avatar.dart';
import 'package:flutter_achievments/core/usecase/usecase.dart';
import 'package:flutter_achievments/core/utils/typedefs.dart';
import 'package:flutter_achievments/features/task/domain/repositories/task_repository.dart';

class UploadAvatarUseCase
    extends UseCaseWithParams<void, UploadAvatarUseCaseParams> {
  final TaskRepo _repository;
  const UploadAvatarUseCase(this._repository);
  @override
  ResultFuture<void> call(UploadAvatarUseCaseParams params) async {
    return _repository.uploadAvatar(
        filePath: params.photo.avatar.photoUrl,
        progressSink: params.progressSink,
        photo: params.photo,
        taskId: params.taskId);
  }
}

class UploadAvatarUseCaseParams extends Equatable {
  final Sink<double>? progressSink;
  final FrameAvatarEntity photo;
  final String taskId;

  const UploadAvatarUseCaseParams(
      {this.progressSink, required this.photo, required this.taskId});

  @override
  List<Object?> get props => [progressSink, photo, taskId];
}
