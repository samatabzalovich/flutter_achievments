// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:flutter_achievments/core/common/entity/avatar.dart';
import 'package:flutter_achievments/core/enums/user_type.dart';

abstract class UserEntity extends Equatable {
  final String id;
  final String name;
  final String email;
  final String photoUrl;
  final AvatarType avatarType;
  final UserType userType;
  final Role role;

  const UserEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.photoUrl,
    required this.avatarType,
    required this.userType,
    required this.role,
  });


  @override
  List<Object?> get props => [name, email, photoUrl, avatarType, userType, id];
}
