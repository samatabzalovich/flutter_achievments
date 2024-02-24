import 'package:flutter_achievments/core/common/avatar/avatar.dart';
import 'package:flutter_achievments/core/enums/task_state.dart';
import 'package:flutter_achievments/core/enums/task_type.dart';
import 'package:flutter_achievments/features/task/domain/entities/shared/category_entity.dart';
import 'package:flutter_achievments/features/task/domain/entities/task_entities/task_avatar.dart';
import 'package:flutter_achievments/features/task/domain/entities/task_entities/task_entity.dart';

class PermanentTaskEntity extends TaskEntity {
  final List<int> repeatOnDays;
  final int maximumReward;
  final bool isHidddenWhenMax;
  final bool isMandatory;
  const PermanentTaskEntity({
    required String id,
    required String title,
    String? description,
    required TaskStateEnum state,
    required TaskAvatarEntity avatar,
    required CategoryEntity category,
    required int reward,
    required String parentId,
    required List<String> children,
    required bool commonTask,
    required bool withoutChecking,
    required bool isPhotoReportIncluded,
    required AvatarEntity photoReport,
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
          type: TaskType.permanent,
        );
}
