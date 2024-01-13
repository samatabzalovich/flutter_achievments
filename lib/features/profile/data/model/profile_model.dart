import 'package:flutter_achievments/core/error/failure.dart';
import 'package:flutter_achievments/features/app/domain/shared_entities/user_entity.dart';
import 'package:flutter_achievments/features/profile/domain/entities/profile_entity.dart';

class ProfileModel extends ProfileEntity {
  const ProfileModel({ super.avatarUrl, required super.user, super.progress});

  factory ProfileModel.fromEntity(ProfileEntity entity) {
    return ProfileModel(
      avatarUrl: entity.avatarUrl,
      user: entity.user,
      progress: entity.progress,
    );
  }

  ProfileModel copyWith({
    String? avatarUrl,
    UserEntity? user,
    Sink<int>? progress,
  }) {
    return ProfileModel(
      avatarUrl: avatarUrl ?? this.avatarUrl,
      user: user ?? this.user,
      progress: progress ?? this.progress,
    );
  }
}
