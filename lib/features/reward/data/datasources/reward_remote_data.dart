import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_achievments/core/common/avatar/avatar.dart';
import 'package:flutter_achievments/core/common/avatar/frame_avatar.dart';
import 'package:flutter_achievments/core/enums/reward_type.dart';
import 'package:flutter_achievments/core/error/firestore_errors/firestore_errors.dart';
import 'package:flutter_achievments/core/error/storage_errors/storage_error.dart';
import 'package:flutter_achievments/core/services/get_it.dart';
import 'package:flutter_achievments/core/utils/image_utils.dart';
import 'package:flutter_achievments/features/reward/data/models/reward_model.dart';
import 'package:flutter_achievments/features/reward/domain/repositories/reward_repository.dart';

abstract class RewardRemoteDataSource {
  Future<List<RewardModel>> getRewards(GetRewardsParams params);
  Future<String> createReward(RewardModel reward);
  Future<void> updateReward(RewardModel reward);
  Future<void> deleteReward(String id);
  Future<void> issueReward(String id);
  Future<void> acceptReward(String id);
  Future<void> cancelReward(String id);
  Future<void> moveRewardToIssueList(String id);
  Future<void> suggestReward(String id);
  Future<void> uploadRewardAvatar(
      {required String filePath,
      Sink<double>? progressSink,
      required String rewardId,
      required FrameAvatarEntity rewardAvatar});
}

class RewardRemoteDataSourceImpl extends RewardRemoteDataSource {
  final FirebaseFirestore _firestore;
  final FirebaseStorage _firebaseStorage;
  RewardRemoteDataSourceImpl(
    this._firestore,
    this._firebaseStorage,
  );
  @override
  Future<void> acceptReward(String id) async {
    try {
      await _firestore.collection('rewards').doc(id).update({
        RewardModel.typeKey: RewardType.available.name,
      });
    } on FirebaseException catch (e) {
      throw FireStoreError.from(e);
    }
  }

  @override
  Future<void> cancelReward(String id) async {
    try {
      await _firestore.collection('rewards').doc(id).delete();
    } on FirebaseException catch (e) {
      throw FireStoreError.from(e);
    }
  }

  @override
  Future<String> createReward(RewardModel reward) async {
    try {
      final result = await _firestore.collection('rewards').add(reward.toMap());
      return result.id;
    } on FirebaseException catch (e) {
      throw FireStoreError.from(e);
    }
  }

  @override
  Future<void> uploadRewardAvatar(
      {required String filePath,
      Sink<double>? progressSink,
      required String rewardId,
      required FrameAvatarEntity rewardAvatar}) async {
    try {
      final downloadUrl = await sl<ImageUtils>().getDownloadUrl(
        bucketPath: 'rewards/avatars/',
        filePath: filePath,
        id: rewardId,
        progressSink: progressSink,
        firebaseStorage: _firebaseStorage,
      );
      final avatar =
          (rewardAvatar.avatar as NetworkAvatarEntity).copyWith(downloadUrl);
      await _firestore.collection('tasks').doc(rewardId).update({
        'avatar': rewardAvatar
            .copyWith(
              avatar: avatar,
            )
            .toMap()
      });
    } on StorageError {
      rethrow;
    } on FirebaseException catch (e) {
      throw FireStoreError.from(e);
    }
  }

  @override
  Future<void> deleteReward(String id) async {
    try {
      await _firestore.collection('rewards').doc(id).delete();
    } on FirebaseException catch (e) {
      throw FireStoreError.from(e);
    }
  }

  @override
  Future<List<RewardModel>> getRewards(GetRewardsParams params) async {
    try {
      final filter = getFiltersForReward(params);
      final rewards = await _firestore
          .collection('rewards')
          .where(filter)
          .orderBy(
            RewardModel.createdAtKey,
            descending: true,
          )
          .get();
      return rewards.docs
          .map((e) => RewardModel.fromMap(e.data(), e.id))
          .toList();
    } on FirebaseException catch (e) {
      throw FireStoreError.from(e);
    }
  }

  @override
  Future<void> issueReward(String id) async {
    try {
      await _firestore
          .collection('rewards')
          .doc(id)
          .update({RewardModel.typeKey: RewardType.issued.name});
    } on FirebaseException catch (e) {
      throw FireStoreError.from(e);
    }
  }

  @override
  Future<void> moveRewardToIssueList(String id) async {
    try {
      await _firestore
          .collection('rewards')
          .doc(id)
          .update({RewardModel.typeKey: RewardType.pendingRewards.name});
    } on FirebaseException catch (e) {
      throw FireStoreError.from(e);
    }
  }

  @override
  Future<void> suggestReward(String id) async {
    try {
      await _firestore
          .collection('rewards')
          .doc(id)
          .update({RewardModel.typeKey: RewardType.childCreated.name});
    } on FirebaseException catch (e) {
      throw FireStoreError.from(e);
    }
  }

  @override
  Future<void> updateReward(RewardModel reward) async {
    try {
      await _firestore
          .collection('rewards')
          .doc(reward.id)
          .update(reward.toMap(true));
    } on FirebaseException catch (e) {
      throw FireStoreError.from(e);
    }
  }

  Filter getFiltersForReward(GetRewardsParams params) {
    Filter? filter1;
    Filter? filter2;

    if (params.childId != null) {
      filter2 = Filter('receivers', arrayContains: params.childId);
    }

    if (params.parentId != null) {
      filter1 = Filter('parentId', isEqualTo: params.parentId);
    }

    if (filter1 != null && filter2 != null) {
      return Filter.and(filter1, filter2);
    } else if (filter1 != null) {
      return filter1;
    } else {
      return filter2!;
    }
  }
}
