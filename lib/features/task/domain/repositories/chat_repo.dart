import 'package:flutter_achievments/core/utils/typedefs.dart';
import 'package:flutter_achievments/features/task/domain/entities/shared/message.dart';

abstract class ChatRepo {
  ResultFuture<void> sendMessage(MessageEntity message);
  Stream<List<MessageEntity>> getMessages();
  ResultFuture<void> markMessageSeen({
    required String messageId,
  });
  ResultFuture<void> sendFileMessage(
      {required MessageEntity message,
      required String filePath,
      Sink<double>? progressSink});
}
