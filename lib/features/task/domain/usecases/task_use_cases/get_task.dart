import 'package:flutter_achievments/core/usecase/usecase.dart';
import 'package:flutter_achievments/core/utils/typedefs.dart';
import 'package:flutter_achievments/features/task/domain/entities/task_entities/task_entity.dart';
import 'package:flutter_achievments/features/task/domain/repositories/task_repository.dart';

class GetTaskUseCase extends UseCaseWithoutParams<List<TaskEntity>> {
  final TaskRepo _repository;
  const GetTaskUseCase(this._repository);
  @override
  ResultFuture<List<TaskEntity>> call() async {
    return _repository.getTasks();
  }
}