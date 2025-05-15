import 'package:aceplus/core/model/transaction_model/transaction_model.dart';
import 'package:aceplus/core/datasource/transaction_data_source.dart';

class TransactionRepository {
  final TransactionDataSource _dataSource;

  TransactionRepository(this._dataSource);

  Future<void> addTransaction(Transaction transaction) async {
    await _dataSource.addTransaction(transaction);
  }

  Transaction? getTransaction(int transactionId) {
    return _dataSource.getTransaction(transactionId);
  }

  List<Transaction> getTransactionsByUserId(int userId) {
    return _dataSource.getTransactionsByUserId(userId);
  }

  Future<List<Transaction>> getTransactionsByUserIdAndType(
    int userId,
    String transactionType,
  ) async {
    return await _dataSource.getTransactionsByUserIdAndType(
      userId,
      transactionType,
    );
  }
}
