import 'package:flutter_achievments/core/common/entity/user_entity.dart';
import 'package:flutter_achievments/core/usecase/usecase.dart';
import 'package:flutter_achievments/core/utils/typedefs.dart';
import 'package:flutter_achievments/features/splash/domain/repositories/splash_repo.dart';

class AuthStateUseCase extends StreamUseCaseWithoutParams<UserEntity> {
  final SplashRepo _splashRepo;
  const AuthStateUseCase(this._splashRepo);

  @override
  ResultStream<UserEntity> call() => _splashRepo.authState();
}