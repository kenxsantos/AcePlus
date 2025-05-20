import 'package:aceplus/features/card_game/domain/entities/transaction_entity.dart';

abstract class TransactionRepository {
  Future<void> addTransaction(TransactionEntity transactionEntity);

  TransactionEntity? getTransaction(int transactionId);

  List<TransactionEntity> getTransactionsByUserId(int userId);

  Future<List<TransactionEntity>> getTransactionsByUserIdAndType(
      int userId,
      String transactionType,
      );
}
