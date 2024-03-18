import 'package:cloud_firestore/cloud_firestore.dart' show FieldValue;
import 'package:flutter_achievments/core/enums/message_type.dart';
import 'package:flutter_achievments/features/task/domain/entities/shared/chat_entity.dart';

class ChatModel extends ChatEntity {
  const ChatModel(
      {required super.chatId,
      required super.lastMessage,
      required super.lastMessageType,
      required super.lastMessageTime,
      required super.isSeen,
      required super.members});


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'chatId': chatId,
      'lastMessage': lastMessage,
      'lastMessageType': lastMessageType.fromEnum(),
      'lastMessageTime': FieldValue.serverTimestamp(),
      'isSeen': isSeen,
      'members': members,
    };
  }

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      chatId: map['chatId'] as String,
      lastMessage: map['lastMessage'] as String,
      lastMessageType: (map['lastMessageType'] as String).toMessageEnum(), 
      lastMessageTime: DateTime.fromMillisecondsSinceEpoch(map['lastMessageTime'] as int),
      isSeen: map['isSeen'] as bool,
      members: List<String>.from(map['members'] as List<dynamic>),
    );
  }

}
