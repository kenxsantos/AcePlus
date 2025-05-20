import '../../repositories/auth_repository.dart';

class UpdateTotalMoneyUsecase {
  final AuthRepository repository;

  UpdateTotalMoneyUsecase(this.repository);

  Future<void> call(int userId, double amount) async {
    return await repository.updateTotalMoney(userId, amount);
  }
}