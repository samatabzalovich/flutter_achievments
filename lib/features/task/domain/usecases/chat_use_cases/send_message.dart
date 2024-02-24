import 'package:flutter_achievments/core/usecase/usecase.dart';
import 'package:flutter_achievments/core/utils/typedefs.dart';
import 'package:flutter_achievments/features/task/domain/entities/shared/message.dart';
import 'package:flutter_achievments/features/task/domain/repositories/chat_repo.dart';

class SendMessageUseCase extends UseCaseWithParams<void,MessageEntity> {
  final ChatRepo _repository;
  const SendMessageUseCase(this._repository);
  @override
  ResultFuture<void> call(MessageEntity params) async {
    return _repository.sendMessage(params);
  }
}