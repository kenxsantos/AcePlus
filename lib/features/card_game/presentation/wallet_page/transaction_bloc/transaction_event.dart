abstract class TransactionEvent {
  const TransactionEvent();
}

class AddTransaction extends TransactionEvent {
  final String userId;
  final String transactionType;
  final String amount;
  final String mobileNumber;

  const AddTransaction({
    required this.userId,
    required this.transactionType,
    required this.amount,
    required this.mobileNumber,
  });
}

class LoadTransaction extends TransactionEvent {
  final int userId;
  LoadTransaction({required this.userId});
}

class LoadTransactionByType extends TransactionEvent {
  final int userId;
  final String transactionType;
  LoadTransactionByType({required this.userId, required this.transactionType});
}