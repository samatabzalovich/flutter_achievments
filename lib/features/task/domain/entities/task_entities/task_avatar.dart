// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';

import 'package:equatable/equatable.dart';

import 'package:flutter_achievments/core/common/avatar/avatar.dart';

class TaskAvatarEntity extends Equatable {
  final AvatarEntity avatar;
  final Color backgroundColor;
  const TaskAvatarEntity({
    required this.avatar,
    required this.backgroundColor,
  });
  
  @override
  List<Object> get props => [avatar, backgroundColor];

  
}
