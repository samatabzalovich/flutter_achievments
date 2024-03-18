import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_achievments/features/app/data/shared_models/user_model.dart';

import 'package:flutter_achievments/core/error/exception.dart';
import 'package:flutter_achievments/features/app/data/shared_models/child_model.dart';
import 'package:flutter_achievments/features/app/data/shared_models/parent_model.dart';

abstract class SplashDataSource {
  const SplashDataSource();
  Stream<String?> authState();
  Future<UserModel> findUser(String id);
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
  Future<UserModel> findUser(String id) async {
    try {
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
        final children = await _firebaseFirestore
            .collection('users')
            .where('parentId', isEqualTo: id)
            .get();
        userData['children'] = children.docs.map((e) => e.data()).toList();
        return ParentModel.fromMap(userData, id);
      } else if (userData['userType'] == 'child') {
        return ChildModel.fromMap(userData, id);
      } else {
        throw const ApiException(
            dialogTextCode: 'unknown_user_type_text',
            dialogTitleCode: 'unknown_user_type',
            statusCode: 404);
      }
    } on FirebaseException catch (e) {
      throw ApiException(
          dialogTextCode: e.message ?? 'unknown',
          dialogTitleCode: e.code,
          statusCode: 500);
    } on ApiException {
      rethrow;
    }
  }
}
