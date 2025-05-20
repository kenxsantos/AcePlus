abstract class BalanceState {
  const BalanceState();
}

class BalanceInitial extends BalanceState {}

class BalanceLoading extends BalanceState {}

class TotalMoneySuccessState extends BalanceState {
  final double totalMoney;
  const TotalMoneySuccessState(this.totalMoney);
}

class TotalMoneyError extends BalanceState {
  final String message;
  const TotalMoneyError(this.message);
}
