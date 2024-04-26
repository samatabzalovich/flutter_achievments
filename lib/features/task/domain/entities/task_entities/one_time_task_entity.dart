import 'package:flutter/material.dart';
import 'package:flutter_achievments/core/common/avatar/avatar.dart';
import 'package:flutter_achievments/core/constant/colors.dart';
import 'package:flutter_achievments/core/enums/task_state.dart';
import 'package:flutter_achievments/core/enums/task_type.dart';
import 'package:flutter_achievments/features/task/data/models/task_models/one_time_task_model.dart';
import 'package:flutter_achievments/features/task/data/models/task_models/task_model.dart';
import 'package:flutter_achievments/features/task/domain/entities/shared/category_entity.dart';
import 'package:flutter_achievments/core/common/avatar/frame_avatar.dart';
import 'package:flutter_achievments/features/task/domain/entities/task_entities/task_entity.dart';

class OneTimeTaskEntity extends TaskEntity {
  final DateTime deadLine;
  final DateTime startTime;
  final bool placedInSkipped;
  const OneTimeTaskEntity({
    required String id,
    required String title,
    String? description,
    required TaskStateEnum state,
    required FrameAvatarEntity avatar,
    required CategoryEntity category,
    required this.deadLine,
    required this.startTime,
    required int reward,
    required String parentId,
    required List<String> children,
    required bool commonTask,
    required bool withoutChecking,
    required bool isPhotoReportIncluded,
    AvatarEntity? photoReport,
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

  factory OneTimeTaskEntity.mock() {
    return OneTimeTaskEntity(
      id: '1',
      title: 'Title',
      description: 'Description',
      state: TaskStateEnum.active,
      avatar: const FrameAvatarEntity(
        backgroundColor: redColor,
        avatar: NetworkAvatarEntity(
            'https://firebasestorage.googleapis.com/v0/b/flutter-achieve.appspot.com/o/avatars?alt=media&token=6797816a-bc63-4066-a9ac-2de4ff9b54af',
            crop: Rect.fromLTRB(0, 0, 0.667, 0.9999)),
      ),
      category: const CategoryEntity(
        id: '1',
        categoryImage: NetworkAvatarEntity(
          'https://s3-alpha-sig.figma.com/img/b691/a4cb/8aecece021b343047e393731f415791e?Expires=1710720000&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=WKcY-l6oQZSN8vr5oHszTeexRuwjXMq6Rb~so33Zx5dyWkx7e4qz1lI6JhA4~cPdIp2y6jbELySzTIxjY1J6IcCP1ATZ69kXb~2AD486yM4uTaWYFz8P51LGhgQO7iQS9MnzJ7MRyFrvkiTI9w-6sd4wJwgPq0x3XgQ-ktpcVZkDC2uG~wHemupbgytTgsRUnfI06v4PpLSymZqPeJQVuAiNT25TPB1ylm8LP1xZFV3HbqPAOe-SDWbfq-G8PiZvgLqP7-71DQJZoBKvP3UGR93DjMyF~XIT9xkiXBtfHZzoDjf2SmT~IjOOjGtZuae6h4U~DewsUWUlG4wQ6Moh~g__',
          crop: Rect.fromLTRB(0, 0, 1, 1),
        ),
        categoryName: 'Category',
        categoryDescription: 'Category description',
      ),
      deadLine: DateTime.now(),
      startTime: DateTime.now().subtract(const Duration(days: 2)),
      reward: 10,
      parentId: '1',
      children: const [
        '1',
      ],
      commonTask: false,
      withoutChecking: false,
      isPhotoReportIncluded: false,
      placedInSkipped: false,
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
    );
  }

  @override
  TaskModel toModel() {
    return OneTimeTaskModel.fromEntity(this);
  }
}
