import 'package:flutter_achievments/core/enums/message_type.dart';
import 'package:flutter_achievments/features/task/domain/entities/shared/message.dart';

class MessageModel extends MessageEntity {
  const MessageModel({
    required String senderId,
    required String recieverId,
    required String text,
    required MessageEnum type,
    required DateTime timeSent,
    required String messageId,
    required bool isSeen,
    required String repliedMessage,
    required String repliedTo,
    required MessageEnum repliedMessageType,
    required TaskStateMessageType taskStateMessageType,
  }) : super(
          senderId: senderId,
          recieverId: recieverId,
          text: text,
          type: type,
          timeSent: timeSent,
          messageId: messageId,
          isSeen: isSeen,
          repliedMessage: repliedMessage,
          repliedTo: repliedTo,
          repliedMessageType: repliedMessageType,
          taskStateMessageType: taskStateMessageType,
        );

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      senderId: map['senderId'],
      recieverId: map['recieverId'],
      text: map['text'],
      type: map['type'],
      timeSent: map['timeSent'],
      messageId: map['messageId'],
      isSeen: map['isSeen'],
      repliedMessage: map['repliedMessage'],
      repliedTo: map['repliedTo'],
      repliedMessageType: map['repliedMessageType'],
      taskStateMessageType: map['taskStateMessageType'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'recieverId': recieverId,
      'text': text,
      'type': type,
      'timeSent': timeSent,
      'messageId': messageId,
      'isSeen': isSeen,
      'repliedMessage': repliedMessage,
      'repliedTo': repliedTo,
      'repliedMessageType': repliedMessageType,
      'taskStateMessageType': taskStateMessageType,
    };
  }

  MessageModel copyWith({
    String? senderId,
    String? recieverId,
    String? text,
    MessageEnum? type,
    DateTime? timeSent,
    String? messageId,
    bool? isSeen,
    String? repliedMessage,
    String? repliedTo,
    MessageEnum? repliedMessageType,
    TaskStateMessageType? taskStateMessageType,
  }) {
    return MessageModel(
      senderId: senderId ?? this.senderId,
      recieverId: recieverId ?? this.recieverId,
      text: text ?? this.text,
      type: type ?? this.type,
      timeSent: timeSent ?? this.timeSent,
      messageId: messageId ?? this.messageId,
      isSeen: isSeen ?? this.isSeen,
      repliedMessage: repliedMessage ?? this.repliedMessage,
      repliedTo: repliedTo ?? this.repliedTo,
      repliedMessageType: repliedMessageType ?? this.repliedMessageType,
      taskStateMessageType: taskStateMessageType ?? this.taskStateMessageType,
    );
  }
}