import '../../../../../core/model/transaction_model/transaction_model.dart';

abstract class TransactionEvent {
  const TransactionEvent();
}

class LoadTotalMoney extends TransactionEvent {
  final String userId;
  const LoadTotalMoney(this.userId);
}

class AddTransaction extends TransactionEvent {
  final Transaction transaction;
  const AddTransaction(this.transaction);
}