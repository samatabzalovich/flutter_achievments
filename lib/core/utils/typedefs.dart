import 'package:dartz/dartz.dart';
import 'package:flutter_achievments/core/error/failure.dart';

typedef ResultFuture<T> = Future<Either<Failure, T>>;

typedef ResultStream<T> = Stream<Either<Failure, T>>;
