import '../../repositories/auth_repository.dart';

class MobileNumberExistUsecase {
  final AuthRepository repository;

  MobileNumberExistUsecase(this.repository);

  bool call(String mobileNumber) {
    return repository.mobileNumberExists(mobileNumber);
  }
}