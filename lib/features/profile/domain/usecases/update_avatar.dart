import 'package:flutter_achievments/core/usecase/usecase.dart';
import 'package:flutter_achievments/core/utils/typedefs.dart';
import 'package:flutter_achievments/features/profile/domain/entities/profile_entity.dart';
import 'package:flutter_achievments/features/profile/domain/repositories/profile_repo.dart';

class UpdateAvatarUseCase extends UseCaseWithParams<ProfileEntity, ProfileEntity> {
  final ProfileRepo _repository;

  UpdateAvatarUseCase(this._repository);

  @override
  ResultFuture<ProfileEntity> call(ProfileEntity params) {
    return _repository.updateAvatar(params);
  }
}
