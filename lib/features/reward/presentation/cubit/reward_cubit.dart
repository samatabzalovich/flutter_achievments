import 'package:equatable/equatable.dart';
import 'package:flutter_achievments/core/common/avatar/avatar.dart';
import 'package:flutter_achievments/core/common/avatar/frame_avatar.dart';
import 'package:flutter_achievments/features/reward/domain/entities/reward_entity.dart';
import 'package:flutter_achievments/features/reward/domain/repositories/reward_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

part 'reward_state.dart';

class RewardCubit extends Cubit<RewardState> {
  final RewardRepository _repo;
  RewardCubit(this._repo) : super(const RewardInitial());

  void getRewards(GetRewardsParams params) async {
    emit(const RewardLoading());
    final result = await _repo.getRewards(params);
    result.fold(
      (l) => emit(RewardError(
        dialogTitle: l.dialogTitle,
        dialogText: l.dialogText,
      )),
      (r) => emit(RewardLoaded(r)),
    );
  }

  void createReward(RewardEntity reward) async {
    emit(const RewardLoading());
    final result = await _repo.createReward(reward);
    result.fold(
      (l) => emit(RewardError(
        dialogTitle: l.dialogTitle,
        dialogText: l.dialogText,
      )),
      (id) async {
        if (reward.avatar.avatar != const NoneAvatarEntity()) {
          final progressSink = BehaviorSubject<double>();
          final listener = progressSink.listen((progress) {
            emit(RewardUploadingAvatar(progress));
          });
          await _repo.uploadRewardAvatar(
              filePath: reward.avatar.avatar.photoUrl,
              rewardId: id,
              rewardAvatar: reward.avatar,
              progressSink: progressSink.sink);
          listener.cancel();
          progressSink.close();
          emit(RewardCreated(reward.copyWith(id: id)));
        } else {
          emit(RewardCreated(reward.copyWith(id: id)));
        }
      },
    );
  }

  void acceptReward(String id) async {
    emit(const RewardLoading());
    final result = await _repo.acceptReward(id);
    result.fold(
      (l) => emit(RewardError(
        dialogTitle: l.dialogTitle,
        dialogText: l.dialogText,
      )),
      (r) => emit(RewardAccepted(id)),
    );
  }

  void cancelReward(String id) async {
    emit(const RewardLoading());
    final result = await _repo.cancelReward(id);
    result.fold(
      (l) => emit(RewardError(
        dialogTitle: l.dialogTitle,
        dialogText: l.dialogText,
      )),
      (r) => emit(RewardDeleted(id)),
    );
  }

  void moveRewardToIssueList(String id) async {
    emit(const RewardLoading());
    final result = await _repo.moveRewardToIssueList(id);
    result.fold(
      (l) => emit(RewardError(
        dialogTitle: l.dialogTitle,
        dialogText: l.dialogText,
      )),
      (r) => emit(RewardToPendingList(id)),
    );
  }

  void suggestReward(String id) async {
    emit(const RewardLoading());
    final result = await _repo.suggestReward(id);
    result.fold(
      (l) => emit(RewardError(
        dialogTitle: l.dialogTitle,
        dialogText: l.dialogText,
      )),
      (r) => emit(RewardSuggested(id)),
    );
  }

  void issueReward(String id) async {
    emit(const RewardLoading());
    final result = await _repo.issueReward(id);
    result.fold(
      (l) => emit(RewardError(
        dialogTitle: l.dialogTitle,
        dialogText: l.dialogText,
      )),
      (r) => emit(RewardIssued(id)),
    );
  }

  void deleteReward(String id) async {
    emit(const RewardLoading());
    final result = await _repo.deleteReward(id);
    result.fold(
      (l) => emit(RewardError(
        dialogTitle: l.dialogTitle,
        dialogText: l.dialogText,
      )),
      (r) => emit(RewardDeleted(id)),
    );
  }

  void updateReward(RewardEntity reward) async {
    emit(const RewardLoading());
    final result = await _repo.updateReward(reward);
    result.fold(
      (l) => emit(RewardError(
        dialogTitle: l.dialogTitle,
        dialogText: l.dialogText,
      )),
      (r) => emit(RewardUpdated(reward)),
    );
  }

  void uploadAndUpdateRewardAvatar(
      {required String filePath,
      required String rewardId,
      required FrameAvatarEntity rewardAvatar}) async {
    emit(const RewardLoading());
    final result = await _repo.uploadRewardAvatar(
        filePath: filePath, rewardId: rewardId, rewardAvatar: rewardAvatar);
    result.fold(
      (l) => emit(RewardError(
        dialogTitle: l.dialogTitle,
        dialogText: l.dialogText,
      )),
      (r) => emit(RewardAvatarUpdated(
        rewardId,
        rewardAvatar,
      )),
    );
  }
}
