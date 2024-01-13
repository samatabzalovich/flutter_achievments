import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuthException;
import 'package:flutter_achievments/core/error/exception.dart';

const Map<String, AuthError> authErrorMapping = {
    'user-not-found': AuthErrorUserNotFound(),
  'invalid_login_credentials': AuthErrorInvalidLogin(),
  'weak-password': AuthErrorWeakPassword(),
  'invalid-email': AuthErrorInvalidEmail(),
  'operation-not-allowed': AuthErrorOperationNotAllowed(),
  'email-already-in-use': AuthErrorEmailAlreadyInUse(),
  'requires-recent-login': AuthErrorRequiresRecentLogin(),
  'no-current-user': AuthErrorNoCurrentUser(),
};

abstract class AuthError extends ApiException {


  const AuthError({
    required String dialogTitle,
    required String dialogText,
  }) : super(dialogTextCode: dialogText, dialogTitleCode: dialogTitle, statusCode: 401);

  factory AuthError.from(FirebaseAuthException exception) =>
      authErrorMapping[exception.code.toLowerCase().trim()] ??
      const AuthErrorUnknown();
}

class AuthErrorUnknown extends AuthError {
  const AuthErrorUnknown()
      : super(
          dialogTitle: 'Authentication error',
          dialogText: 'Unknown authentication error',
        );
}

// auth/no-current-user

class AuthErrorNoCurrentUser extends AuthError {
  const AuthErrorNoCurrentUser()
      : super(
          dialogTitle: 'No current user!',
          dialogText: 'No current user with this information was found',
        );
}

// auth/requires-recent-login

class AuthErrorRequiresRecentLogin extends AuthError {
  const AuthErrorRequiresRecentLogin()
      : super(
          dialogTitle: 'Requires recent login',
          dialogText:
              'You need to log out and log back in again in order to perform this operation',
        );
}

// auth/operation-not-allowed

class AuthErrorOperationNotAllowed extends AuthError {
  const AuthErrorOperationNotAllowed()
      : super(
          dialogTitle: 'Operation not allowed',
          dialogText: 'You cannot register using this method at this moment!',
        );
}

// auth/user-not-found

class AuthErrorUserNotFound extends AuthError {
  const AuthErrorUserNotFound()
      : super(
          dialogTitle: 'User not found',
          dialogText: 'The given user was not found on the server!',
        );
}

// auth/weak-password

class AuthErrorWeakPassword extends AuthError {
  const AuthErrorWeakPassword()
      : super(
          dialogTitle: 'Weak password',
          dialogText:
              'Please choose a stronger password consisting of more characters!',
        );
}

// auth/invalid-email

class AuthErrorInvalidEmail extends AuthError {
  const AuthErrorInvalidEmail()
      : super(
          dialogTitle: 'Invalid email',
          dialogText: 'Please double check your email and try again!',
        );
}
class AuthErrorInvalidLogin extends AuthError {
  const AuthErrorInvalidLogin()
      : super(
          dialogTitle: 'Invalid login',
          dialogText: 'Please double check your email or password and try again!',
        );
}

// auth/email-already-in-use

class AuthErrorEmailAlreadyInUse extends AuthError {
  const AuthErrorEmailAlreadyInUse()
      : super(
          dialogTitle: 'Email already in use',
          dialogText: 'Please choose another email to register with!',
        );
}