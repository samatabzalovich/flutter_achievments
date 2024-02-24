import 'package:dartz/dartz.dart';
import 'package:flutter_achievments/core/error/exception.dart';
import 'package:flutter_achievments/core/error/failure.dart';
import 'package:flutter_achievments/core/utils/typedefs.dart';
import 'package:flutter_achievments/features/app/data/shared_models/child_model.dart';
import 'package:flutter_achievments/features/profile/data/datasources/profile_remote_source.dart';
import 'package:flutter_achievments/core/error/storage_errors/storage_error.dart';
import 'package:flutter_achievments/features/profile/data/model/profile_model.dart';
import 'package:flutter_achievments/features/profile/domain/entities/profile_entity.dart';
import 'package:flutter_achievments/features/profile/domain/repositories/profile_repo.dart';

class ProfileRepoImpl implements ProfileRepo {
  final ProfileRemoteSource _profileRemoteSource;

  ProfileRepoImpl(this._profileRemoteSource);
  @override
  ResultFuture<ProfileEntity> updateProfile(ProfileEntity profile) async {
    try {
      await _profileRemoteSource.updateProfile(
          profile: ProfileModel.fromEntity(profile));
      return Right(profile);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }

  @override
  ResultFuture<ProfileModel> updateAvatar(ProfileEntity profile) async {
    try {
      final profileModel = await _profileRemoteSource.updateAvatar(
          profile: ProfileModel.fromEntity(profile));
      return Right(profileModel);
    } on StorageError catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }

  @override
  ResultFuture<String> createChild(
      {required String email, required String password}) async {
    try {
      final id = await _profileRemoteSource.createChild(
          email: email, password: password);
      return Right(id);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }

  @override
  ResultFuture<String> createChildProfile(ProfileEntity profile) async {
    try {
      final id = await _profileRemoteSource.createChildProfile(
          user: ProfileModel.fromEntity(profile).userModel as ChildModel);
      return Right(id);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }
}
