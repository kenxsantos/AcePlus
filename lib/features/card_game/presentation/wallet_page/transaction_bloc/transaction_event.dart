abstract class TransactionEvent {
  const TransactionEvent();
}

class LoadTotalMoney extends TransactionEvent {
  final int userId;
  const LoadTotalMoney(this.userId);
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