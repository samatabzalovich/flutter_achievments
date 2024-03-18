import 'package:flutter_achievments/core/common/avatar/avatar.dart';
import 'package:flutter_achievments/features/app/domain/shared_entities/user_entity.dart';
import 'package:flutter_achievments/core/enums/user_type.dart';
import 'package:flutter_achievments/features/app/domain/shared_entities/parent_entity.dart';

class ChildEntity extends UserEntity {
  final String? parentId;
  final bool withoutPhone;
  final List<ParentEntity>? parents;
  final DateTime birthDate;
  const ChildEntity( {
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
    required DateTime createdAt,
  }) : super(
          id: id,
          name: name,
          email: email,
          avatar: avatar,
          userType: userType,
          role: role,
          createdAt: createdAt,
        );

  @override
  List<Object?> get props => [
        ...super.props,
        parentId,
        withoutPhone,
      ];

  @override
  ChildEntity copyWith({
    String? id,
    String? name,
    String? email,
    AvatarEntity? avatar,
    UserType? userType,
    Role? role,
    String? parentId,
    bool? withoutPhone,
    List<ParentEntity>? parents,
    DateTime? birthDate,
    DateTime? createdAt,
  }) {
    return ChildEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      avatar: avatar ?? this.avatar,
      userType: userType ?? this.userType,
      role: role ?? this.role,
      parentId: parentId ?? this.parentId,
      withoutPhone: withoutPhone ?? this.withoutPhone,
      parents: parents ?? this.parents,
      birthDate: birthDate ?? this.birthDate,
      createdAt: createdAt ?? this.createdAt,
    );
  }


}
