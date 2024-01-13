// ignore_for_file: public_member_api_docs, sort_constructors_first


import 'dart:ui' show Rect;

import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart' show Image;

abstract class AvatarEntity extends Equatable {
  final String path;
  final AvatarType type;
  const AvatarEntity(
    this.path, {
    required this.type,
  });

  @override
  List<Object?> get props => [path, type];
}

class NetworkAvatarEntity extends AvatarEntity {
  final Rect crop;
  final Image? image;
  const NetworkAvatarEntity(String path, {required this.crop, this.image}) : super(path, type: AvatarType.network);
  

  @override
  List<Object?> get props => [path, type, crop, image];

  NetworkAvatarEntity copyWith(
    String path,
    {
    Rect? crop,
    Image? image,
  }) {
    return NetworkAvatarEntity(
      path,
      crop: crop ?? this.crop,
      image: image ?? this.image,
    );
  }
}

class AssetAvatarEntity extends AvatarEntity {
  const AssetAvatarEntity(String path) : super(path, type: AvatarType.asset);
}

class NoneAvatarEntity extends AvatarEntity {
  const NoneAvatarEntity() : super('', type: AvatarType.none);
}

enum AvatarType {
  network,
  asset,
  none;
}
