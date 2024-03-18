import 'package:dartz/dartz.dart';
import 'package:flutter_achievments/core/error/failure.dart';
import 'package:flutter_achievments/core/error/storage_errors/storage_error.dart';
import 'package:flutter_achievments/core/utils/typedefs.dart';
import 'package:flutter_achievments/features/task/data/datasources/remote/remote_chat_data_source.dart';
import 'package:flutter_achievments/features/task/data/models/shared/chat_model.dart';
import 'package:flutter_achievments/features/task/data/models/shared/message_model.dart';
import 'package:flutter_achievments/features/task/domain/entities/shared/message.dart';
import 'package:flutter_achievments/features/task/domain/repositories/chat_repo.dart';

class ChatRepoImpl implements ChatRepo {
  final RemoteChatDataSource _chatDataSource;
  const ChatRepoImpl(this._chatDataSource);
  @override
  Stream<List<MessageEntity>> getMessages(String chatId) {
    return _chatDataSource.getMessages(chatId);
  }

  @override
  ResultFuture<void> sendFileMessage(
      {required MessageEntity message,
      required String filePath,
      Sink<double>? progressSink,
      required String chatId
      }) async {
    try {
      await _chatDataSource.sendFileMessage(
          message: message as MessageModel,
          filePath: filePath,
          progressSink: progressSink, chatId: chatId);
      return const Right(null);
    } on StorageError catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }

  @override
  ResultFuture<void> sendMessage(MessageEntity message, {required String chatId}) async {
    try {
      await _chatDataSource.sendMessage(message as MessageModel, chatId);
      return const Right(null);
    } catch (e) {
      return const Left(ApiFailure(
          dialogText: "sendMessageFailed",
          dialogTitle: "error",
          statusCode: 500));
    }
  }

  @override
  ResultFuture<void> markMessageSeen({required String messageId}) async {
    try {
      await _chatDataSource.sendMessageSeen(messageId: messageId);
      return const Right(null);
    } catch (e) {
      return const Left(ApiFailure(
          dialogText: "markMessageSeenFailed",
          dialogTitle: "error",
          statusCode: 500));
    }
  }

  @override
  Stream<List<ChatModel>> getChats() {
    return _chatDataSource.getChats();
  }
}
