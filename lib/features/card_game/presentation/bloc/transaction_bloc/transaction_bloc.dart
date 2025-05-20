import 'package:aceplus/features/card_game/data/model/transaction_model/transaction_model.dart';
import 'package:aceplus/features/card_game/data/repositories/auth_repository.dart';
import 'package:aceplus/features/card_game/data/repositories/transaction_repository.dart';
import 'package:aceplus/features/card_game/presentation/bloc/transaction_bloc/transaction_event.dart';
import 'package:aceplus/features/card_game/presentation/bloc/transaction_bloc/transaction_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final TransactionRepository repository;
  final AuthRepository userRepository;

  TransactionBloc({required this.repository, required this.userRepository})
    : super(TransactionInitial()) {
    on<AddTransaction>((event, emit) async {
      emit(TransactionLoading());
      try {
        final userId = int.tryParse(event.userId);
        final amount = double.tryParse(event.amount);

        if (userId == null || amount == null) {
          emit(TransactionError('Invalid user ID or amount'));
          return;
        }

        final currentTotal = userRepository.getTotalMoney(userId) ?? 0.0;

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

        final transaction = Transaction(
          transactionId: 0,
          userId: userId,
          transactionType: event.transactionType,
          amount: amount,
          mobileNumber: event.mobileNumber,
          transactionDate: DateTime.now(),
          referenceNumber: DateTime.now().millisecondsSinceEpoch.toString(),
        );

        await userRepository.updateTotalMoney(userId, newTotal);

        await repository.addTransaction(transaction);
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
        print("TransactionId in Bloc: ${event.transactionId}");
        final transaction = repository.getTransaction(event.transactionId);
        print('Transaction: $transaction');
        emit(TransactionLoaded(transaction!));
      } catch (e) {
        emit(TransactionError(e.toString()));
      }
    });

    on<LoadTransactionByType>((event, emit) async {
      try {
        final transactions = await repository.getTransactionsByUserIdAndType(
          event.userId,
          event.transactionType,
        );

        if (transactions.isEmpty) {
          emit(NoDataState("No transactions found"));
          return;
        }

        print(
          'Transactions Type: ${event.transactionType} Transactions: $transactions',
        );
        emit(TransactionsLoaded(transactions));
      } catch (e) {
        emit(TransactionError(e.toString()));
      }
    });
  }
}
