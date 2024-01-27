import 'package:flutter_achievments/core/utils/typedefs.dart';
import 'package:flutter_achievments/features/task/domain/entities/shared/message.dart';

abstract class ChatRepo {
  ResultFuture<void> sendMessage(MessageEntity message);
  ResultStream<MessageEntity> getMessages();
  ResultFuture<void> sendMessageSeen({
    String recieverUserId,
    String messageId,
  });
  ResultFuture<void> sendFileMessage({MessageEntity message, String filePath, Sink<double>? progressSink});
}
