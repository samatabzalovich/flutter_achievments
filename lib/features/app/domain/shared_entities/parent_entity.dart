
import 'package:flutter_achievments/core/common/avatar/avatar.dart';
import 'package:flutter_achievments/features/app/domain/shared_entities/user_entity.dart';
import 'package:flutter_achievments/core/enums/user_type.dart';
import 'package:flutter_achievments/features/app/domain/shared_entities/child_entity.dart';

class ParentEntity extends UserEntity {
  final bool isRoleShown;
  final List<ChildEntity>? children;
  const ParentEntity({
    required String id,
    String? name,
    required String email,
    required AvatarEntity avatarEntity,
    required UserType userType,
    Role? role,
    this.isRoleShown = false,
    this.children,
  }) : super(
          id: id,
          name: name,
          email: email,
          avatar: avatarEntity,
          userType: userType,
          role: role,
        );

  @override
  List<Object?> get props => [
        ...super.props,
        isRoleShown,
      ];

  
  @override
  UserEntity copyWith(
      {String? id,
      String? name,
      String? email,
      AvatarEntity? avatar,
      UserType? userType,
      Role? role,
      bool? isRoleShown,
      List<ChildEntity>? children
      }) {
    return ParentEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      avatarEntity: avatar ?? this.avatar,
      userType: userType ?? this.userType,
      role: role ?? this.role,
      isRoleShown: isRoleShown ?? this.isRoleShown,
      children: children ?? this.children,
    );
  }


}
