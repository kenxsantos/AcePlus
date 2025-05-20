import '../../entities/transaction_entity.dart';
import '../../repositories/transaction_repository.dart';

class GetTransactionByIdUsecase {
  final TransactionRepository repository;

  GetTransactionByIdUsecase(this.repository);

  List<TransactionEntity> call(int userId) {
    return repository.getTransactionsByUserId(userId);
  }
}