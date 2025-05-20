import 'package:aceplus/features/card_game/data/repositories/auth_repository.dart';
import 'package:aceplus/features/card_game/presentation/bloc/balance_bloc/balance_event.dart';
import 'package:aceplus/features/card_game/presentation/bloc/balance_bloc/balance_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BalanceBloc extends Bloc<BalanceEvent, BalanceState> {
  final AuthRepository userRepository;

  BalanceBloc({required this.userRepository}) : super(BalanceInitial()) {
    on<LoadTotalMoney>((event, emit) async {
      emit(BalanceLoading());
      try {
        final totalMoney = userRepository.getTotalMoney(event.userId);
        if (totalMoney != null) {
          emit(TotalMoneySuccessState(totalMoney));
        } else {
          emit(TotalMoneyError('Total money is null'));
        }
      } catch (e) {
        emit(TotalMoneyError(e.toString()));
      }
    });
  }
}
