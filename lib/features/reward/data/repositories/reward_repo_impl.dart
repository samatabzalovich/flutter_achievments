import 'package:dartz/dartz.dart';
import 'package:flutter_achievments/core/common/avatar/frame_avatar.dart';
import 'package:flutter_achievments/core/error/failure.dart';
import 'package:flutter_achievments/core/error/firestore_errors/firestore_errors.dart';
import 'package:flutter_achievments/core/error/storage_errors/storage_error.dart';
import 'package:flutter_achievments/core/utils/typedefs.dart';
import 'package:flutter_achievments/features/reward/data/datasources/reward_remote_data.dart';
import 'package:flutter_achievments/features/reward/data/models/reward_model.dart';
import 'package:flutter_achievments/features/reward/domain/entities/reward_entity.dart';
import 'package:flutter_achievments/features/reward/domain/repositories/reward_repository.dart';

class RewardRepoImpl extends RewardRepository {
  final RewardRemoteDataSource rewardDataSource;

  RewardRepoImpl({required this.rewardDataSource});

  @override
  ResultFuture<void> acceptReward(String id) async {
    try {
      await rewardDataSource.acceptReward(id);
      return const Right(null);
    } on FireStoreError catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }

  @override
  ResultFuture<void> cancelReward(String id) async {
    try {
      await rewardDataSource.cancelReward(id);
      return const Right(null);
    } on FireStoreError catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }

  @override
  ResultFuture<String> createReward(RewardEntity reward) async {
    try {
      final rewardId =
          await rewardDataSource.createReward(RewardModel.fromEntity(reward));
      return Right(rewardId);
    } on FireStoreError catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }

  @override
  ResultFuture<void> deleteReward(String id) async {
    try {
      await rewardDataSource.deleteReward(id);
      return const Right(null);
    } on FireStoreError catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<RewardEntity>> getRewards(GetRewardsParams params) async {
    try {
      final rewards = await rewardDataSource.getRewards(params);
      return Right(rewards);
    } on FireStoreError catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }

  @override
  ResultFuture<void> issueReward(String id) async {
    try {
      await rewardDataSource.issueReward(id);
      return const Right(null);
    } on FireStoreError catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }

  @override
  ResultFuture<void> moveRewardToIssueList(String id) async {
    try {
      await rewardDataSource.moveRewardToIssueList(id);
      return const Right(null);
    } on FireStoreError catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }

  @override
  ResultFuture<void> suggestReward(String id) async {
    try {
      await rewardDataSource.suggestReward(id);
      return const Right(null);
    } on FireStoreError catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }

  @override
  ResultFuture<void> updateReward(RewardEntity reward) async {
    try {
      await rewardDataSource.updateReward(RewardModel.fromEntity(reward));
      return const Right(null);
    } on FireStoreError catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }

  @override
  ResultFuture<void> uploadRewardAvatar(
      {required String filePath,
      Sink<double>? progressSink,
      required String rewardId,
      required FrameAvatarEntity rewardAvatar}) async {
    try {
      await rewardDataSource.uploadRewardAvatar(
        filePath: filePath,
        rewardId: rewardId,
        rewardAvatar: rewardAvatar,
        progressSink: progressSink,
      );
      return const Right(null);
    } on FireStoreError catch (e) {
      return Left(ApiFailure.fromException(e));
    } on StorageError catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }
}
