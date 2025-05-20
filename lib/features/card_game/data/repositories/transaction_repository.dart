import 'package:aceplus/features/card_game/data/model/transaction_model/transaction_model.dart';
import 'package:aceplus/features/card_game/data/datasource/transaction_data_source.dart';
import 'package:aceplus/features/card_game/domain/entities/transaction_entity.dart';
import '../../domain/repositories/transaction_repository.dart';

class TransactionRepositoryImpl implements TransactionRepository {
  final TransactionDataSource _dataSource;

  TransactionRepositoryImpl(this._dataSource);

  @override
  Future<void> addTransaction(TransactionEntity transactionEntity) async {
    final transactionModel = Transaction.fromEntity(transactionEntity);
    await _dataSource.addTransaction(transactionModel);
  }

  @override
  TransactionEntity? getTransaction(int transactionId) {
    final transactionModel = _dataSource.getTransaction(transactionId);
    return transactionModel?.toEntity();
  }

  @override
  List<TransactionEntity> getTransactionsByUserId(int userId) {
    return _dataSource
        .getTransactionsByUserId(userId)
        .map((model) => model.toEntity())
        .toList();
  }

  @override
  Future<List<TransactionEntity>> getTransactionsByUserIdAndType(
      int userId,
      String transactionType,
      ) async {
    final models = await _dataSource.getTransactionsByUserIdAndType(
      userId,
      transactionType,
    );
    return models.map((model) => model.toEntity()).toList();
  }
}