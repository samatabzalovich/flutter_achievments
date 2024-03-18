
import 'dart:ui';

import 'package:equatable/equatable.dart';

import 'package:flutter_achievments/core/common/avatar/avatar.dart';

class FrameAvatarEntity extends Equatable {
  final AvatarEntity avatar;
  final Color backgroundColor;
  const FrameAvatarEntity({
    required this.avatar,
    required this.backgroundColor,
  });
  
  @override
  List<Object> get props => [avatar, backgroundColor];

  
}
