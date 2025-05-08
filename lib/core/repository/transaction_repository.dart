import '../data_source/transaction_data_source.dart';
import '../model/transaction_model/transaction_model.dart';

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

  List<Transaction> getTransactionsByUserIdAndType(
    int userId,
    String transactionType,
  ) {
    return _dataSource.getTransactionsByUserIdAndType(userId, transactionType);
  }
}
