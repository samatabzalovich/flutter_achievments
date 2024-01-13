import 'dart:ui' show Rect;

import 'package:flutter_achievments/core/common/avatar/avatar.dart';
import 'package:flutter_achievments/core/enums/user_type.dart';
import 'package:flutter_achievments/features/app/domain/shared_entities/child_entity.dart';

class ChildModel extends ChildEntity {
  const ChildModel({
    required String id,
    required String name,
    required String email,
    required bool withoutPhone,
    required String parentId,
    required AvatarEntity avatar,
    required UserType userType,
    required Role role,
    required DateTime birthDate,
  }) : super(
          role: role,
          id: id,
          name: name,
          email: email,
          withoutPhone: withoutPhone,
          parentId: parentId,
          avatar: avatar,
          userType: userType,
          birthDate: birthDate,
        );
  @override
   Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'avatar': avatar.toMap(),
      'userType': userType.toString(),
      'role': role.toString(),
      'parentId': parentId,
      'withoutPhone': withoutPhone,
      'birthDate': birthDate.toIso8601String(),
    };
  }

  static ChildEntity fromMap(Map<String, dynamic> map, String uid) {
    late AvatarEntity avatarEntity;
    switch (map['avatarType']) {
      case 'network':
        avatarEntity = NetworkAvatarEntity(
          map['photoUrl'],
          crop: Rect.fromLTRB(
              map['avatar']['crop']['left'],
              map['avatar']['crop']['top'],
              map['avatar']['crop']['right'],
              map['avatar']['crop']['bottom']),
        );
        break;
      case 'AvatarType.asset':
        avatarEntity = AssetAvatarEntity(map['photoUrl']);
        break;
      default:
        avatarEntity = const NoneAvatarEntity();
    }
    return ChildEntity(
      id: uid,
      name: map['name'],
      email: map['email'],
      avatar: avatarEntity,
      userType: UserType.fromString(map['userType']),
      role: Role.fromString(map['role']),
      parentId: map['parentId'],
      withoutPhone: map['withoutPhone'],
      birthDate: DateTime.parse(map['birthDate']),
    );
  }

  static ChildModel fromEntity(ChildEntity entity) {
    return ChildModel(
      id: entity.id,
      name: entity.name ?? '',
      email: entity.email,
      avatar: entity.avatar,
      userType: entity.userType,
      role: entity.role ?? Role.unknown,
      parentId: entity.parentId ?? '',
      withoutPhone: entity.withoutPhone,
      birthDate: entity.birthDate,
    );
  }
}