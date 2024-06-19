part of 'reward_cubit.dart';

abstract class RewardState extends Equatable {
  const RewardState();

  @override
  List<Object> get props => [];
}

class RewardLoading extends RewardState {
  const RewardLoading();
}

class RewardInitial extends RewardState {
  const RewardInitial();
}

class RewardLoaded extends RewardState {
  final List<RewardEntity> rewards;

  const RewardLoaded(this.rewards);

  @override
  List<Object> get props => [rewards];
}

class RewardError extends RewardState {
  final String dialogTitle;
  final String dialogText;

  const RewardError({
    required this.dialogTitle,
    required this.dialogText,
  });

  @override
  List<Object> get props => [
        dialogTitle,
        dialogText,
      ];
}

class RewardUploadingAvatar extends RewardState {
  final double progress;

  const RewardUploadingAvatar(this.progress);

  @override
  List<Object> get props => [progress];
}

class RewardCreated extends RewardState {
  final RewardEntity reward;

  const RewardCreated(this.reward);

  @override
  List<Object> get props => [reward];
}

class RewardAccepted extends RewardState {
  final String id;

  const RewardAccepted(this.id);

  @override
  List<Object> get props => [id];
}

class RewardCanceled extends RewardState {
  final String id;

  const RewardCanceled(this.id);

  @override
  List<Object> get props => [id];
}

class RewardIssued extends RewardState {
  final String id;

  const RewardIssued(this.id);

  @override
  List<Object> get props => [id];
}

class RewardMovedToIssueList extends RewardState {
  final String id;

  const RewardMovedToIssueList(this.id);

  @override
  List<Object> get props => [id];
}

class RewardSuggested extends RewardState {
  final String id;

  const RewardSuggested(this.id);

  @override
  List<Object> get props => [id];
}

class RewardDeleted extends RewardState {
  final String id;

  const RewardDeleted(this.id);

  @override
  List<Object> get props => [id];
}

class RewardToPendingList extends RewardState {
  final String id;

  const RewardToPendingList(this.id);

  @override
  List<Object> get props => [id];
}

class RewardUpdated extends RewardState {
  final RewardEntity reward;

  const RewardUpdated(this.reward);

  @override
  List<Object> get props => [reward];
}

class RewardAvatarUpdated extends RewardState {
  final String id;
  final FrameAvatarEntity avatar;

  const RewardAvatarUpdated(this.id, this.avatar);

  @override
  List<Object> get props => [id, avatar];
}
