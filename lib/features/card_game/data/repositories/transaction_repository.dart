import 'package:aceplus/features/card_game/data/model/transaction_model/transaction_model.dart';
import 'package:aceplus/features/card_game/data/datasource/transaction_data_source.dart';
import 'package:aceplus/features/card_game/domain/entities/transaction_entity.dart';
import '../../domain/repositories/transaction_repository.dart';

class TransactionRepositoryImpl implements TransactionRepository {
  final TransactionDataSource _dataSource;

  TransactionRepositoryImpl(this._dataSource);

  Transaction _toTransactionModel(TransactionEntity entity) {
    return Transaction(
      transactionId: entity.transactionId,
      userId: entity.userId,
      transactionType: entity.transactionType,
      amount: entity.amount,
      mobileNumber: entity.mobileNumber,
      transactionDate: entity.transactionDate,
      referenceNumber: entity.referenceNumber,
    );
  }

  TransactionEntity _toTransactionEntity(Transaction model) {
    return TransactionEntity(
      transactionId: model.transactionId,
      userId: model.userId,
      transactionType: model.transactionType,
      amount: model.amount,
      mobileNumber: model.mobileNumber,
      transactionDate: model.transactionDate,
      referenceNumber: model.referenceNumber,
    );
  }

  @override
  Future<void> addTransaction(TransactionEntity transactionEntity) async {
    final transactionModel = _toTransactionModel(transactionEntity);
    await _dataSource.addTransaction(transactionModel);
  }

  @override
  TransactionEntity? getTransaction(int transactionId) {
    final transactionModel = _dataSource.getTransaction(transactionId);
    return transactionModel != null
        ? _toTransactionEntity(transactionModel)
        : null;
  }

  @override
  List<TransactionEntity> getTransactionsByUserId(int userId) {
    return _dataSource
        .getTransactionsByUserId(userId)
        .map(_toTransactionEntity)
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
    return models.map(_toTransactionEntity).toList();
  }
}
