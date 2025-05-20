import '../../repositories/auth_repository.dart';

class SearchAuthUsecase {
  final AuthRepository repository;

  SearchAuthUsecase(this.repository);

  int? call(String mobileNumber, String password) {
    return repository.searchAuth(mobileNumber, password);
  }
}