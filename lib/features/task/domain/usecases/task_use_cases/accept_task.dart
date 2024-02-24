import 'package:flutter_achievments/core/usecase/usecase.dart';
import 'package:flutter_achievments/core/utils/typedefs.dart';
import 'package:flutter_achievments/features/task/domain/repositories/task_repository.dart';

class AcceptTaskUseCase extends UseCaseWithParams<void,String> {
  final TaskRepo _repository;
  const AcceptTaskUseCase(this._repository);
  @override
  ResultFuture<void> call(String params) async {
    return _repository.acceptTask(params);
  }
}