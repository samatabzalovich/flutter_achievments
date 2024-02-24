import 'package:flutter_achievments/core/usecase/usecase.dart';
import 'package:flutter_achievments/core/utils/typedefs.dart';
import 'package:flutter_achievments/features/task/domain/repositories/chat_repo.dart';

class MarkMessageSeenUseCase extends UseCaseWithParams<void,String> {
  final ChatRepo _repository;
  const MarkMessageSeenUseCase(this._repository);
  @override
  ResultFuture<void> call(String params) async {
    return _repository.markMessageSeen(messageId: params);
  }
}