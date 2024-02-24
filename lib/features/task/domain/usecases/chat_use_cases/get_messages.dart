
import 'package:flutter_achievments/core/usecase/usecase.dart';
import 'package:flutter_achievments/core/utils/typedefs.dart';
import 'package:flutter_achievments/features/task/domain/entities/shared/message.dart';
import 'package:flutter_achievments/features/task/domain/repositories/chat_repo.dart';

class SendMessageUseCase extends PlainStreamUseCaseWithoutParams<List<MessageEntity>> {
  final ChatRepo _repository;
  const SendMessageUseCase(this._repository);
  @override
  Stream<List<MessageEntity>> call()  {
    return _repository.getMessages();
  }
}