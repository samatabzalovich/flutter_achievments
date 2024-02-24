import 'package:flutter_achievments/core/utils/typedefs.dart';
import 'package:flutter_achievments/features/profile/domain/entities/profile_entity.dart';

abstract class ProfileRepo {
  ResultFuture<ProfileEntity> updateProfile(ProfileEntity profile);
  ResultFuture<ProfileEntity> updateAvatar(ProfileEntity profile);
  ResultFuture<String> createChildProfile(
    ProfileEntity child,
  );
  ResultFuture<String> createChild({
    required String email,
    required String password,
  });
}
