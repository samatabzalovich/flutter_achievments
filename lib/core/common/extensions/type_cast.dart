import 'package:flutter_achievments/core/enums/user_type.dart';
import 'package:flutter_achievments/features/app/data/shared_models/child_model.dart';
import 'package:flutter_achievments/features/app/data/shared_models/parent_model.dart';
import 'package:flutter_achievments/features/app/data/shared_models/user_model.dart';
import 'package:flutter_achievments/features/app/domain/shared_entities/child_entity.dart';
import 'package:flutter_achievments/features/app/domain/shared_entities/parent_entity.dart';
import 'package:flutter_achievments/features/app/domain/shared_entities/user_entity.dart';

extension TypeCast on UserModel {
  UserEntity? get asUserEntity {
    if (userType == UserType.parent) {
            return ParentEntity.fromModel(this as ParentModel);
          } else if (userType == UserType.child) {
            return ChildEntity.fromModel(this as ChildModel);
          }
          return null;
  }
}