// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter_achievments/core/common/entity/avatar.dart';
import 'package:flutter_achievments/core/common/entity/user_entity.dart';
import 'package:flutter_achievments/core/enums/user_type.dart';

class ParentEntity extends UserEntity {
  final bool isTypeShown;
  const ParentEntity({
    required String id,
    required String name,
    required String email,
    required String photoUrl,
    required AvatarType avatarType,
    required UserType userType,
    required Role role,
    required this.isTypeShown,
  }) : super(
          id: id,
          name: name,
          email: email,
          photoUrl: photoUrl,
          avatarType: avatarType,
          userType: userType,
          role: role,
        );

  @override
  List<Object?> get props => [
        ...super.props,
        isTypeShown,
      ];

    Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'photoUrl': photoUrl,
      'avatarType': avatarType.toString(),
      'userType': userType.toString(),
      'role': role.toString(),
      'isTypeShown': isTypeShown,
    };
  }

  static ParentEntity fromMap(Map<String, dynamic> map) {
    return ParentEntity(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      photoUrl: map['photoUrl'],
      avatarType: AvatarType.values.firstWhere((e) => e.toString() == map['avatarType']),
      userType: UserType.values.firstWhere((e) => e.toString() == map['userType']),
      role: Role.values.firstWhere((e) => e.toString() == map['role']),
      isTypeShown: map['isTypeShown'],
    );
  }
}
