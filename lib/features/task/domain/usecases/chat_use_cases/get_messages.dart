
import 'package:flutter_achievments/core/usecase/usecase.dart';
import 'package:flutter_achievments/features/task/domain/entities/shared/message.dart';
import 'package:flutter_achievments/features/task/domain/repositories/chat_repo.dart';

class SendMessageUseCase extends PlainStreamUseCaseWithParams<List<MessageEntity>, String> {
  final ChatRepo _repository;
  const SendMessageUseCase(this._repository);
  @override
  Stream<List<MessageEntity>> call(String params)  {
    return _repository.getMessages(params);
  }
}