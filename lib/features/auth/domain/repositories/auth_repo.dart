import 'package:flutter_achievments/features/app/domain/shared_entities/user_entity.dart';
import 'package:flutter_achievments/core/enums/user_type.dart';
import 'package:flutter_achievments/core/utils/typedefs.dart';

abstract class AuthRepo {
  ResultFuture<UserEntity> signUpWithEmailAndPassword(String email, String password, UserType userType);
  ResultFuture<UserEntity> signInWithEmailAndPassword(String email, String password);
  Future<void> signInWithGoogle();
  Future<void> signInWithFacebook();
  Future<void> signInWithApple();
  Future<void> signOut();
}