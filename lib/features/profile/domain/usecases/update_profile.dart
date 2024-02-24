import 'package:flutter_achievments/core/usecase/usecase.dart';
import 'package:flutter_achievments/core/utils/typedefs.dart';
import 'package:flutter_achievments/features/profile/domain/entities/profile_entity.dart';
import 'package:flutter_achievments/features/profile/domain/repositories/profile_repo.dart';

class UpdateProfileUseCase extends UseCaseWithParams<ProfileEntity,ProfileEntity> {
  final ProfileRepo _repository;

  UpdateProfileUseCase(this._repository);
  
  @override
  ResultFuture<ProfileEntity> call(ProfileEntity params) async {
    return _repository.updateProfile(params);
  }
}