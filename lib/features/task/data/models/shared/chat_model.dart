import 'package:cloud_firestore/cloud_firestore.dart'
    show FieldValue, Timestamp;
import 'package:flutter_achievments/core/enums/message_type.dart';
import 'package:flutter_achievments/features/task/data/models/shared/message_model.dart';
import 'package:flutter_achievments/features/task/domain/entities/shared/chat_entity.dart';

class ChatModel extends ChatEntity {
  const ChatModel({
    required super.chatId,
    required super.lastMessage,
    required super.lastMessageId,
    required super.lastMessageType,
    required super.lastMessageTime,
    required super.isSeen,
    required super.members,
    required super.lastMessageSender,
    required super.repliedMessage,
    required super.repliedTo,
    required super.repliedMessageType,
    required super.taskStateMessageType,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'lastMessage': lastMessage,
      'lastMessageType': lastMessageType.name,
      'lastMessageTime': FieldValue.serverTimestamp(),
      'isSeen': isSeen,
      'lastMessageId': lastMessageId,
      'members': members,
      'lastMessageSender': lastMessageSender,
      'repliedMessage': repliedMessage,
      'repliedTo': repliedTo,
      'repliedMessageType': repliedMessageType.name,
      'taskStateMessageType': taskStateMessageType.name,
    };
  }

  factory ChatModel.fromMap(Map<String, dynamic> map, String chatId) {
    return ChatModel(
      chatId: chatId,
      lastMessageId: map['lastMessageId'] as String,
      lastMessage: map['lastMessage'] as String,
      lastMessageType: (map['lastMessageType'] as String).toMessageEnum(),
      lastMessageTime: (map['lastMessageTime'] as Timestamp?) != null
          ? (map['lastMessageTime'] as Timestamp).toDate()
          : DateTime.now(),
      isSeen: map['isSeen'] as bool,
      members: List<String>.from(map['members'] as List<dynamic>),
      lastMessageSender: map['lastMessageSender'] as String,
      repliedMessage: map['repliedMessage'] as String,
      repliedTo: map['repliedTo'] as String,
      repliedMessageType: (map['repliedMessageType'] as String).toMessageEnum(),
      taskStateMessageType: TaskStateMessageType.fromString(
          (map['taskStateMessageType'] as String)),
    );
  }

  factory ChatModel.fromMessageModel(
      MessageModel messageModel, List<String> members) {
    return ChatModel(
      chatId: '',
      lastMessageId: messageModel.messageId,
      lastMessage: messageModel.text,
      lastMessageType: messageModel.type,
      lastMessageTime: messageModel.timeSent,
      isSeen: messageModel.isSeen,
      members: members,
      lastMessageSender: messageModel.senderId,
      repliedMessage: messageModel.repliedMessage,
      repliedTo: messageModel.repliedTo,
      repliedMessageType: messageModel.repliedMessageType,
      taskStateMessageType: messageModel.taskStateMessageType,
    );
  }

  ChatModel copyWith({
    String? chatId,
    String? lastMessage,
    MessageEnum? lastMessageType,
    DateTime? lastMessageTime,
    String? lastMessageId,
    List<String>? members,
    String? lastMessageSender,
    String? repliedMessage,
    String? repliedTo,
    MessageEnum? repliedMessageType,
    TaskStateMessageType? taskStateMessageType,
    bool? isSeen,
  }) {
    return ChatModel(
      chatId: chatId ?? this.chatId,
      lastMessage: lastMessage ?? this.lastMessage,
      lastMessageType: lastMessageType ?? this.lastMessageType,
      lastMessageTime: lastMessageTime ?? this.lastMessageTime,
      lastMessageId: lastMessageId ?? this.lastMessageId,
      members: members ?? this.members,
      lastMessageSender: lastMessageSender ?? this.lastMessageSender,
      repliedMessage: repliedMessage ?? this.repliedMessage,
      repliedTo: repliedTo ?? this.repliedTo,
      repliedMessageType: repliedMessageType ?? this.repliedMessageType,
      taskStateMessageType: taskStateMessageType ?? this.taskStateMessageType,
      isSeen: isSeen ?? this.isSeen,
    );
  }
}
