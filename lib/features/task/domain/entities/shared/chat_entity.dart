// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

import 'package:flutter_achievments/core/enums/message_type.dart';

class ChatEntity extends Equatable {
  final String chatId;
  final String lastMessage;
  final MessageEnum lastMessageType;
  final DateTime lastMessageTime;
  final List<String> members;
  final bool isSeen;

  const ChatEntity({
    required this.chatId,
    required this.lastMessage,
    required this.lastMessageType,
    required this.lastMessageTime,
    required this.isSeen,
    required this.members,
  });

  @override
  List<Object?> get props => [
        chatId,
        lastMessage,
        lastMessageType,
        lastMessageTime,
        isSeen,
        members,
      ];

}
