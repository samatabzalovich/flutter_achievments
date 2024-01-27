import 'dart:ui' show Rect;

import 'package:flutter_achievments/core/common/avatar/avatar.dart';
import 'package:flutter_achievments/core/enums/user_type.dart';
import 'package:flutter_achievments/features/app/data/shared_models/child_model.dart';
import 'package:flutter_achievments/features/app/data/shared_models/user_model.dart';
import 'package:flutter_achievments/features/app/domain/shared_entities/parent_entity.dart';

class ParentModel extends UserModel {
  final bool isRoleShown;
  final List<ChildModel>? children;
  const ParentModel({
    required String id,
    String? name,
    required String email,
    AvatarEntity avatarEntity = const NoneAvatarEntity(),
    required UserType userType,
    Role? role,
    this.isRoleShown = false,
    this.children,
  }) : super(
          id: id,
          avatar: avatarEntity,
          name: name,
          userType: userType,
          email: email,
          role: role,
        );
  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'avatar': avatar.toMap(),
      'userType': userType.name,
      'role': role?.name,
      'isRoleShown': isRoleShown,
    };
  }

  static ParentModel fromMap(Map<String, dynamic> map, String uid) {
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
    return ParentModel(
      id: uid,
      name: map['name'],
      email: map['email'],
      avatarEntity: avatarEntity,
      userType: UserType.fromString(map['userType']),
      role: map['role'] != null ?  Role.fromString(map['role']) : null,
      isRoleShown: map['isRoleShown'] ?? false,
      children: map['children'] != null
          ? List<ChildModel>.from(
              map['children'].map((x) => ChildModel.fromMap(x, x['id'])))
          : null,
    );
  }

  @override
  ParentModel copyWith({String? id, String? name, String? email, AvatarEntity? avatar, UserType? userType, Role? role, bool? isRoleShown, List<ChildModel>? children}) {
    return ParentModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      avatarEntity: avatar ?? this.avatar,
      userType: userType ?? this.userType,
      role: role ?? this.role,
      isRoleShown:  isRoleShown ?? this.isRoleShown,
      children: children ?? this.children,
    );
  }

  static ParentModel fromEntity(ParentEntity entity) {
    return ParentModel(
      id: entity.id,
      name: entity.name ?? '',
      email: entity.email,
      avatarEntity: entity.avatar,
      userType: entity.userType,
      role: entity.role ?? Role.unknown,
      isRoleShown: entity.isRoleShown,
      children: entity.children?.map((e) => ChildModel.fromEntity(e)).toList(),
    );
  }
}
