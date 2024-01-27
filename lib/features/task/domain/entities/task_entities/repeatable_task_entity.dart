import 'package:flutter_achievments/core/common/avatar/avatar.dart';
import 'package:flutter_achievments/core/enums/task_state.dart';
import 'package:flutter_achievments/features/app/domain/shared_entities/child_entity.dart';
import 'package:flutter_achievments/features/task/domain/entities/shared/category_entity.dart';
import 'package:flutter_achievments/features/task/domain/entities/task_entities/task_avatar.dart';
import 'package:flutter_achievments/features/task/domain/entities/task_entities/task_entity.dart';

class RepeatableTask extends TaskEntity {
  final bool placedInSkipped;
  final List<int> repeatOnDays;
  final DateTime startTime;
  final int maximumReward;
  final bool isHidddenWhenMax;
  final bool isMandatory;
  const RepeatableTask({
    required String id,
    required String title,
    String? description,
    required DateTime date,
    required TaskStateEnum state,
    required TaskAvatar avatar,
    required CategoryEntity category,
    required this.startTime,
    required int reward,
    required String parentId,
    required List<ChildEntity> children,
    required bool commonTask,
    required bool withoutChecking,
    required bool isPhotoReportIncluded,
    required AvatarEntity photoReport,
    required this.placedInSkipped,
    required this.repeatOnDays,
    required this.maximumReward,
    required this.isHidddenWhenMax,
    required this.isMandatory,
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
        );
}
