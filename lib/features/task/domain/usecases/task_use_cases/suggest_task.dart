import 'package:flutter_achievments/core/usecase/usecase.dart';
import 'package:flutter_achievments/core/utils/typedefs.dart';
import 'package:flutter_achievments/features/task/domain/entities/task_entities/task_entity.dart';
import 'package:flutter_achievments/features/task/domain/repositories/task_repository.dart';

class SuggestTaskUseCase extends UseCaseWithParams<void,TaskEntity> {
  final TaskRepo _repository;
  const SuggestTaskUseCase(this._repository);
  @override
  ResultFuture<void> call(TaskEntity params) async {
    return _repository.suggestTask(params);
  }
}