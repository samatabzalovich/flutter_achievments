import 'dart:async';

import 'package:flutter_achievments/features/task/domain/entities/shared/chat_entity.dart';
import 'package:flutter_achievments/features/task/domain/usecases/chat_use_cases/get_chat_stream.dart';
import 'package:flutter_achievments/features/task/domain/usecases/chat_use_cases/get_messages.dart';
import 'package:flutter_achievments/features/task/domain/usecases/chat_use_cases/mark_message_seen.dart';
import 'package:flutter_achievments/features/task/domain/usecases/chat_use_cases/send_file_message.dart';
import 'package:flutter_achievments/features/task/domain/usecases/chat_use_cases/send_message.dart';
import 'package:flutter_achievments/features/task/presentation/bloc/chat_bloc/chat_state.dart';
import 'package:rxdart/rxdart.dart';

typedef TaskId = String;

class ChatBloc {
  final Stream<List<ChatEntity>> chatListStream;
  final Stream<ChatMessagesLoaded> messageLoadedStream;
  final Stream<ChatError?> messageErrorStream;
  final Sink<SendMessageParams> sendMessageSink;
  final Sink<TaskId> getMessagesSink;
  final Sink<SendFileMessageParams> sendFileMessageSink;
  final Sink<String> markMessageSeenSink;
  final Sink<ChatError> messageErrorSink;
  ChatBloc._({
    required this.chatListStream,
    required this.messageErrorStream,
    required this.sendMessageSink,
    required this.getMessagesSink,
    required this.sendFileMessageSink,
    required this.markMessageSeenSink,
    required this.messageLoadedStream,
    required this.messageErrorSink,
  });

  factory ChatBloc(
    GetChatStreamUseCase getChatsUseCase,
    SendMessageUseCase sendMessageUseCase,
    GetMessagesUseCase getMessagesUseCase,
    SendFileMessageUseCase sendFileMessageUseCase,
    MarkMessageSeenUseCase markMessageSeenUseCase,
  ) {
    final messageErrorController = BehaviorSubject<ChatError>();
    final messagesController = BehaviorSubject<SendMessageParams>();
    final Stream<ChatError?> sendMessageError =
        messagesController.asyncMap((event) async {
      final result = await sendMessageUseCase.call(event);
      return result.fold(
        (l) => ChatError.fromFailure(l),
        (r) => null,
      );
    });
    final getMessagesController = BehaviorSubject<TaskId>();
    final Stream<ChatMessagesLoaded> messageStream =
        getMessagesController.asyncMap((event) async {
      final result = await getMessagesUseCase.call(event);
      return result.fold(
        (l) {
          messageErrorController.add(ChatError.fromFailure(l));
          return ChatMessagesLoaded(
            messages: const [],
            chatId: event,
          );
        },
        (r) {
          return ChatMessagesLoaded(
            messages: r,
            chatId: event,
          );
        },
      );
    });
    final sendFileMessageController = BehaviorSubject<SendFileMessageParams>();
    final Stream<ChatError?> sendFileMessageStream =
        sendFileMessageController.asyncMap((event) async {
      final result = await sendFileMessageUseCase.call(event);
      return result.fold(
        (l) => ChatError.fromFailure(l),
        (r) => null,
      );
    });
    final markMessageSeenController = BehaviorSubject<String>();
    final Stream<ChatError?> markMessageSeenStream =
        markMessageSeenController.asyncMap((event) async {
      final result = await markMessageSeenUseCase.call(event);
      return result.fold(
        (l) => ChatError.fromFailure(l),
        (r) => null,
      );
    });
    return ChatBloc._(
      chatListStream: getChatsUseCase.call(),
      messageErrorStream: Rx.merge([
        sendMessageError,
        sendFileMessageStream,
        markMessageSeenStream,
        messageErrorController.stream
      ]).asBroadcastStream(),
      sendMessageSink: messagesController,
      getMessagesSink: getMessagesController,
      sendFileMessageSink: sendFileMessageController,
      markMessageSeenSink: markMessageSeenController,
      messageLoadedStream: messageStream,
      messageErrorSink: messageErrorController,
    );
  }

  void dispose() {
    getMessagesSink.close();
    sendFileMessageSink.close();
    sendMessageSink.close();
    markMessageSeenSink.close();
    messageErrorSink.close();
  }
}
