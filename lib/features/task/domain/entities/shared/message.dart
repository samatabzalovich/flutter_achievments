import 'package:equatable/equatable.dart';

import 'package:flutter_achievments/core/enums/message_type.dart';

class MessageEntity extends Equatable {
  final String senderId;
  final String recieverId;
  final String text;
  final MessageEnum type;
  final DateTime timeSent;
  final String messageId;
  final bool isSeen;
  final String repliedMessage;
  final String repliedTo;
  final MessageEnum repliedMessageType;
  final TaskStateMessageType taskStateMessageType;

  const MessageEntity({
    required this.senderId,
    required this.recieverId,
    required this.text,
    required this.type,
    required this.timeSent,
    required this.messageId,
    required this.isSeen,
    required this.repliedMessage,
    required this.repliedTo,
    required this.repliedMessageType,
    required this.taskStateMessageType,
  });

  @override
  List<Object?> get props => [
        senderId,
        recieverId,
        text,
        type,
        timeSent,
        messageId,
        isSeen,
        repliedMessage,
        repliedTo,
        repliedMessageType,
        taskStateMessageType,
      ];

  
}
