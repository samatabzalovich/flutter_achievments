import 'package:flutter_achievments/core/common/avatar/avatar.dart';
import 'package:flutter_achievments/core/enums/user_type.dart';
import 'package:flutter_achievments/core/utils/typedefs.dart';
import 'package:flutter_achievments/features/app/domain/shared_entities/child_entity.dart';
import 'package:flutter_achievments/features/app/domain/shared_entities/user_entity.dart';
import 'package:flutter_achievments/features/profile/domain/entities/profile_entity.dart';
import 'package:flutter_achievments/features/profile/domain/usecases/update_avatar.dart';

abstract class ProfileRepo {
  ResultFuture<ProfileEntity> updateProfile(ProfileEntity profile);
  ResultFuture<ProfileEntity> updateAvatar(ProfileEntity profile);
  ResultFuture<String> createChildProfile( ProfileEntity child,);
  ResultFuture<String> createChild({
    required String email,
    required String password,
  });
}
