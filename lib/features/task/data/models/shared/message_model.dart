import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_achievments/core/enums/message_type.dart';
import 'package:flutter_achievments/features/task/domain/entities/shared/message.dart';

class MessageModel extends MessageEntity {
  const MessageModel({
    required super.senderId,
    required super.recieverId,
    required super.text,
    required super.type,
    required super.timeSent,
    required super.messageId,
    required super.isSeen,
    required super.repliedMessage,
    required super.repliedTo,
    required super.repliedMessageType,
    required super.taskStateMessageType,
  });

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      senderId: map['senderId'],
      recieverId: map['recieverId'],
      text: map['text'],
      type: (map['type'] as String).toMessageEnum(),
      timeSent: (map['timeSent'] as Timestamp).toDate(),
      messageId: map['messageId'],
      isSeen: map['isSeen'],
      repliedMessage: map['repliedMessage'],
      repliedTo: map['repliedTo'],
      repliedMessageType: (map['repliedMessageType'] as String ).toMessageEnum(),
      taskStateMessageType: TaskStateMessageType.fromString((map['taskStateMessageType'] as String)),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'recieverId': recieverId,
      'text': text,
      'type': type.name,
      'timeSent': FieldValue.serverTimestamp(),
      'messageId': messageId,
      'isSeen': isSeen,
      'repliedMessage': repliedMessage,
      'repliedTo': repliedTo,
      'repliedMessageType': repliedMessageType.name,
      'taskStateMessageType': taskStateMessageType.name,
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

  static MessageModel fromEntity(MessageEntity entity) {
    return MessageModel(
      senderId: entity.senderId,
      recieverId: entity.recieverId,
      text: entity.text,
      type: entity.type,
      timeSent: entity.timeSent,
      messageId: entity.messageId,
      isSeen: entity.isSeen,
      repliedMessage: entity.repliedMessage,
      repliedTo: entity.repliedTo,
      repliedMessageType: entity.repliedMessageType,
      taskStateMessageType: entity.taskStateMessageType,
    );
  }
}
