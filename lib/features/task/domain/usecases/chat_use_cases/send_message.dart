import 'package:equatable/equatable.dart';
import 'package:flutter_achievments/core/usecase/usecase.dart';
import 'package:flutter_achievments/core/utils/typedefs.dart';
import 'package:flutter_achievments/features/task/domain/entities/shared/message.dart';
import 'package:flutter_achievments/features/task/domain/repositories/chat_repo.dart';

class SendMessageUseCase extends UseCaseWithParams<void,SendMessageParams> {
  final ChatRepo _repository;
  const SendMessageUseCase(this._repository);
  @override
  ResultFuture<void> call(SendMessageParams params) async {
    return _repository.sendMessage(params.message, chatId: params.chatId);
  }
}

class SendMessageParams extends Equatable {
  final MessageEntity message;
  final String chatId;
  const SendMessageParams({
    required this.message,
    required this.chatId
  });

  @override
  List<Object?> get props => [message, chatId];
}