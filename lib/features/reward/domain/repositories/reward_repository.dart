import 'package:flutter_achievments/core/common/avatar/frame_avatar.dart';
import 'package:flutter_achievments/core/enums/reward_type.dart';
import 'package:flutter_achievments/core/utils/typedefs.dart';
import 'package:flutter_achievments/features/reward/domain/entities/reward_entity.dart';

abstract class RewardRepository {
  ResultFuture<List<RewardEntity>> getRewards(GetRewardsParams params);
  ResultFuture<String> createReward(RewardEntity reward);
  ResultFuture<void> updateReward(RewardEntity reward);
  ResultFuture<void> deleteReward(String id);
  ResultFuture<void> issueReward(String id);
  ResultFuture<void> acceptReward(String id);
  ResultFuture<void> cancelReward(String id);
  ResultFuture<void> moveRewardToIssueList(String id);
  ResultFuture<void> suggestReward(String id);
  ResultFuture<void> uploadRewardAvatar(
      {required String filePath,
      Sink<double>? progressSink,
      required String rewardId,
      required FrameAvatarEntity rewardAvatar});
}

class GetRewardsParams {
  final String? childId;
  final String? parentId;

  GetRewardsParams({ required this.childId, required this.parentId, });
}
