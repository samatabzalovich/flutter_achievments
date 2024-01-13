import 'package:flutter_achievments/core/common/entity/user_entity.dart';
import 'package:flutter_achievments/core/utils/typedefs.dart';

abstract class SplashRepo {
  ResultStream<UserEntity> authState();
}
