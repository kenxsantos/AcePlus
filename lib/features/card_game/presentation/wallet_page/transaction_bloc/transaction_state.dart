import '../../../../../core/model/transaction_model/transaction_model.dart';

abstract class TransactionState {
  const TransactionState();
}

class TransactionInitial extends TransactionState {}

class TransactionLoading extends TransactionState {}

class TransactionsLoaded extends TransactionState {
  final List<Transaction> transactions;
  const TransactionsLoaded(this.transactions);
}

class TransactionsError extends TransactionState {
  final String message;
  const TransactionsError(this.message);
}

class TransactionSuccessState extends TransactionState {
  final String message;
  const TransactionSuccessState(this.message);
}

class TransactionError extends TransactionState {
  final String error;
  TransactionError(this.error);
}