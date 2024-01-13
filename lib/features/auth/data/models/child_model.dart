import 'package:flutter_achievments/core/common/entity/avatar.dart';
import 'package:flutter_achievments/core/enums/user_type.dart';
import 'package:flutter_achievments/features/auth/domain/entities/child_entity.dart';

class ChildModel extends ChildEntity {
  const ChildModel({
    required String id,
    required String name,
    required String email,
    required String photoUrl,
    required bool doesHavePhone,
    required String parentId,
    required AvatarType avatarType,
    required UserType userType,
    required Role role,
  }) : super(
          role: role,
          id: id,
          name: name,
          email: email,
          photoUrl: photoUrl,
          doesHavePhone: doesHavePhone,
          parentId: parentId,
          avatarType: avatarType,
          userType: userType,
        );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'doesHavePhone': doesHavePhone,
      'parentId': parentId,
      'id': id,
      'name': name,
      'email': email,
      'photoUrl': photoUrl,
      'avatarType': avatarType,
      'userType': userType,
      'role': role,
    };
  }

  factory ChildModel.fromMap(Map<String, dynamic> map) {
    return ChildModel(
      doesHavePhone: map['doesHavePhone'] as bool,
      parentId: map['parentId'] as String,
      id: map['id'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      photoUrl: map['photoUrl'] as String,
      avatarType: map['avatarType'] as AvatarType,
      userType: map['userType'] as UserType,
      role: map['role'] as Role,
    );
  }
}