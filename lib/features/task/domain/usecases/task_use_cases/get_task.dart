import 'package:equatable/equatable.dart';
import 'package:flutter_achievments/core/usecase/usecase.dart';
import 'package:flutter_achievments/core/utils/typedefs.dart';
import 'package:flutter_achievments/features/task/domain/entities/task_entities/task_entity.dart';
import 'package:flutter_achievments/features/task/domain/repositories/task_repository.dart';

class GetTaskUseCase extends UseCaseWithParams<List<TaskEntity>, GetTaskUseCaseParams> {
  final TaskRepo _repository;
  const GetTaskUseCase(this._repository);
  @override
  ResultFuture<List<TaskEntity>> call(GetTaskUseCaseParams params) async {
    return _repository.getTasks(selectedDate: params.selectedDate, limit: params.limit, userId: params.userId, performer: params.performer);
  }
}

class GetTaskUseCaseParams extends Equatable{
  final DateTime selectedDate;
  final int limit;
  final String userId;
  final String performer;
  const GetTaskUseCaseParams(this.selectedDate, this.limit, {required this.userId,required this.performer});

  @override
  List<Object> get props => [selectedDate, limit];
}

