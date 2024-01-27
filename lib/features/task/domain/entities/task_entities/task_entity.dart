import 'package:equatable/equatable.dart';
import 'package:flutter_achievments/core/common/avatar/avatar.dart';
import 'package:flutter_achievments/core/enums/task_state.dart';
import 'package:flutter_achievments/features/app/domain/shared_entities/child_entity.dart';
import 'package:flutter_achievments/features/task/domain/entities/shared/category_entity.dart';
import 'package:flutter_achievments/features/task/domain/entities/task_entities/task_avatar.dart';

abstract class TaskEntity extends Equatable {
  final String id;
  final String title;
  final String? description;
  final TaskStateEnum state;
  final TaskAvatar avatar;
  final CategoryEntity category;
  final int reward;
  final String parentId;
  final List<ChildEntity> children;
  final bool commonTask;
  final bool withoutChecking;
  final bool isPhotoReportIncluded;
  final AvatarEntity photoReport;
  final DateTime createdAt;
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
    required this.photoReport,
    required this.createdAt,
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
      ];
}
