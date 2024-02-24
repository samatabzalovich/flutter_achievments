// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_achievments/features/app/data/shared_models/child_model.dart';
import 'package:flutter_achievments/features/app/data/shared_models/user_model.dart';

import 'package:flutter_achievments/core/enums/user_type.dart';
import 'package:flutter_achievments/core/error/auth_errors/auth_error.dart';
import 'package:flutter_achievments/features/app/data/shared_models/parent_model.dart';

abstract class AuthRemoteSource {
  Future<UserModel> signUpWithEmailAndPassword(
      {required String email,
      required String password,
      required UserType userType});
  Future<UserModel> signInWithEmailAndPassword(
      {required String email, required String password});
  // Future<UserEntity> signInWithFacebook();
  // Future<UserEntity> signInWithApple();
  Future<void> signOut();
}

class AuthRemoteSourceImpl implements AuthRemoteSource {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firebaseFirestore;
  AuthRemoteSourceImpl(
    this._firebaseAuth,
    this._firebaseFirestore,
  );
  @override
  Future<UserModel> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      final userDoc = await _firebaseFirestore
          .collection('users')
          .doc(credential.user!.uid)
          .get();
      final user = userDoc.data()!;
      if (UserType.fromString(user['userType']) == UserType.parent) {
        return ParentModel.fromMap(user, credential.user!.uid);
      } else {
        return ParentModel.fromMap(user, credential.user!.uid);
      }
    } on FirebaseAuthException catch (e) {
      throw AuthError.from(e);
    }
  }

  @override
  Future<void> signOut() {
    return _firebaseAuth.signOut();
  }

  @override
  Future<UserModel> signUpWithEmailAndPassword(
      {required String email,
      required String password,
      required UserType userType}) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      await _firebaseFirestore
          .collection('users')
          .doc(credential.user!.uid)
          .set({
        'email': email,
        'userType': userType.name,
      });
      if (userType == UserType.parent) {
        return ParentModel(
            id: credential.user!.uid, email: email, userType: userType,);
      } else {
        return ChildModel(
            id: credential.user!.uid, email: email, userType: userType, birthDate: DateTime.now());
      }
    } on FirebaseAuthException catch (e) {
      throw AuthError.from(e);
    }
  }
}
