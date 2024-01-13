import 'package:cloud_firestore/cloud_firestore.dart' show DocumentReference, QuerySnapshot;
import 'package:dartz/dartz.dart';
import 'package:flutter_achievments/core/error/failure.dart';

typedef ResultFuture<T> = Future<Either<Failure, T>>;

typedef ResultStream<T> = Stream<Either<Failure, T>>;


typedef QuerySnapshots = QuerySnapshot<Map<String, dynamic>>;
typedef DocumentRef = DocumentReference<Map<String, dynamic>>;
