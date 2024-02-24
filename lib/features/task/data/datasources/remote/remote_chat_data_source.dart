import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_achievments/core/error/storage_errors/storage_error.dart';
import 'package:flutter_achievments/features/task/data/models/shared/message_model.dart';

abstract class RemoteChatDataSource {
  Future<void> sendMessage(MessageModel message);
  Stream<List<MessageModel>> getMessages();
  Future<void> sendMessageSeen({
    required String messageId,
  });
  Future<void> sendFileMessage(
      {required MessageModel message,
      required String filePath,
      Sink<double>? progressSink});
}

class RemoteChatDataSourceImpl implements RemoteChatDataSource {
  final FirebaseFirestore _firestore;
  final FirebaseStorage _firebaseStorage;
  final FirebaseAuth _firebaseAuth;

  RemoteChatDataSourceImpl(
      this._firestore, this._firebaseStorage, this._firebaseAuth);
  @override
  Stream<List<MessageModel>> getMessages() {
    return _firestore
        .collection('messages')
        .where('senderId', isEqualTo: _firebaseAuth.currentUser!.uid)
        .where('recieverid', isEqualTo: _firebaseAuth.currentUser!.uid)
        .orderBy('timeSent')
        .snapshots()
        .map((event) {
      return event.docs.map((e) {
        return MessageModel.fromMap(e.data());
      }).toList();
    });
  }

  @override
  Future<void> sendFileMessage(
      {required MessageModel message,
      required String filePath,
      Sink<double>? progressSink}) async {
    try {
      final file = File(filePath);
      final fileRef = _firebaseStorage
          .ref()
          .child('chat/${message.senderId}/${message.recieverId}');
      final uploadTask = fileRef.putFile(file);
      // Listen to changes in the upload task
      final subscription = uploadTask.snapshotEvents.listen(
        (TaskSnapshot snapshot) {
          final totalBytes = snapshot.totalBytes == 0 ? 1 : snapshot.totalBytes;
          double progress = ((snapshot.bytesTransferred / totalBytes) * 100);
          progressSink!.add(progress);
        },
        onError: (e) {
          progressSink!.add(0);
          progressSink.close();
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
            progressSink!.add(100);
          } else {
            // Emit error if upload didn't succeed
            progressSink!.add(0);
          }
        } catch (e) {
          // Emit error
          progressSink!.add(0);
          throw const StorageErrorUnknown();
        } finally {
          // Always close the controller
          progressSink!.close();
          subscription.cancel();
        }
      });
      await sendMessage(message.copyWith(text: downloadUrl!));
    } on StorageError {
      rethrow;
    }
  }

  @override
  Future<void> sendMessage(MessageModel message) async {
    await _firestore.collection('messages').doc().set(message.toMap());
  }

  @override
  Future<void> sendMessageSeen(
      {required String messageId}) async {
    await _firestore.collection('messages').doc(messageId).update({
      'isSeen': true,
    });
  }
}
