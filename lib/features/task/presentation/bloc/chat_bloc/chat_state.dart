import 'package:equatable/equatable.dart';
import 'package:flutter_achievments/core/error/failure.dart';
import 'package:flutter_achievments/features/task/domain/entities/shared/message.dart';

abstract class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object> get props => [];
}

class ChatError extends ChatState {
  final String dialogTitle;
  final String dialogMessage;

  const ChatError({required this.dialogTitle, required this.dialogMessage});

  static ChatError fromFailure(Failure failure) {
    return ChatError(dialogTitle: failure.dialogTitle, dialogMessage: failure.dialogText);
  }

  @override
  List<Object> get props => [dialogTitle, dialogMessage];
}

class ChatMessagesLoaded extends ChatState {
  final List<MessageEntity> messages;
  final String chatId;
  const ChatMessagesLoaded({required this.messages, required this.chatId});

  @override
  List<Object> get props => [messages, chatId];
}
