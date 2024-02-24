import 'package:flutter_achievments/core/usecase/usecase.dart';
import 'package:flutter_achievments/core/utils/typedefs.dart';
import 'package:flutter_achievments/features/profile/domain/entities/profile_entity.dart';
import 'package:flutter_achievments/features/profile/domain/repositories/profile_repo.dart';

class CreateChildProfileUseCase
    extends UseCaseWithParams<String, ProfileEntity> {
  final ProfileRepo _profileRepository;

  CreateChildProfileUseCase(this._profileRepository);

  @override
  ResultFuture<String> call(ProfileEntity params) {
    return _profileRepository.createChildProfile(
      params
    );
  }
}
