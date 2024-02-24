
import 'package:flutter_achievments/features/splash/domain/usecases/auth_state.dart';
import 'package:flutter_achievments/features/splash/presentation/bloc/auth_status.dart';

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
