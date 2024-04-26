import 'package:flutter_achievments/core/usecase/usecase.dart';
import 'package:flutter_achievments/features/task/domain/entities/shared/chat_entity.dart';
import 'package:flutter_achievments/features/task/domain/repositories/chat_repo.dart';

class GetChatStreamUseCase
    extends PlainStreamUseCaseWithoutParams<List<ChatEntity>> {
  final ChatRepo _repository;
  const GetChatStreamUseCase(this._repository);
  @override
  Stream<List<ChatEntity>> call() {
    return _repository.getChats();
  }
}
