class TransactionEntity {
  final int transactionId;
  final int userId;
  final String transactionType;
  final double amount;
  final String mobileNumber;
  final DateTime transactionDate;
  final String referenceNumber;

  TransactionEntity({
    required this.transactionId,
    required this.userId,
    required this.transactionType,
    required this.amount,
    required this.mobileNumber,
    required this.transactionDate,
    required this.referenceNumber,
  });
}
