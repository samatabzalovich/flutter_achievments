
import 'package:flutter_achievments/core/common/entity/avatar.dart';
import 'package:flutter_achievments/core/enums/user_type.dart';
import 'package:flutter_achievments/core/common/entity/user_entity.dart';

class ChildEntity extends UserEntity {
  final String parentId;
  final bool doesHavePhone;

  const ChildEntity({
    required String id,
    required String name,
    required String email,
    required String photoUrl,
    required AvatarType avatarType,
    required UserType userType,
    required this.parentId,
    required this.doesHavePhone,
    required Role role,
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
        parentId,
        doesHavePhone,
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
      'parentId': parentId,
      'doesHavePhone': doesHavePhone,
    };
  }

  static ChildEntity fromMap(Map<String, dynamic> map) {
    return ChildEntity(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      photoUrl: map['photoUrl'],
      avatarType: AvatarType.values.firstWhere((e) => e.toString() == map['avatarType']),
      userType: UserType.values.firstWhere((e) => e.toString() == map['userType']),
      role: Role.values.firstWhere((e) => e.toString() == map['role']),
      parentId: map['parentId'],
      doesHavePhone: map['doesHavePhone'],
    );
  }
}