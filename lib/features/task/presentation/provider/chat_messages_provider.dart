import 'package:flutter/foundation.dart';
import 'package:flutter_achievments/features/task/data/models/shared/message_model.dart';
import 'package:flutter_achievments/features/task/domain/entities/shared/message.dart';

class ChatMessagesProvider extends ChangeNotifier {
  final Map<String, List<MessageEntity>> _messages = {};

  Map<String, List<MessageEntity>> get messages => _messages;

  void addMessage(MessageEntity messageEntity, String chatId) {
    if (_messages.containsKey(chatId)) {
      _messages[chatId]!.add(MessageModel.fromEntity(messageEntity));
    } else {
      _messages[chatId] = [messageEntity];
    }
    notifyListeners();
  }

  void reInitMessage(List<MessageEntity> messages, String senderId) {
    _messages[senderId] = messages;
    notifyListeners();
  }

  List<MessageEntity>? getMessages(String chatId) {
    return _messages[chatId];
  }

  void clearMessages(String senderId) {
    _messages.remove(senderId);
    notifyListeners();
  }

  void clearAllMessages() {
    _messages.clear();
  }
}
