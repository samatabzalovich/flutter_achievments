import 'package:dartz/dartz.dart';
import 'package:flutter_achievments/core/common/extensions/type_cast.dart';
import 'package:flutter_achievments/core/error/exception.dart';
import 'package:flutter_achievments/features/app/domain/shared_entities/user_entity.dart';
import 'package:flutter_achievments/core/enums/user_type.dart';
import 'package:flutter_achievments/core/error/failure.dart';
import 'package:flutter_achievments/core/utils/typedefs.dart';
import 'package:flutter_achievments/core/error/auth_errors/auth_error.dart';
import 'package:flutter_achievments/features/auth/data/datasources/auth_remote_source.dart';
import 'package:flutter_achievments/features/auth/domain/repositories/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  final AuthRemoteSource _authRemoteSource;
  const AuthRepoImpl(this._authRemoteSource);
  @override
  Future<void> signInWithApple() {
    // TODO: implement signInWithApple
    throw UnimplementedError();
  }

  @override
  ResultFuture<UserEntity> signInWithEmailAndPassword(String email, String password) async {
    try {
      final user = await _authRemoteSource.signInWithEmailAndPassword(email: email, password: password);
      final UserEntity? userEntity = user.asUserEntity;
          if(userEntity == null) {
            throw const ApiException(
              dialogTextCode: 'user_type_not_supported_text',
              dialogTitleCode: 'user_type_not_supported',
              statusCode: 401);
          }
      return Right(user);
    }on AuthError catch (e) {
      return Left(ApiFailure(dialogTitle: e.dialogTitleCode, dialogText: e.dialogTextCode, statusCode: 401));
    } on ApiException catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }

  @override
  Future<void> signInWithFacebook() {
    // TODO: implement signInWithFacebook
    throw UnimplementedError();
  }

  @override
  Future<void> signInWithGoogle() {
    // TODO: implement signInWithGoogle
    throw UnimplementedError();
  }

  @override
  Future<void> signOut() async {
    await _authRemoteSource.signOut();
  }

  @override
  ResultFuture<UserEntity> signUpWithEmailAndPassword(String email, String password, UserType userType) async {
    try {
      final user = await _authRemoteSource.signUpWithEmailAndPassword(email: email, password: password, userType: userType);
      final UserEntity? userEntity = user.asUserEntity;
          if(userEntity == null) {
            throw const ApiException(
              dialogTextCode: 'user_type_not_supported_text',
              dialogTitleCode: 'user_type_not_supported',
              statusCode: 401);
          }
      return Right(userEntity);
    } on AuthError catch (e) {
      return Left(ApiFailure(dialogTitle: e.dialogTitleCode, dialogText: e.dialogTextCode, statusCode: 401));
    } on ApiException catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }
  
}