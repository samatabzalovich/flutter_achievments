import 'package:flutter_achievments/core/common/avatar/avatar.dart';
import 'package:flutter_achievments/core/enums/task_state.dart';
import 'package:flutter_achievments/core/enums/task_type.dart';
import 'package:flutter_achievments/features/task/data/models/shared/category_model.dart';
import 'package:flutter_achievments/features/task/data/models/task_models/task_avatar_model.dart';
import 'package:flutter_achievments/features/task/domain/entities/task_entities/task_entity.dart';

abstract class TaskModel extends TaskEntity {
  const TaskModel({
    required String id,
    required String title,
    required String? description,
    required TaskStateEnum state,
    required TaskAvatarModel avatar,
    required CategoryModel category,
    required int reward,
    required String parentId,
    required List<String> children,
    required bool commonTask,
    required bool withoutChecking,
    required bool isPhotoReportIncluded,
    required AvatarEntity photoReport,
    required DateTime createdAt,
    required TaskType type,
  }) : super(
          id: id,
          title: title,
          description: description,
          state: state,
          avatar: avatar,
          category: category,
          reward: reward,
          parentId: parentId,
          children: children,
          commonTask: commonTask,
          withoutChecking: withoutChecking,
          isPhotoReportIncluded: isPhotoReportIncluded,
          photoReport: photoReport,
          createdAt: createdAt,
          type: type,
        );

  Map<String, dynamic> toMap();
}
