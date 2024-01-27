import 'package:datetime_setting/datetime_setting.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_achievments/core/enums/user_type.dart';
import 'package:flutter_achievments/features/app/data/shared_models/child_model.dart';
import 'package:flutter_achievments/features/app/data/shared_models/parent_model.dart';
import 'package:flutter_achievments/features/app/domain/shared_entities/child_entity.dart';
import 'package:flutter_achievments/features/app/domain/shared_entities/parent_entity.dart';
import 'package:flutter_achievments/features/app/domain/shared_entities/user_entity.dart';
import 'package:flutter_achievments/core/services/get_it.dart';
import 'package:flutter_achievments/core/usecase/usecase.dart';
import 'package:flutter_achievments/features/splash/domain/usecases/auth_state.dart';
import 'package:flutter_achievments/features/splash/presentation/bloc/auth_status.dart';
import 'package:flutter_achievments/features/splash/presentation/bloc/system_time_status.dart';
import 'package:rxdart/rxdart.dart';

class SplashBloc {
  final Stream<AuthStatus> authStatus;
  final Stream<SystemTimeStatus> systemTimeStatus;
  const SplashBloc._({
    required this.authStatus,
    required this.systemTimeStatus,
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

    final timeStatus =
        Rx.fromCallable(() async => await DatetimeSetting.timeIsAuto())
            .map((isAuto) {
      if (isAuto) {
        return const SystemTimeStatusAuto();
      } else {
        return const SystemTimeStatusManual();
      }
    });
    return SplashBloc._(
      authStatus: authStatus,
      systemTimeStatus: timeStatus,
    );
  }
}
