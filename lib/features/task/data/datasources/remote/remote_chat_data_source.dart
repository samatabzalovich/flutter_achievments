import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_achievments/core/enums/message_type.dart';
import 'package:flutter_achievments/core/error/exception.dart';
import 'package:flutter_achievments/core/error/firestore_errors/firestore_errors.dart';
import 'package:flutter_achievments/core/error/storage_errors/storage_error.dart';
import 'package:flutter_achievments/features/task/data/models/shared/chat_model.dart';
import 'package:flutter_achievments/features/task/data/models/shared/message_model.dart';

abstract class RemoteChatDataSource {
  Future<void> sendMessage(MessageModel message, String chatId);
  Stream<List<MessageModel>> getMessages(String chatId);
  Future<void> sendMessageSeen({
    required String messageId,
  });
  Future<void> sendFileMessage(
      {required MessageModel message,
      required String filePath,
      Sink<double>? progressSink,
      required String chatId
      });

  Stream<List<ChatModel>> getChats();
}

class RemoteChatDataSourceImpl implements RemoteChatDataSource {
  final FirebaseFirestore _firestore;
  final FirebaseStorage _firebaseStorage;
  final FirebaseAuth _firebaseAuth;

  RemoteChatDataSourceImpl(
      this._firestore, this._firebaseStorage, this._firebaseAuth);

  @override
  Stream<List<MessageModel>> getMessages(String chatId) {
    return _firestore
        .collection('chat')
        .doc(chatId)
        .collection('messages')
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
      Sink<double>? progressSink,required String chatId}) async {
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
      await sendMessage(message.copyWith(text: downloadUrl!, ), chatId);
    } on StorageError {
      rethrow;
    } on ApiException  {
      rethrow;
    }
  }

  @override
  Future<void> sendMessage(MessageModel message, String chatId) async {
    try {
      final batch = _firestore.batch();
      final messageRef = _firestore
          .collection('chat')
          .doc(chatId)
          .collection('messages')
          .doc();
      batch.set(messageRef, message.toMap());
      batch.update(_firestore.collection('chat').doc(chatId), {
        'lastMessage': message.text,
        'lastMessageTime': message.timeSent,
        'lastMessageType': message.type.fromEnum(),
      });

      await batch.commit();
    } on FirebaseException catch (e) {
      throw FireStoreError.from(e);
    }
  }

  @override
  Future<void> sendMessageSeen({required String messageId}) async {
    await _firestore.collection('messages').doc(messageId).update({
      'isSeen': true,
    });
  }

  @override
  Stream<List<ChatModel>> getChats() {
    return _firestore
        .collection('chat')
        .where('members', arrayContains: _firebaseAuth.currentUser!.uid)
        .snapshots()
        .map((event) {
      return event.docs.map((e) {
        return ChatModel.fromMap(e.data());
      }).toList();
    });
  }
}
