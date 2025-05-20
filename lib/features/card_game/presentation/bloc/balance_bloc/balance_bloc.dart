import 'package:aceplus/features/card_game/domain/usecases/auth_usecase/get_total_money_usecase.dart';
import 'package:aceplus/features/card_game/presentation/bloc/balance_bloc/balance_event.dart';
import 'package:aceplus/features/card_game/presentation/bloc/balance_bloc/balance_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BalanceBloc extends Bloc<BalanceEvent, BalanceState> {
  final GetTotalMoneyUsecase getTotalMoneyUsecase;

  BalanceBloc({required this.getTotalMoneyUsecase}) : super(BalanceInitial()) {
    on<LoadTotalMoney>((event, emit) async {
      emit(BalanceLoading());
      try {
        final totalMoney = getTotalMoneyUsecase.call(event.userId);
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
