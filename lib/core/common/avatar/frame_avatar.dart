// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';
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

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'avatar': avatar.toMap(),
      'backgroundColor': backgroundColor.value,
    };
  }

  FrameAvatarEntity copyWith({
    AvatarEntity? avatar,
    Color? backgroundColor,
  }) {
    return FrameAvatarEntity(
      avatar: avatar ?? this.avatar,
      backgroundColor: backgroundColor ?? this.backgroundColor,
    );
  }

  factory FrameAvatarEntity.fromMap(Map<String, dynamic> map) {
    return FrameAvatarEntity(
      avatar: AvatarEntity.fromMap(map['avatar'] as Map<String,dynamic>),
      backgroundColor: Color(map['backgroundColor'] as int),
    );
  }

}
