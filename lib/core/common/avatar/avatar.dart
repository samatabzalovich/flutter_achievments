
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart' show Image;
import 'package:flutter_achievments/core/enums/avatar_type.dart';

abstract class AvatarEntity extends Equatable {
  final String photoUrl;
  final AvatarType type;
  const AvatarEntity(
    this.photoUrl, {
    required this.type,
  });
  Map<String, dynamic> toMap();
  @override
  List<Object?> get props => [photoUrl, type];

  static AvatarEntity fromMap(Map<String, dynamic>? map) {
    late AvatarEntity avatarEntity;

    switch (map?['avatarType']) {
      case 'network':
        avatarEntity = NetworkAvatarEntity(
          map!['photoUrl'],
        );
        break;
      case 'asset':
        avatarEntity = AssetAvatarEntity(map!['photoUrl']);
        break;
      default:
        avatarEntity = const NoneAvatarEntity();
    }
    return avatarEntity;
  }
}

class NetworkAvatarEntity extends AvatarEntity {
  final Image? image;
  const NetworkAvatarEntity(super.path, {this.image})
      : super(type: AvatarType.network);

  @override
  List<Object?> get props => [photoUrl, type, image];

  NetworkAvatarEntity copyWith(
    String path, {
    Rect? crop,
    Image? image,
  }) {
    return NetworkAvatarEntity(
      path,
      image: image ?? this.image,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'photoUrl': photoUrl,
      'avatarType': type.name,
    };
  }
}

class AssetAvatarEntity extends AvatarEntity {
  const AssetAvatarEntity(super.path) : super(type: AvatarType.asset);

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'photoUrl': photoUrl,
      'avatarType': type.name,
    };
  }
}

class NoneAvatarEntity extends AvatarEntity {
  const NoneAvatarEntity() : super('', type: AvatarType.none);
  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'avatarType': type.name,
    };
  }
}
