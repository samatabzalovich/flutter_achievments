import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_achievments/features/app/domain/shared_entities/user_entity.dart';
import 'package:flutter_achievments/core/services/get_it.dart';
import 'package:flutter_achievments/core/usecase/usecase.dart';
import 'package:flutter_achievments/features/splash/domain/usecases/auth_state.dart';
import 'package:flutter_achievments/features/splash/presentation/bloc/auth_status.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class SplashBloc {
  final Stream<AuthStatus> authStatus;
  const SplashBloc._({
    required this.authStatus,
  });

  factory SplashBloc(AuthStateUseCase authStateUseCase) {
    final authStatus = authStateUseCase().map((result) {
      final user = result.fold((l) => null, (r) => r);
      if (user == null) {
        return const AuthStatusLoggedOut();
      } else {
        return AuthStatusLoggedIn(user);
      }
    });
    
    return SplashBloc._(
      authStatus: authStatus,
    );
  }
}
