// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter_achievments/core/common/entity/user_entity.dart';
import 'package:flutter_achievments/core/error/exception.dart';
import 'package:flutter_achievments/core/utils/typedefs.dart';
import 'package:flutter_achievments/features/auth/domain/entities/child_entity.dart';
import 'package:flutter_achievments/features/auth/domain/entities/parent_entity.dart';

abstract class SplashDataSource {
  const SplashDataSource();
  Stream<String?> authState();
  Future<UserEntity> findUser(String? id);
}

class SplashDataSourceImpl implements SplashDataSource {
  final FirebaseFirestore _firebaseFirestore;
  final FirebaseAuth _firebaseAuth;

  const SplashDataSourceImpl(
    this._firebaseFirestore,
    this._firebaseAuth,
  );

  @override
  Stream<String?> authState() {
    return _firebaseAuth.authStateChanges().map<String?>((user) => user?.uid);
  }

  @override
  Future<UserEntity> findUser(String? id) async {
    if (id == null) {
      throw const ApiException(
          dialogTextCode: 'user_not_logged_in_text',
          dialogTitleCode: 'user_not_logged_in',
          statusCode: 401);
    }
    final user = await _firebaseFirestore.collection('users').doc(id).get();
    if (!user.exists) {
      throw const ApiException(
          dialogTextCode: 'user_not_found_text',
          dialogTitleCode: 'user_not_found',
          statusCode: 404);
    }

    Map<String, dynamic> userData = user.data() as Map<String, dynamic>;
    // Determine the type of user and deserialize accordingly
    if (userData['userType'] == 'parent') {
      return ParentEntity.fromMap(userData);
    } else if (userData['userType'] == 'child') {
      return ChildEntity.fromMap(userData);
    } else {
      throw const ApiException(
          dialogTextCode: 'unknown_user_type_text',
          dialogTitleCode: 'unknown_user_type',
          statusCode: 404);
    }
  }
}
