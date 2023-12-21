import 'package:equatable/equatable.dart';

abstract class AuthStatus {
  const AuthStatus();
}

class AuthStatusLoggedIn extends AuthStatus {
  const AuthStatusLoggedIn();
}

class AuthStatusLoggedOut extends AuthStatus {
  const AuthStatusLoggedOut();
}


