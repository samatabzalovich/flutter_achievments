import 'dart:async';
import 'dart:ui' as ui show Image, Rect, Size, decodeImageFromList;

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
          crop: Rect.fromLTRB(map['crop']['left'], map['crop']['top'],
              map['crop']['right'], map['crop']['bottom']),
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
  final Rect crop;
  final Image? image;
  const NetworkAvatarEntity(String path, {required this.crop, this.image})
      : super(path, type: AvatarType.network);

  @override
  List<Object?> get props => [photoUrl, type, crop, image];

  NetworkAvatarEntity copyWith(
    String path, {
    Rect? crop,
    Image? image,
  }) {
    return NetworkAvatarEntity(
      path,
      crop: crop ?? this.crop,
      image: image ?? this.image,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'photoUrl': photoUrl,
      'avatarType': type.name,
      'crop': {
        'left': crop.left,
        'top': crop.top,
        'right': crop.right,
        'bottom': crop.bottom,
      }
    };
  }

  Future<ui.Image> loadImage() async {
    final ByteData data =
        await NetworkAssetBundle(Uri.parse(photoUrl)).load("");
    final Completer<ui.Image> completer = Completer();
    ui.decodeImageFromList(data.buffer.asUint8List(), (ui.Image img) {
      return completer.complete(img);
    });
    return completer.future;
  }
}

class AssetAvatarEntity extends AvatarEntity {
  const AssetAvatarEntity(String path) : super(path, type: AvatarType.asset);

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

extension RectExtensions on ui.Rect {
  ui.Rect multiply(ui.Size size) => ui.Rect.fromLTRB(
        left * size.width,
        top * size.height,
        right * size.width,
        bottom * size.height,
      );

  ui.Rect divide(ui.Size size) => ui.Rect.fromLTRB(
        left / size.width,
        top / size.height,
        right / size.width,
        bottom / size.height,
      );
}
