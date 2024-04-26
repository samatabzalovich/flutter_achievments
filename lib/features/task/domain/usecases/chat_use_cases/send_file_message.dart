import 'package:equatable/equatable.dart';
import 'package:flutter_achievments/core/usecase/usecase.dart';
import 'package:flutter_achievments/core/utils/typedefs.dart';
import 'package:flutter_achievments/features/task/domain/entities/shared/message.dart';
import 'package:flutter_achievments/features/task/domain/repositories/chat_repo.dart';

class SendFileMessageUseCase extends UseCaseWithParams<void,SendFileMessageParams> {
  final ChatRepo _repository;
  const SendFileMessageUseCase(this._repository);

  @override
  ResultFuture<void> call(SendFileMessageParams params) async {
    return _repository.sendFileMessage( message: params.message, filePath: params.filePath, progressSink: params.progressSink, chatId: params.chatId, members: params.members);
  }
}


class SendFileMessageParams extends Equatable {
  final MessageEntity message;
  final String filePath;
  final Sink<double>? progressSink;
  final String chatId;
  final List<String> members;
  const SendFileMessageParams({
    required this.message,
    required this.filePath,
    this.progressSink,
    required this.chatId,
    required this.members,
  });

  @override
  List<Object?> get props => [message, filePath, progressSink, chatId, members];
}