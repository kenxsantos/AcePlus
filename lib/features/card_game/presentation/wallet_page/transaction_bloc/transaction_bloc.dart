import 'package:aceplus/core/repository/user_repository.dart';
import '../../../../../core/repository/transaction_repository.dart';
import 'package:aceplus/features/card_game/presentation/wallet_page/transaction_bloc/transaction_event.dart';
import 'package:aceplus/features/card_game/presentation/wallet_page/transaction_bloc/transaction_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final TransactionRepository repository;
  final UserRepository userRepository;

  TransactionBloc({required this.repository, required this.userRepository})
    : super(TransactionInitial()) {
    on<LoadTotalMoney>((event, emit) {
      try {
        final user = userRepository.getUser(int.parse(event.userId));
        final totalMoney = double.parse(
          (user?.totalMoney ?? 0.0).toStringAsFixed(2),
        );
        emit(TotalMoneySuccessState(totalMoney));
      } catch (e) {
        emit(TotalMoneyError('Failed to load total money: $e'));
      }
    });
  }
}
