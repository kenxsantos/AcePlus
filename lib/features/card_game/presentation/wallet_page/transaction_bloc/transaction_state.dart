import '../../../../../core/model/transaction_model/transaction_model.dart';

abstract class TransactionState {
  const TransactionState();
}

class TransactionInitial extends TransactionState {}

class TotalMoneyInitial extends TransactionState {}

class TransactionLoading extends TransactionState {}

class TotalMoneyLoading extends TransactionState {}

class TransactionLoaded extends TransactionState {
  final List<Transaction> transactions;
  const TransactionLoaded(this.transactions);
}

class TotalMoneySuccessState extends TransactionState {
  final double totalMoney;
  const TotalMoneySuccessState(this.totalMoney);
}

class TotalMoneyError extends TransactionState {
  final String message;
  const TotalMoneyError(this.message);
}

class TransactionError extends TransactionState {
  final String message;
  const TransactionError(this.message);
}