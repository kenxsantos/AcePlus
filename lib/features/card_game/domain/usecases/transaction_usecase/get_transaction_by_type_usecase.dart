import '../../entities/transaction_entity.dart';
import '../../repositories/transaction_repository.dart';

class GetTransactionByTypeUsecase {
  final TransactionRepository repository;

  GetTransactionByTypeUsecase(this.repository);

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
