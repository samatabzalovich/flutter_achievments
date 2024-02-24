import 'package:flutter_achievments/features/auth/domain/repositories/auth_repo.dart';

class SignOutUseCase {
  final AuthRepo _authRepo;
  const SignOutUseCase(this._authRepo);
  Future<void> call() {
    return _authRepo.signOut();
  }
}
