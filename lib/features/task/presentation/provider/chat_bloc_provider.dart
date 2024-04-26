import 'dart:async';

import 'package:flutter_achievments/features/task/domain/entities/shared/chat_entity.dart';
import 'package:flutter_achievments/features/task/domain/entities/shared/message.dart';
import 'package:flutter_achievments/features/task/presentation/bloc/chat_bloc/chat_bloc.dart';
import 'package:flutter_achievments/features/task/presentation/provider/chat_messages_provider.dart';

class ChatBlocProvider {
  ChatBloc? _chatBloc;
  StreamSubscription<List<ChatEntity>>? _chatListSubscription;

  ChatBloc? get chatBloc => _chatBloc;

  void init(ChatBloc chatBloc, ChatMessagesProvider chatMessagesProvider) {
    _chatBloc ??= chatBloc;
    _chatListSubscription = _chatBloc!.chatListStream.listen((event) {
      chatMessagesProvider.messages.forEach((key, value) {
        for (var element in event) {
          if (element.chatId == key && value.isNotEmpty && 
              element.lastMessageId != value.last.messageId) {
            chatMessagesProvider.addMessage(
                MessageEntity.fromChatEntity(element), key);
          } else if (element.chatId == key && value.isEmpty) {
            chatMessagesProvider.addMessage(
                MessageEntity.fromChatEntity(element), key);
          }
        }
      });
    });
  }

  void dispose() {
    _chatBloc?.dispose();
    _chatListSubscription?.cancel();
    _chatBloc = null;
  }
}
