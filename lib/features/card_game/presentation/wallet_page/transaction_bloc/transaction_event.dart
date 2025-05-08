abstract class TransactionEvent {
  const TransactionEvent();
}

class LoadTotalMoney extends TransactionEvent {
  final String userId;
  const LoadTotalMoney(this.userId);
}