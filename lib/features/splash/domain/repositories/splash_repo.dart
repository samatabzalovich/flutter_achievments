import 'package:flutter_achievments/features/app/domain/shared_entities/user_entity.dart';
import 'package:flutter_achievments/core/utils/typedefs.dart';

abstract class SplashRepo {
  ResultStream<UserEntity> authState();
}
