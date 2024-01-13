part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileStateInitial extends ProfileState {
  const ProfileStateInitial();
}
class ProfileStateLoading extends ProfileState {
  const ProfileStateLoading();
}

class ProfileStateLoadingProgress extends ProfileState {
  final int progress;
  const ProfileStateLoadingProgress(
    this.progress
  );
  @override
  List<Object> get props => [progress];
}

class ProfileStateUpdated extends ProfileState {
  final UserEntity user;
  const ProfileStateUpdated(this.user);
}
class ProfileStateChildCreated extends ProfileState {
  final ChildEntity user;
  const ProfileStateChildCreated(this.user);
}
class ProfileStateError extends ProfileState {
  final String dialogText;
  final String dialogTitle;
  const ProfileStateError(
      {required this.dialogText, required this.dialogTitle});
}
