import 'package:flutter_achievments/core/common/avatar/avatar.dart';
import 'package:flutter_achievments/features/app/data/shared_models/child_model.dart';
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
  }) : super(
          id: id,
          name: name,
          email: email,
          avatar: avatar,
          userType: userType,
          role: role,
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
    );
  }

  static ChildEntity fromModel(ChildModel model) {
    return ChildEntity(
      id: model.id,
      name: model.name,
      email: model.email,
      avatar: model.avatar,
      userType: model.userType,
      role: model.role,
      parentId: model.parentId,
      withoutPhone: model.withoutPhone,
      parents: model.parents?.map((e) => ParentEntity.fromModel(e)).toList(),
      birthDate: model.birthDate,
    );
  }
}
