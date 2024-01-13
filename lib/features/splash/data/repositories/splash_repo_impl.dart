import 'package:dartz/dartz.dart';
import 'package:flutter_achievments/core/common/entity/user_entity.dart';
import 'package:flutter_achievments/core/error/exception.dart';
import 'package:flutter_achievments/core/error/failure.dart';
import 'package:flutter_achievments/core/utils/typedefs.dart';
import 'package:flutter_achievments/features/splash/data/datasources/splash_data_source.dart';
import 'package:flutter_achievments/features/splash/domain/repositories/splash_repo.dart';
import 'package:rxdart/rxdart.dart';

class SplashRepoImpl implements SplashRepo {
  final SplashDataSource _splashDataSource;
  const SplashRepoImpl(this._splashDataSource);

  @override
  ResultStream<UserEntity> authState() {
    return _splashDataSource.authState().asyncMap((value) async {
      try {
          final user = await _splashDataSource.findUser(value);
          return Right(user);
      } on ApiException catch (e) {
        return left(ApiFailure.fromException(e));
      }
    });
  }
}
