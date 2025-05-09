abstract class BalanceEvent {
  const BalanceEvent();
}

class LoadTotalMoney extends BalanceEvent {
  final int userId;
  const LoadTotalMoney(this.userId);
}