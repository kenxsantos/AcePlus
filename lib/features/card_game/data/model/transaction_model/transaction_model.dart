import 'package:hive/hive.dart';

part 'transaction_model.g.dart';

@HiveType(typeId: 1)
class Transaction extends HiveObject {
  @HiveField(0)
  final int transactionId;

  @HiveField(1)
  final int userId;

  @HiveField(2)
  final String transactionType;

  @HiveField(3)
  final double amount;

  @HiveField(4)
  final String mobileNumber;

  @HiveField(5)
  final DateTime transactionDate;

  @HiveField(6)
  final String referenceNumber;

  Transaction({
    required this.transactionId,
    required this.userId,
    required this.transactionType,
    required this.amount,
    required this.mobileNumber,
    required this.transactionDate,
    required this.referenceNumber,
  });

  @override
  String toString() {
    return 'Transaction{transactionId: $transactionId, userId: $userId, transactionType: $transactionType, amount: $amount, mobileNumber: $mobileNumber, transactionDate: $transactionDate, referenceNumber: $referenceNumber}';
  }
}
