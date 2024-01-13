import 'package:flutter_achievments/core/common/entity/avatar.dart';
import 'package:flutter_achievments/core/enums/user_type.dart';
import 'package:flutter_achievments/features/auth/domain/entities/parent_entity.dart';

class ParentModel extends ParentEntity {
  const ParentModel({
    required String id,
    required String name,
    required String email,
    required String photoUrl,
    required bool isTypeShown,
    required AvatarType avatarType,
    required UserType userType,
    required Role role,
  }) : super(
          id: id,
          avatarType: avatarType,
          name: name,
          userType: userType,
          email: email,
          photoUrl: photoUrl,
          isTypeShown: isTypeShown,
          role: role,
        );


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'isTypeShown': isTypeShown,
      'id': id,
      'name': name,
      'email': email,
      'photoUrl': photoUrl,
      'avatarType': avatarType,
      'userType': userType,
      'role': role,
    };
  }

  factory ParentModel.fromMap(Map<String, dynamic> map) {
    return ParentModel(
      isTypeShown: map['isTypeShown'] as bool,
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