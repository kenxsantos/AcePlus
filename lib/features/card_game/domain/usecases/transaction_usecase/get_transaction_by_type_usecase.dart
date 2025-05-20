import '../../entities/transaction_entity.dart';
import '../../repositories/transaction_repository.dart';

class GetTransactionByType {
  final TransactionRepository repository;

  GetTransactionByType(this.repository);

  Future<List<TransactionEntity>> call(
    int userId,
    String transactionType,
  ) async {
    return await repository.getTransactionsByUserIdAndType(
      userId,
      transactionType,
    );
  }
}
