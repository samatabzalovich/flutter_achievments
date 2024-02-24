import 'package:flutter_achievments/core/utils/typedefs.dart';

abstract class UseCaseWithParams<Type, Params> {
  const UseCaseWithParams();
  ResultFuture<Type> call(Params params);
}

abstract class UseCaseWithoutParams<Type> {
  const UseCaseWithoutParams();
  ResultFuture<Type> call();
}

abstract class StreamUseCase<Type, Params> {
  const StreamUseCase();
  ResultStream<Type> call(Params params);
}

abstract class StreamUseCaseWithoutParams<Type> {
  const StreamUseCaseWithoutParams();
  ResultStream<Type> call();
}

abstract class PlainStreamUseCaseWithoutParams<Type> {
  const PlainStreamUseCaseWithoutParams();
  Stream<Type> call();
}

