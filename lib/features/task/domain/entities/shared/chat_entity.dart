// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

import 'package:flutter_achievments/core/enums/message_type.dart';

class ChatEntity extends Equatable {
  final String chatId;
  final String lastMessage;
  final MessageEnum lastMessageType;
  final DateTime lastMessageTime;
  final String lastMessageId;
  final List<String> members;
  final String lastMessageSender;
  final String repliedMessage;
  final String repliedTo;
  final MessageEnum repliedMessageType;
  final TaskStateMessageType taskStateMessageType;
  final bool isSeen;

  const ChatEntity({
    required this.chatId,
    required this.lastMessage,
    required this.lastMessageType,
    required this.lastMessageTime,
    required this.lastMessageId,
    required this.members,
    required this.lastMessageSender,
    required this.repliedMessage,
    required this.repliedTo,
    required this.repliedMessageType,
    required this.taskStateMessageType,
    required this.isSeen,
  });

  @override
  List<Object?> get props => [
        chatId,
        lastMessage,
        lastMessageType,
        lastMessageTime,
        isSeen,
        members,
        lastMessageId,
        lastMessageSender,
        repliedMessage,
        repliedTo,
        repliedMessageType,
        taskStateMessageType,
      ];

  
}
