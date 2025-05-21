import '../../entities/transaction_entity.dart';
import '../../repositories/transaction_repository.dart';

class AddTransactionUsecase {
  final TransactionRepository repository;

  AddTransactionUsecase(this.repository);

  Future<void> call(TransactionEntity transactionEntity) async {
    return await repository.addTransaction(transactionEntity);
  }
}