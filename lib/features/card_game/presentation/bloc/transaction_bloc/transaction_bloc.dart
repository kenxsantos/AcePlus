import 'package:aceplus/features/card_game/domain/entities/transaction_entity.dart';
import 'package:aceplus/features/card_game/domain/usecases/auth_usecase/get_total_money_usecase.dart';
import 'package:aceplus/features/card_game/domain/usecases/auth_usecase/update_total_money_usecase.dart';
import 'package:aceplus/features/card_game/domain/usecases/transaction_usecase/add_transaction_usecase.dart';
import 'package:aceplus/features/card_game/domain/usecases/transaction_usecase/get_transaction_by_type_usecase.dart';
import 'package:aceplus/features/card_game/domain/usecases/transaction_usecase/get_transaction_usecase.dart';
import 'package:aceplus/features/card_game/presentation/bloc/transaction_bloc/transaction_event.dart';
import 'package:aceplus/features/card_game/presentation/bloc/transaction_bloc/transaction_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final AddTransactionUsecase addTransactionUsecase;
  final GetTransactionUsecase getTransactionUsecase;
  final GetTransactionByTypeUsecase getTransactionByTypeUsecase;
  final GetTotalMoneyUsecase getTotalMoneyUsecase;
  final UpdateTotalMoneyUsecase updateTotalMoneyUsecase;

  TransactionBloc({
    required this.addTransactionUsecase,
    required this.getTransactionUsecase,
    required this.getTransactionByTypeUsecase,
    required this.getTotalMoneyUsecase,
    required this.updateTotalMoneyUsecase,
  }) : super(TransactionInitial()) {
    on<AddTransaction>((event, emit) async {
      emit(TransactionLoading());
      try {
        final userId = int.tryParse(event.userId);
        final amount = double.tryParse(event.amount);

        if (userId == null || amount == null) {
          emit(TransactionError('Invalid user ID or amount'));
          return;
        }

        final currentTotal = getTotalMoneyUsecase.call(userId) ?? 0.0;

        if (event.transactionType == "Cash Out" && amount > currentTotal) {
          emit(TransactionError('Insufficient balance'));
          return;
        }

        final double newTotal;
        if (event.transactionType == "Cash In") {
          newTotal = currentTotal + amount;
        } else if (event.transactionType == "Cash Out") {
          newTotal = currentTotal - amount;
        } else {
          emit(TransactionError('Invalid transaction type'));
          return;
        }

        final transaction = TransactionEntity(
          transactionId: 0,
          userId: userId,
          transactionType: event.transactionType,
          amount: amount,
          mobileNumber: event.mobileNumber,
          transactionDate: DateTime.now(),
          referenceNumber: DateTime.now().millisecondsSinceEpoch.toString(),
        );

        await updateTotalMoneyUsecase.call(userId, newTotal);

        await addTransactionUsecase.call(transaction);
        emit(
          TransactionSuccessState(
            '${event.transactionType} transaction completed successfully',
          ),
        );
      } catch (e) {
        emit(TransactionError('Transaction failed: ${e.toString()}'));
      }
    });

    on<LoadTransaction>((event, emit) async {
      emit(TransactionLoading());
      try {
        final transaction = getTransactionUsecase.call(event.transactionId);
        emit(TransactionLoaded(transaction as TransactionEntity));
      } catch (e) {
        emit(TransactionError(e.toString()));
      }
    });

    on<LoadTransactionByType>((event, emit) async {
      try {
        final transactions = await getTransactionByTypeUsecase.call(event.userId, event.transactionType);

        if (transactions.isEmpty) {
          emit(NoDataState("No transactions found"));
          return;
        }
        emit(TransactionsLoaded(transactions));
      } catch (e) {
        emit(TransactionError(e.toString()));
      }
    });
  }
}
