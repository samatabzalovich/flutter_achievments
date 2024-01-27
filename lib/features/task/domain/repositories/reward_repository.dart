import 'package:flutter_achievments/core/enums/reward_type.dart';
import 'package:flutter_achievments/core/utils/typedefs.dart';
import 'package:flutter_achievments/features/task/domain/entities/reward_entities/reward_entity.dart';

abstract class RewardRepository {
  ResultFuture<List<RewardEntity>> getRewards(GetRewardsParams params);
  ResultFuture<void> createReward(RewardEntity reward);
  ResultFuture<void> updateReward(RewardEntity reward);
  ResultFuture<void> deleteReward(String id);
  ResultFuture<void> completeReward(String id); // for child then parent sees it in pending which means he can accept or reject it
  ResultFuture<void> acceptReward(String id);
  ResultFuture<void> refuseReward(String id);//child refused the reward
  ResultFuture<void> rejectReward(String id);// parent rejected the reward
  ResultFuture<void> redoReward(String id);
  ResultFuture<void> suggestReward(String id);
  ResultFuture<void> attachPhotoReport({String filePath, Sink<double>? progressSink});
}

class GetRewardsParams {
  final RewardType? type;
  final String? childId;

  GetRewardsParams({required this.type, required this.childId});
}