import 'package:flutter_achievments/features/app/domain/shared_entities/user_entity.dart';
import 'package:flutter_achievments/core/usecase/usecase.dart';
import 'package:flutter_achievments/core/utils/typedefs.dart';
import 'package:flutter_achievments/features/auth/domain/repositories/auth_repo.dart';

class SignInUseCase extends UseCaseWithParams<UserEntity, SignInParams> {
  final AuthRepo repository;

  SignInUseCase(this.repository);

  @override
  ResultFuture<UserEntity> call(SignInParams params) async {
    return repository.signInWithEmailAndPassword(params.email, params.password);
  }
}


class SignInParams {
  final String email;
  final String password;
  const SignInParams({
    required this.email,
    required this.password,
  });
}