// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_achievments/features/app/domain/shared_entities/user_entity.dart';
import 'package:flutter_achievments/core/enums/user_type.dart';

import 'package:flutter_achievments/core/usecase/usecase.dart';
import 'package:flutter_achievments/core/utils/typedefs.dart';
import 'package:flutter_achievments/features/auth/domain/repositories/auth_repo.dart';

class RegisterUseCase extends UseCaseWithParams<UserEntity, RegisterParams> {
  final AuthRepo repository;

  RegisterUseCase( this.repository);

  @override
  ResultFuture<UserEntity> call(RegisterParams params) async {
    return repository.signUpWithEmailAndPassword(params.email, params.password, params.userType);
  }
}

class RegisterParams extends Equatable {
  final String email;
  final String password;
  final UserType userType;
  const RegisterParams({
    required this.email,
    required this.password,
    required this.userType,
  });

  @override
  List<Object?> get props => [email, password, userType];
}
