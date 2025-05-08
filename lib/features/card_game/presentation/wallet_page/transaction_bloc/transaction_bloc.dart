import '../../../../../core/repository/auth_repository.dart';
import '../../../../../core/repository/transaction_repository.dart';
import 'package:aceplus/features/card_game/presentation/wallet_page/transaction_bloc/transaction_event.dart';
import 'package:aceplus/features/card_game/presentation/wallet_page/transaction_bloc/transaction_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final TransactionRepository repository;
  final AuthRepository userRepository;

  TransactionBloc({required this.repository, required this.userRepository})
      : super(TransactionInitial()) {
    on<LoadTotalMoney>((event, emit) async {
      emit(TotalMoneyLoading());
      try {
        final totalMoney = userRepository.getTotalMoney(event.userId as int);
        emit(TotalMoneySuccessState(totalMoney!));
      } catch (e) {
        emit(TotalMoneyError(e.toString()));
      }
    });
  }
}
