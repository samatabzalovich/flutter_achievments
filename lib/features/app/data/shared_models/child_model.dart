import 'dart:ui' show Rect;

import 'package:flutter_achievments/core/common/avatar/avatar.dart';
import 'package:flutter_achievments/core/enums/user_type.dart';
import 'package:flutter_achievments/features/app/data/shared_models/parent_model.dart';
import 'package:flutter_achievments/features/app/data/shared_models/user_model.dart';
import 'package:flutter_achievments/features/app/domain/shared_entities/child_entity.dart';

class ChildModel extends UserModel {
  final bool withoutPhone;
  final String? parentId;
    final List<ParentModel>? parents;
  final DateTime birthDate;
  const ChildModel({
    required String id,
    String? name,
    required String email,
    AvatarEntity avatar = const NoneAvatarEntity(),
    required UserType userType,
    this.parentId,
    this.withoutPhone = false,
    this.parents,
    Role? role,
    required this.birthDate,
  }) : super(
          role: role,
          id: id,
          name: name,
          email: email,
          avatar: avatar,
          userType: userType,
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
      'parentId': parentId,
      'withoutPhone': withoutPhone,
      'birthDate': birthDate.toIso8601String(),
    };
  }

  static ChildModel fromMap(Map<String, dynamic> map, String uid) {
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
    return ChildModel(
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

  @override
  ChildModel copyWith(
      {String? id,
      String? name,
      String? email,
      AvatarEntity? avatar,
      UserType? userType,
      Role? role,
      bool? isRoleShown,
      List<ChildEntity>? children,
      String? parentId,
      bool? withoutPhone,
      DateTime? birthDate}) {
    return ChildModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      avatar: avatar ?? this.avatar,
      userType: userType ?? this.userType,
      role: role ?? this.role,
      parentId: parentId ?? this.parentId,
      withoutPhone: withoutPhone ?? this.withoutPhone,
      birthDate: birthDate ?? this.birthDate,
    );
      }
}
