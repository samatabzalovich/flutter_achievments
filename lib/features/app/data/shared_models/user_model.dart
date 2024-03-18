import 'package:flutter_achievments/features/app/domain/shared_entities/user_entity.dart';

abstract class UserModel extends UserEntity {
  const UserModel(
      {required super.id,
      required super.name,
      required super.email,
      required super.avatar,
      required super.userType,
      required super.role, required super.createdAt});

  Map<String, dynamic> toMap();

}
