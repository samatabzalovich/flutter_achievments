
import 'package:flutter_achievments/core/usecase/usecase.dart';
import 'package:flutter_achievments/core/utils/typedefs.dart';
import 'package:flutter_achievments/features/task/domain/entities/shared/message.dart';
import 'package:flutter_achievments/features/task/domain/repositories/chat_repo.dart';

class GetMessagesUseCase extends UseCaseWithParams<List<MessageEntity>, String> {
  final ChatRepo _repository;
  const GetMessagesUseCase(this._repository);
  @override
  ResultFuture<List<MessageEntity>> call(String params)  {
    return _repository.getMessages(params);
  }
}