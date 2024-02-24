import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_achievments/features/app/domain/shared_entities/user_entity.dart';
import 'package:flutter_achievments/core/enums/user_type.dart';
import 'package:flutter_achievments/features/auth/domain/usecases/register.dart';
import 'package:flutter_achievments/features/auth/domain/usecases/sign_in.dart';
import 'package:flutter_achievments/features/auth/domain/usecases/sign_out.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final RegisterUseCase _registerUseCase;
  final SignInUseCase _signInUseCase;
  final SignOutUseCase _signOutUseCase;
  AuthCubit(this._registerUseCase, this._signInUseCase, this._signOutUseCase)
      : super(const AuthInitial());

  void signUpWithEmailAndPassword(
      String email, String password, UserType userType) async {
    emit(const AuthStateLoading());
    final result = await _registerUseCase(
        RegisterParams(email: email, password: password, userType: userType));
    result.fold(
      (l) => emit(AuthStateError(l.dialogText, l.dialogTitle)),
      (r) => emit(
        AuthStateSuccess(r),
      ),
    );
  }

  void signInWithEmailAndPassword(String email, String password) async {
    emit(const AuthStateLoading());
    final result =
        await _signInUseCase(SignInParams(email: email, password: password));
    result.fold(
      (l) => emit(AuthStateError(l.dialogText, l.dialogTitle)),
      (r) => emit(
        AuthStateSuccess(r),
      ),
    );
  }

  void signOut() async {
    emit(const AuthStateLoading());
    await _signOutUseCase();
    emit(const AuthStateSuccess(null));
  }
}
