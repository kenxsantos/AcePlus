import 'dart:math';

import 'package:aceplus/features/card_game/data/model/transaction_model/transaction_model.dart';
import 'package:hive/hive.dart';

class TransactionDataSource {
  final Box<Transaction> _transactionBox = Hive.box<Transaction>('transaction');

  int getNextTransactionId() {
    if (_transactionBox.isEmpty) {
      return 1;
    }

    return _transactionBox.values
            .map((transaction) => transaction.transactionId)
            .reduce((max, id) => id > max ? id : max) +
        1;
  }

  Future<void> addTransaction(Transaction transaction) async {
    String referenceNumber = transaction.referenceNumber;

    while (referenceNumberExists(referenceNumber)) {
      referenceNumber = generateReferenceNumber();
    }

    final newTransactionId = getNextTransactionId();

    final newTransaction = Transaction(
      transactionId: newTransactionId,
      userId: transaction.userId,
      transactionType: transaction.transactionType,
      amount: transaction.amount,
      mobileNumber: transaction.mobileNumber,
      transactionDate: DateTime.now(),
      referenceNumber: referenceNumber,
    );

    await _transactionBox.put(newTransaction.transactionId, newTransaction);
  }

  Transaction? getTransaction(int transactionId) {
    return _transactionBox.get(transactionId);
  }

  List<Transaction> getTransactionsByUserId(int userId) {
    return _transactionBox.values
        .where((transaction) => transaction.userId == userId)
        .toList();
  }

  Future<List<Transaction>> getTransactionsByUserIdAndType(
    int userId,
    String transactionType,
  ) async {
    return _transactionBox.values
        .where(
          (transaction) =>
              transaction.userId == userId &&
              transaction.transactionType == transactionType,
        )
        .toList()
      ..sort((a, b) => b.transactionDate.compareTo(a.transactionDate));
  }

  bool referenceNumberExists(String referenceNumber) {
    return _transactionBox.values.any(
      (transaction) => transaction.referenceNumber == referenceNumber,
    );
  }

  String generateReferenceNumber() {
    final Random random = Random();
    const int length = 16;
    return List.generate(length, (_) => random.nextInt(10).toString()).join();
  }
}
