import 'package:dartz/dartz.dart';
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
      return Right(user);
    }on AuthError catch (e) {
      return Left(ApiFailure(dialogTitle: e.dialogTitleCode, dialogText: e.dialogTextCode, statusCode: 401));
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
      return Right(user);
    } on AuthError catch (e) {
      return Left(ApiFailure(dialogTitle: e.dialogTitleCode, dialogText: e.dialogTextCode, statusCode: 401));
    } 
  }
  
}