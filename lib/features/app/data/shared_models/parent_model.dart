import 'dart:ui' show Rect;

import 'package:flutter_achievments/core/common/avatar/avatar.dart';
import 'package:flutter_achievments/core/enums/user_type.dart';
import 'package:flutter_achievments/features/app/domain/shared_entities/parent_entity.dart';

class ParentModel extends ParentEntity {
  const ParentModel({
    required String id,
    String? name,
    required String email,
    bool isRoleShown = false,
    AvatarEntity avatarEntity = const NoneAvatarEntity(),
    required UserType userType,
    Role? role,
  }) : super(
          id: id,
          avatarEntity: avatarEntity,
          name: name,
          userType: userType,
          email: email,
          isRoleShown: isRoleShown,
          role: role,
        );
  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'avatar': avatar.toMap(),
      'userType': userType.toString(),
      'role': role?.toString(),
      'isRoleShown': isRoleShown,
    };
  }

  static ParentEntity fromMap(Map<String, dynamic> map, String uid) {
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
    return ParentEntity(
      id: uid,
      name: map['name'],
      email: map['email'],
      avatarEntity: avatarEntity,
      userType: UserType.fromString(map['userType']),
      role: map['role'] != null ?  Role.fromString(map['role']) : null,
      isRoleShown: map['isRoleShown'] ?? false,
    );
  }
}
