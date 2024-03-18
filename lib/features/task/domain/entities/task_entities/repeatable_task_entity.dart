import 'dart:ui';

import 'package:flutter_achievments/core/common/avatar/avatar.dart';
import 'package:flutter_achievments/core/constant/colors.dart';
import 'package:flutter_achievments/core/enums/task_state.dart';
import 'package:flutter_achievments/core/enums/task_type.dart';
import 'package:flutter_achievments/features/task/domain/entities/shared/category_entity.dart';
import 'package:flutter_achievments/core/common/avatar/frame_avatar.dart';
import 'package:flutter_achievments/features/task/domain/entities/task_entities/task_entity.dart';

class RepeatableTaskEntity extends TaskEntity {
  final bool placedInSkipped;
  final List<int> repeatOnDays;
  final DateTime startTime;
  final int maximumReward;
  final bool isHidddenWhenMax;
  final bool isMandatory;
  const RepeatableTaskEntity({
    required String id,
    required String title,
    String? description,
    required TaskStateEnum state,
    required FrameAvatarEntity avatar,
    required CategoryEntity category,
    required this.startTime,
    required int reward,
    required String parentId,
    required List<String> children,
    required bool commonTask,
    required bool withoutChecking,
    required bool isPhotoReportIncluded,
     AvatarEntity? photoReport,
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
          type: TaskType.repeatable,
        );

        factory RepeatableTaskEntity.mock() {
    return RepeatableTaskEntity(
      id: '3',
      title: 'Title',
      description: 'Description',
      state: TaskStateEnum.active,
      avatar: const FrameAvatarEntity(
        backgroundColor: lightBlue,
        avatar: NetworkAvatarEntity(
            'https://firebasestorage.googleapis.com/v0/b/flutter-achieve.appspot.com/o/avatars?alt=media&token=6cdc35c2-5d07-45e0-b215-058d65edd553',
            crop: Rect.fromLTRB(0.7103274559193961, 0.5902602854743917, 1, 0.9764903442485303)),
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
      repeatOnDays: const [1, 2, 3, 4, 5, 6, 7],
      startTime: DateTime.now(),
      reward: 10,
      parentId: '1',
      children: const [
        '1',
      ],
      commonTask: false,
      withoutChecking: false,
      isPhotoReportIncluded: false,
      placedInSkipped: false,
      createdAt: DateTime.now(),
      maximumReward: 100,
      isHidddenWhenMax: true,
      isMandatory: true,
    );
  }
}
