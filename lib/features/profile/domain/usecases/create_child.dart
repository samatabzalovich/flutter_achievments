// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_achievments/core/usecase/usecase.dart';
import 'package:flutter_achievments/core/utils/typedefs.dart';
import 'package:flutter_achievments/features/profile/domain/repositories/profile_repo.dart';

class CreateChildUseCase extends UseCaseWithParams<String, CreateChildParams> {
  final ProfileRepo _profileRepository;

  CreateChildUseCase(this._profileRepository);

  @override
  ResultFuture<String> call(CreateChildParams params)  {
    return _profileRepository.createChild(email: params.email, password: params.password);
  }
}

class CreateChildParams {
  final String email;
  final String password;
  CreateChildParams({
    required this.email,
    required this.password,
  });

}
