part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

class AuthStateLoading extends AuthState {
  const AuthStateLoading();
}



class AuthStateSuccess extends AuthState {
  final UserEntity? userEntity;
  const AuthStateSuccess(this.userEntity);
}

class AuthStateError extends AuthState {
  const AuthStateError(this.dialogText, this.dialogTitle);
  final String dialogText;
  final String dialogTitle;
  @override
  List<Object> get props => [dialogText, dialogTitle];
}
