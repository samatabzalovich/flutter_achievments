
import 'package:flutter_achievments/core/common/avatar/avatar.dart';
import 'package:flutter_achievments/core/enums/user_type.dart';
import 'package:flutter_achievments/features/app/data/shared_models/user_model.dart';
import 'package:flutter_achievments/features/app/domain/shared_entities/child_entity.dart';

class ChildModel extends ChildEntity implements UserModel{
  
  const ChildModel({
    required String id,
    String? name,
    required String email,
    AvatarEntity avatarEntity = const NoneAvatarEntity(),
    required UserType userType,
    Role? role,
    String? parentId,
    bool withoutPhone =false,
    required DateTime birthDate,
  }) : super(
          id: id,
          avatar: avatarEntity,
          name: name,
          userType: userType,
          email: email,
          role: role,
          parentId: parentId,
          withoutPhone: withoutPhone,
          birthDate: birthDate,
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
    
    return ChildModel(
      id: uid,
      name: map['name'],
      email: map['email'],
      avatarEntity: AvatarEntity.fromMap(map['avatar']),
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
      avatarEntity: entity.avatar,
      userType: entity.userType,
      role: entity.role ?? Role.unknown,
      parentId: entity.parentId ?? '',
      withoutPhone: entity.withoutPhone,
      birthDate: entity.birthDate,
    );
  }

}
