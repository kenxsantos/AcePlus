import '../../repositories/auth_repository.dart';

class GetTotalMoneyUsecase {
  final AuthRepository repository;

  GetTotalMoneyUsecase(this.repository);

  double? call(int userId) {
    return repository.getTotalMoney(userId);
  }
}