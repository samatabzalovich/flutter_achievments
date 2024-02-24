import 'package:flutter_achievments/core/common/avatar/avatar.dart';
import 'package:flutter_achievments/core/enums/task_state.dart';
import 'package:flutter_achievments/core/enums/task_type.dart';
import 'package:flutter_achievments/features/task/domain/entities/shared/category_entity.dart';
import 'package:flutter_achievments/features/task/domain/entities/task_entities/task_avatar.dart';
import 'package:flutter_achievments/features/task/domain/entities/task_entities/task_entity.dart';

class OneTimeTaskEntity extends TaskEntity {
  final DateTime startDate;
  final DateTime deadLine;
  final DateTime startTime;
  final bool placedInSkipped;
  const OneTimeTaskEntity({
    required String id,
    required String title,
    String? description,
    required TaskStateEnum state,
    required TaskAvatarEntity avatar,
    required CategoryEntity category,
    required this.startDate,
    required this.deadLine,
    required this.startTime,
    required int reward,
    required String parentId,
    required List<String> children,
    required bool commonTask,
    required bool withoutChecking,
    required bool isPhotoReportIncluded,
    required AvatarEntity photoReport,
    required this.placedInSkipped,
    required DateTime createdAt,
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
          type: TaskType.oneTime,
        );
}
