import 'package:equatable/equatable.dart';
import 'package:flutter_achievments/core/common/avatar/avatar.dart';
import 'package:flutter_achievments/core/enums/task_state.dart';
import 'package:flutter_achievments/core/enums/task_type.dart';
import 'package:flutter_achievments/features/task/data/models/task_models/task_model.dart';
import 'package:flutter_achievments/features/task/domain/entities/shared/category_entity.dart';
import 'package:flutter_achievments/core/common/avatar/frame_avatar.dart';

abstract class TaskEntity extends Equatable {
  final String id;
  final String title;
  final String? description;
  final TaskStateEnum state;
  final FrameAvatarEntity avatar;
  final CategoryEntity category;
  final int reward;
  final String parentId;
  final List<String> children;
  final bool commonTask;
  final bool withoutChecking;
  final bool isPhotoReportIncluded;
  final AvatarEntity? photoReport;
  final DateTime createdAt;
  final TaskType type;
  const TaskEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.state,
    required this.avatar,
    required this.category,
    required this.reward,
    required this.parentId,
    required this.children,
    required this.commonTask,
    required this.withoutChecking,
    required this.isPhotoReportIncluded,
    this.photoReport,
    required this.createdAt,
    required this.type,
  });


  @override
  List<Object?> get props => [
        id,
        title,
        description,
        state,
        avatar,
        category,
        reward,
        parentId,
        children,
        commonTask,
        withoutChecking,
        isPhotoReportIncluded,
        photoReport,
        createdAt,
        type,
      ];

    TaskModel toModel();
}
