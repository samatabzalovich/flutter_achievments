import 'package:equatable/equatable.dart';
import 'package:flutter_achievments/core/common/avatar/avatar.dart';
import 'package:flutter_achievments/core/usecase/usecase.dart';
import 'package:flutter_achievments/core/utils/typedefs.dart';
import 'package:flutter_achievments/features/task/domain/repositories/task_repository.dart';

class AttachPhotoReportUseCase
    extends UseCaseWithParams<void, AttachPhotoReportParams> {
  final TaskRepo _repository;
  const AttachPhotoReportUseCase(this._repository);
  @override
  ResultFuture<void> call(AttachPhotoReportParams params) async {
    return _repository.attachPhotoReport(
        filePath: params.photo.photoUrl,
        progressSink: params.progressSink,
        photo: params.photo,
        taskId: params.taskId);
  }
}

class AttachPhotoReportParams extends Equatable {
  final Sink<double>? progressSink;
  final NetworkAvatarEntity photo;
  final String taskId;

  const AttachPhotoReportParams(
      {this.progressSink, required this.photo, required this.taskId});

  @override
  List<Object?> get props => [progressSink, photo, taskId];
}
