import '../../entities/transaction_entity.dart';
import '../../repositories/transaction_repository.dart';

class GetTransaction {
  final TransactionRepository repository;

  GetTransaction(this.repository);

  TransactionEntity? call(int transactionId) {
    return repository.getTransaction(transactionId);
  }
}