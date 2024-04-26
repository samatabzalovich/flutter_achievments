// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:flutter_achievments/core/usecase/usecase.dart';
import 'package:flutter_achievments/core/utils/typedefs.dart';
import 'package:flutter_achievments/features/task/domain/entities/shared/message.dart';
import 'package:flutter_achievments/features/task/domain/repositories/chat_repo.dart';

class SendMessageUseCase extends UseCaseWithParams<void, SendMessageParams> {
  final ChatRepo _repository;
  const SendMessageUseCase(this._repository);
  @override
  ResultFuture<void> call(SendMessageParams params) async {
    return _repository.sendMessage(params.message, chatId: params.chatId, members: params.members);
  }
}

class SendMessageParams extends Equatable {
  final MessageEntity message;
  final String chatId;
  final List<String> members;
  const SendMessageParams({
    required this.message,
    required this.chatId,
    required this.members,
  });

  @override
  List<Object?> get props => [message, chatId];
}
