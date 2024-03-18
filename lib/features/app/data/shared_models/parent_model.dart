import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_achievments/core/common/avatar/avatar.dart';
import 'package:flutter_achievments/core/enums/user_type.dart';
import 'package:flutter_achievments/features/app/data/shared_models/child_model.dart';
import 'package:flutter_achievments/features/app/data/shared_models/user_model.dart';
import 'package:flutter_achievments/features/app/domain/shared_entities/parent_entity.dart';

class ParentModel extends ParentEntity implements UserModel {
  const ParentModel({
    required String id,
    String? name,
    required String email,
    AvatarEntity avatarEntity = const NoneAvatarEntity(),
    required UserType userType,
    Role? role,
    bool isRoleShown = false,
    List<ChildModel>? children,
    required DateTime createdAt,
  }) : super(
          id: id,
          name: name,
          userType: userType,
          email: email,
          role: role,
          isRoleShown: isRoleShown,
          children: children,
          avatarEntity: avatarEntity,
          createdAt: createdAt,
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
      'createdAt': FieldValue.serverTimestamp(),
    };
  }

  static ParentModel fromMap(Map<String, dynamic> map, String uid) {
    return ParentModel(
      id: uid,
      name: map['name'],
      email: map['email'],
      avatarEntity:
          AvatarEntity.fromMap(map['avatar']),
      userType: UserType.fromString(map['userType']),
      role: map['role'] != null ? Role.fromString(map['role']) : null,
      isRoleShown: map['isRoleShown'] ?? false,
      children: map['children'] != null
          ? List<ChildModel>.from(
              map['children'].map((x) => ChildModel.fromMap(x, x['id'])))
          : null,
      createdAt: DateTime.fromMicrosecondsSinceEpoch(
              ((map['createdAt'] as Timestamp?) == null ? DateTime.now().microsecondsSinceEpoch: (map['createdAt'] as Timestamp).microsecondsSinceEpoch))
          .toLocal(),
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
      createdAt: entity.createdAt,
    );
  }
}
