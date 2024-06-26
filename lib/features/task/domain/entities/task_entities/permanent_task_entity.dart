import 'dart:ui';

import 'package:flutter_achievments/core/common/avatar/avatar.dart';
import 'package:flutter_achievments/core/common/avatar/frame_avatar.dart';
import 'package:flutter_achievments/core/constant/colors.dart';
import 'package:flutter_achievments/core/enums/task_state.dart';
import 'package:flutter_achievments/core/enums/task_type.dart';
import 'package:flutter_achievments/features/task/data/models/task_models/permanent_task_model.dart';
import 'package:flutter_achievments/features/task/data/models/task_models/task_model.dart';
import 'package:flutter_achievments/features/task/domain/entities/shared/category_entity.dart';
import 'package:flutter_achievments/features/task/domain/entities/task_entities/task_entity.dart';

class PermanentTaskEntity extends TaskEntity {
  final int maximumReward;
  final bool isHidddenWhenMax;
  final bool isMandatory;
  final int taskCompletionNumber;
  const PermanentTaskEntity({
    required super.id,
    required super.title,
    super.description,
    required super.state,
    required super.avatar,
    required super.category,
    required super.reward,
    required super.parentId,
    required super.children,
    required super.commonTask,
    required super.withoutChecking,
    required super.isPhotoReportIncluded,
    super.photoReport,
    required this.maximumReward,
    required this.isHidddenWhenMax,
    required this.isMandatory,
    required super.createdAt,
    required this.taskCompletionNumber,
  }) : super(
          type: TaskType.permanent,
        );

  factory PermanentTaskEntity.mock() {
    return PermanentTaskEntity(
      id: '2',
      title: 'Title',
      description: 'Description',
      state: TaskStateEnum.active,
      avatar: const FrameAvatarEntity(
        backgroundColor: lightBlue,
        avatar: NetworkAvatarEntity(
            'https://firebasestorage.googleapis.com/v0/b/flutter-achieve.appspot.com/o/avatars%2FQKszsTsKZdhmrCszeKya042TGQ62?alt=media&token=f12e853d-c6b3-44e5-8bd7-4869460061c0',
           ),
      ),
      category: const CategoryEntity(
        id: '1',
        categoryImage: NetworkAvatarEntity(
          'https://s3-alpha-sig.figma.com/img/b691/a4cb/8aecece021b343047e393731f415791e?Expires=1710720000&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=WKcY-l6oQZSN8vr5oHszTeexRuwjXMq6Rb~so33Zx5dyWkx7e4qz1lI6JhA4~cPdIp2y6jbELySzTIxjY1J6IcCP1ATZ69kXb~2AD486yM4uTaWYFz8P51LGhgQO7iQS9MnzJ7MRyFrvkiTI9w-6sd4wJwgPq0x3XgQ-ktpcVZkDC2uG~wHemupbgytTgsRUnfI06v4PpLSymZqPeJQVuAiNT25TPB1ylm8LP1xZFV3HbqPAOe-SDWbfq-G8PiZvgLqP7-71DQJZoBKvP3UGR93DjMyF~XIT9xkiXBtfHZzoDjf2SmT~IjOOjGtZuae6h4U~DewsUWUlG4wQ6Moh~g__',
        ),
        categoryName: 'Category',
        categoryDescription: 'Category description',
      ),
      reward: 10,
      parentId: '1',
      children: const [
        '1',
      ],
      commonTask: false,
      withoutChecking: false,
      isPhotoReportIncluded: false,
      taskCompletionNumber: 0,
      createdAt: DateTime.now(),
      maximumReward: 100,
      isHidddenWhenMax: true,
      isMandatory: true,
    );
  }

  @override
  TaskModel toModel() {
    return PermanentTaskModel.fromEntity(this);
  }


  PermanentTaskEntity copyWith({
    String? id,
    String? title,
    String? description,
    TaskStateEnum? state,
    FrameAvatarEntity? avatar,
    CategoryEntity? category,
    int? reward,
    String? parentId,
    List<String>? children,
    bool? commonTask,
    bool? withoutChecking,
    bool? isPhotoReportIncluded,
    AvatarEntity? photoReport,
    int? maximumReward,
    bool? isHidddenWhenMax,
    bool? isMandatory,
    DateTime? createdAt,
    int? taskCompletionNumber,
  }) {
    return PermanentTaskEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      state: state ?? this.state,
      avatar: avatar ?? this.avatar,
      category: category ?? this.category,
      reward: reward ?? this.reward,
      parentId: parentId ?? this.parentId,
      children: children ?? this.children,
      commonTask: commonTask ?? this.commonTask,
      withoutChecking: withoutChecking ?? this.withoutChecking,
      isPhotoReportIncluded: isPhotoReportIncluded ?? this.isPhotoReportIncluded,
      photoReport: photoReport ?? this.photoReport,
      maximumReward: maximumReward ?? this.maximumReward,
      isHidddenWhenMax: isHidddenWhenMax ?? this.isHidddenWhenMax,
      isMandatory: isMandatory ?? this.isMandatory,
      createdAt: createdAt ?? this.createdAt,
      taskCompletionNumber: taskCompletionNumber ?? this.taskCompletionNumber,
    );
  }
}
