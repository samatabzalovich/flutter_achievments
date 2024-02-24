import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_achievments/core/common/avatar/avatar.dart';
import 'package:flutter_achievments/core/enums/avatar_type.dart';
import 'package:flutter_achievments/features/app/domain/shared_entities/child_entity.dart';
import 'package:flutter_achievments/features/app/domain/shared_entities/user_entity.dart';
import 'package:flutter_achievments/features/profile/domain/entities/profile_entity.dart';
import 'package:flutter_achievments/features/profile/domain/usecases/create_child.dart';
import 'package:flutter_achievments/features/profile/domain/usecases/create_child_profile.dart';
import 'package:flutter_achievments/features/profile/domain/usecases/update_avatar.dart';
import 'package:flutter_achievments/features/profile/domain/usecases/update_profile.dart';
import 'package:flutter_achievments/features/profile/presentation/bloc/profile_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UpdateAvatarUseCase _updateAvatarUseCase;
  final UpdateProfileUseCase _updateProfileUseCase;
  final CreateChildProfileUseCase _createChildProfileUseCase;
  final CreateChildUseCase _createChildUseCase;
  ProfileBloc(
    this._updateAvatarUseCase,
    this._updateProfileUseCase,
    this._createChildProfileUseCase,
    this._createChildUseCase,
  ) : super(const ProfileStateInitial()) {
    on<ProfileEventUpdateProfile>(_onUpdateProfile);
    on<ProfileEventUploadAvatarAndUpdateProfile>(
        _onUploadAvatarAndUpdateProfile);
    on<ProfileEventCreateChild>(_onCreateChild);
    on<ProfileEventCreateChildProfile>(_onCreateChildProfile);
  }

  void _onUpdateProfile(
      ProfileEventUpdateProfile event, Emitter<ProfileState> emit) async {
    emit(const ProfileStateLoading());
    final result = await _updateProfileUseCase(ProfileEntity(user: event.user));
    result.fold(
      (l) => emit(ProfileStateError(
          dialogText: l.dialogText, dialogTitle: l.dialogTitle)),
      (r) => emit(ProfileStateUpdated(r.user)),
    );
  }

  void _onCreateChild(
      ProfileEventCreateChild event, Emitter<ProfileState> emit) async {
    final child = event.user as ChildEntity;
    final password = event.password;
    emit(const ProfileStateLoading());
    if (child.withoutPhone) {
    } else {
      final result = await _createChildUseCase(CreateChildParams(
        email: child.email,
        password: password,
      ));
      result.fold(
        (l) {
          emit(ProfileStateError(
              dialogText: l.dialogText, dialogTitle: l.dialogTitle));
        },
        (id) {
          add(ProfileEventCreateChildProfile(event.user, id));
        },
      );
    }
  }

  void _onCreateChildProfile(
      ProfileEventCreateChildProfile event, Emitter<ProfileState> emit) async {
    emit(const ProfileStateLoading());
    late final UserEntity user;
    if (event.user.avatar.type == AvatarType.network) {
      await _uploadAvatar(emit, onSuccess: (userWithNetworkUrl) {
        user = userWithNetworkUrl;
      }, user: event.user);
    } else {
      user = event.user;
      }
    final child = user as ChildEntity;
    final id = event.id; // this id might be empty
    final result = await _createChildProfileUseCase(
        ProfileEntity(user: child.copyWith(id: id)));
    result.fold(
      (l) {
        emit(ProfileStateError(
            dialogText: l.dialogText, dialogTitle: l.dialogTitle));
      },
      (r) {
        emit(ProfileStateChildCreated(child.copyWith(id: r))); //if id is empty, it will be generated by firebase
      },
    );
  }

  void _onUploadAvatarAndUpdateProfile(
      ProfileEventUploadAvatarAndUpdateProfile event,
      Emitter<ProfileState> emit) async {
    if (event.user.avatar.type == AvatarType.network) {
      await _uploadAvatar(emit, onSuccess: (userWithNetworkUrl) {
        add(ProfileEventUpdateProfile(userWithNetworkUrl));
      }, user: event.user);
    } else {
      add(ProfileEventUpdateProfile(event.user));
    }
  }

  Future<void> _uploadAvatar(Emitter<ProfileState> emit,
      {required Function(UserEntity userWithNetworkUrl) onSuccess,
      required UserEntity user}) async {
    emit(const ProfileStateLoadingProgress(0));
    final profileUpdateProgress = BehaviorSubject<int>();
    int progress = 0;
    final sub = profileUpdateProgress.listen((value) {
      emit(ProfileStateLoadingProgress(value == 100 ? 99 : value));
      progress = value;
    });
    final urlResult = await _updateAvatarUseCase(
        ProfileEntity(user: user, progress: profileUpdateProgress));
    emit(ProfileStateLoadingProgress(progress));
    sub.cancel();
    profileUpdateProgress.close();
    urlResult.fold(
        (l) => emit(ProfileStateError(
            dialogText: l.dialogText, dialogTitle: l.dialogTitle)), (r) {
      final updatedUserProfile = user.copyWith(
          avatar: (user.avatar as NetworkAvatarEntity).copyWith(r.avatarUrl!));
      onSuccess(updatedUserProfile);
    });
  }
}







// class ProfileBloc {
//   Sink<UserEntity> updateProfile;
//   Sink<UserEntity> updateAvatar;
//   Sink<ProfileState> _profileState;
//   Stream<ProfileState> profileState;
//   StreamSubscription<ProfileState> _profileSubscription;
//   ProfileBloc._({
//     required this.updateProfile,
//     required this.updateAvatar,
//     required this.profileState,
//     required StreamSubscription<ProfileState> profileSubscription,
//     required Sink<ProfileState> profileStateSink,
//   })  : _profileSubscription = profileSubscription,
//         _profileState = profileStateSink;

//   void dispose() {
//     updateProfile.close();
//     updateAvatar.close();
//     _profileSubscription.cancel();
//     _profileState.close();
//   }

//   factory ProfileBloc(
//     UpdateProfileUseCase updateProfileUseCase,
//     UpdateAvatarUseCase updateAvatarUseCase,
//   ) {
//     final avatarUpdates = BehaviorSubject<UserEntity>();
//     final Stream<ProfileState> avatarUpdateStatus =
//         avatarUpdates.switchMap((user) {
//       return updateAvatarUseCase(ProfileEntity(progress: 0, user: user));
//     }).map<ProfileState>((event) {
//       print("I am in update avatar");
//       return event.fold(
//         (l) => ProfileStateError(
//             dialogText: l.dialogText, dialogTitle: l.dialogTitle),
//         (r) {
//           if (r.avatarUrl != null) {
//             return ProfileStateUpdated(r.user);
//           } else {
//             return ProfileStateLoadingProgress(r.progress.toInt());
//           }
//         },
//       );
//     });

//     final profileUpdates = BehaviorSubject<UserEntity>();
//     final profileUpdateStatus = profileUpdates.asyncMap((user) async {
//       print('object');
//       return await updateProfileUseCase(ProfileEntity(progress: 0, user: user));
//     }).map((event) {
//       print("Iam here");
//       return event.fold(
//         (l) => ProfileStateError(
//             dialogText: l.dialogText, dialogTitle: l.dialogTitle),
//         (r) => ProfileStateUpdated(r.user),
//       );
//     });
//     final profileState = BehaviorSubject<ProfileState>();
//     final profileStatus = Rx.merge([avatarUpdateStatus, profileUpdateStatus]).listen((event) {
//       profileState.add(event);
//     });

//     return ProfileBloc._(
//       updateProfile: profileUpdates.sink,
//       updateAvatar: avatarUpdates.sink,
//       profileState: profileState,
//       profileSubscription: profileStatus,
//       profileStateSink: profileState.sink,
//     );
//   }
// }