import '../../entities/transaction_entity.dart';
import '../../repositories/transaction_repository.dart';

class GetTransactionUsecase {
  final TransactionRepository repository;

  GetTransactionUsecase(this.repository);

  TransactionEntity? call(int transactionId) {
    return repository.getTransaction(transactionId);
  }
}