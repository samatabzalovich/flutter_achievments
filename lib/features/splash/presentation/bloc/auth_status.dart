import 'package:equatable/equatable.dart';
import 'package:flutter_achievments/core/common/entity/user_entity.dart';

abstract class AuthStatus extends Equatable {
  final UserEntity? userEntity;
  const AuthStatus({this.userEntity});

  @override
  List<Object?> get props => [userEntity];
}

class AuthStatusLoggedIn extends AuthStatus {
  const AuthStatusLoggedIn(UserEntity user) : super(userEntity: user);
}

class AuthStatusLoggedOut extends AuthStatus {
  const AuthStatusLoggedOut();
}


