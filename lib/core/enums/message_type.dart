enum TaskStateMessageType {
  plain,
  refused,
  rejected;

  static TaskStateMessageType fromString(String type) {
    switch (type) {
      case 'plain':
        return TaskStateMessageType.plain;
      case 'refused':
        return TaskStateMessageType.refused;
      case 'rejected':
        return TaskStateMessageType.rejected;
      default:
        return TaskStateMessageType.plain;
    }
  }
}

enum MessageEnum {
  text('text'),
  image('image'),
  audio('audio');

  const MessageEnum(this.type);
  final String type;
}

extension ConvertMessage on String {
  MessageEnum toMessageEnum() {
    switch (this) {
      case 'audio':
        return MessageEnum.audio;
      case 'image':
        return MessageEnum.image;
      case 'text':
        return MessageEnum.text;
      default:
        return MessageEnum.text;
    }
  }
}

extension ConvertEnum on MessageEnum {
  String fromEnum() {
    switch (this) {
      case MessageEnum.audio:
        return 'audio';
      case MessageEnum.image:
        return 'image';
      case MessageEnum.text:
        return 'text';
      default:
        return 'text';
    }
  }
}
