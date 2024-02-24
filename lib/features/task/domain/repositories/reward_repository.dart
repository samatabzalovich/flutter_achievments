import 'package:flutter_achievments/core/enums/reward_type.dart';
import 'package:flutter_achievments/core/utils/typedefs.dart';
import 'package:flutter_achievments/features/task/domain/entities/reward_entities/reward_entity.dart';

abstract class RewardRepository {
  ResultFuture<List<RewardEntity>> getRewards(GetRewardsParams params);
  ResultFuture<void> createReward(RewardEntity reward);
  ResultFuture<void> updateReward(RewardEntity reward);
  ResultFuture<void> deleteReward(String id);
  ResultFuture<void> issueReward(String id); 
  ResultFuture<void> acceptReward(String id);
  ResultFuture<void> cancelReward(String id);
  ResultFuture<void> moveRewardToIssueList(String id);
  ResultFuture<void> suggestReward(String id);
}

class GetRewardsParams {
  final RewardType? type;
  final String? childId;

  GetRewardsParams({required this.type, required this.childId});
}