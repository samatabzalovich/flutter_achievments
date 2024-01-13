import 'package:equatable/equatable.dart';
import 'package:flutter_achievments/features/app/domain/shared_entities/user_entity.dart';

class ProfileEvent extends Equatable {
  final UserEntity user;
  const ProfileEvent(this.user);
  @override
  List<Object?> get props => [user];
}

class ProfileEventUpdateProfile extends ProfileEvent {
  const ProfileEventUpdateProfile(super.user);
}

class ProfileEventCreateChild extends ProfileEvent {
  final String password;
  const ProfileEventCreateChild(
      {required UserEntity user, required this.password})
      : super(user);
      @override
  List<Object?> get props => [user, password];
}

class ProfileEventUploadAvatarAndUpdateProfile extends ProfileEvent {
  const ProfileEventUploadAvatarAndUpdateProfile(super.user);
}

class ProfileEventCreateChildProfile extends ProfileEvent {
  final String id;
  const ProfileEventCreateChildProfile(super.user , this.id);
  @override
  List<Object?> get props => [user, id];
}
