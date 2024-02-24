import 'dart:ui' show Color;

import 'package:flutter_achievments/core/common/avatar/avatar.dart';
import 'package:flutter_achievments/features/task/domain/entities/task_entities/task_avatar.dart';

class TaskAvatarModel extends TaskAvatarEntity {
  const TaskAvatarModel({
    required super.avatar,
    required super.backgroundColor
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'avatar': avatar.toMap(),
      'backgroundColor': backgroundColor.value,
    };
  }

  factory TaskAvatarModel.fromMap(Map<String, dynamic> map) {
    return TaskAvatarModel(
      avatar: AvatarEntity.fromMap(map['avatar'] as Map<String,dynamic>),
      backgroundColor: Color(map['backgroundColor'] as int),
    );
  }

  TaskAvatarModel copyWith({
    AvatarEntity? avatar,
    Color? backgroundColor,
  }) {
    return TaskAvatarModel(
      avatar: avatar ?? this.avatar,
      backgroundColor: backgroundColor ?? this.backgroundColor,
    );
  }
}