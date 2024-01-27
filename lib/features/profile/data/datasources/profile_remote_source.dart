import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_achievments/core/common/avatar/avatar.dart';
import 'package:flutter_achievments/core/error/auth_errors/auth_error.dart';
import 'package:flutter_achievments/core/error/exception.dart';
import 'package:flutter_achievments/core/error/failure.dart';
import 'package:flutter_achievments/features/app/data/shared_models/child_model.dart';
import 'package:flutter_achievments/features/app/data/shared_models/user_model.dart';
import 'package:flutter_achievments/features/app/domain/shared_entities/user_entity.dart';
import 'package:flutter_achievments/core/error/storage_errors/storage_error.dart';
import 'package:flutter_achievments/features/profile/data/model/profile_model.dart';

abstract class ProfileRemoteSource {
  Future<void> updateProfile({required ProfileModel profile});
  Future<ProfileModel> updateAvatar({required ProfileModel profile});
  Future<String> createChild({required String email, required String password});
  Future<String> createChildProfile({required ChildModel user});
}

class ProfileRemoteSourceImpl implements ProfileRemoteSource {
  final FirebaseFirestore _firebaseFirestore;
  final FirebaseStorage _firebaseStorage;
  final FirebaseFunctions _firebaseAuth;
  ProfileRemoteSourceImpl(
      this._firebaseFirestore, this._firebaseStorage, this._firebaseAuth);
  @override
  Future<ProfileModel> updateAvatar({required ProfileModel profile}) async {
    try {
      final file = File(profile.user.avatar.photoUrl);
      final fileRef =
          _firebaseStorage.ref().child('avatars/${profile.user.id}');
      final uploadTask = fileRef.putFile(file);
      // Listen to changes in the upload task
      final subscription = uploadTask.snapshotEvents.listen(
        (TaskSnapshot snapshot) {
          final totalBytes = snapshot.totalBytes == 0 ? 1 : snapshot.totalBytes;
          int progress =
              ((snapshot.bytesTransferred / totalBytes) * 100).toInt();
          profile.progress!.add(progress);
        },
        onError: (e) {
          profile.progress!.add(0);
          profile.progress!.close();
          throw const StorageErrorUnknown();
        },
      );
      String? downloadUrl;
      // Handle completion
      await uploadTask.whenComplete(() async {
        try {
          if (uploadTask.snapshot.state == TaskState.success) {
            downloadUrl = await uploadTask.snapshot.ref.getDownloadURL();
            // Emit completion state with download URL
            profile.progress!.add(100);
          } else {
            // Emit error if upload didn't succeed
            profile.progress!.add(0);
          }
        } catch (e) {
          // Emit error
          profile.progress!.add(0);
          throw const StorageErrorUnknown();
        } finally {
          // Always close the controller
          profile.progress!.close();
          subscription.cancel();
        }
      });
      return profile.copyWith(avatarUrl: downloadUrl);
    } on StorageError {
      rethrow;
    }
  }

  @override
  Future<void> updateProfile({required ProfileModel profile}) async {
    try {
      await _firebaseFirestore
          .collection('users')
          .doc(profile.user.id)
          .update((profile.user as UserModel).toMap());
    } on FirebaseException catch (e) {
      throw StorageError.from(e);
    }
  }

  @override
  Future<String> createChild(
      {required String email, required String password}) async {
    try {
      final userCredential = await _firebaseAuth.httpsCallable('createChild')({
        'email': email,
        'password': password,
      });
      return userCredential.data['uid'];
    } on FirebaseFunctionsException catch (e) {
      throw ApiException(
          dialogTextCode: e.code, dialogTitleCode: e.code, statusCode: 400);
    }
  }

  @override
  Future<String> createChildProfile({required ChildModel user}) async {
    try {
      if (user.id.isEmpty) {
        final doc =
            await _firebaseFirestore.collection('users').add(user.toMap());
        return doc.id;
      } else {
        await _firebaseFirestore
            .collection('users')
            .doc(user.id)
            .set(user.toMap());
        return user.id;
      }
    } on FirebaseException catch (e) {
      throw ApiException(
          dialogTextCode: e.code, dialogTitleCode: e.code, statusCode: 500);
    }
  }
}
