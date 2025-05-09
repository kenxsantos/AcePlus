import '../../../../../core/model/transaction_model/transaction_model.dart';
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

        emit(TransactionSuccessState('Transaction added successfully'));
      } catch (e) {
        emit(TransactionError('Transaction failed: ${e.toString()}'));
      }
    });

    on<LoadTransaction>((event, emit) async {
      emit(TransactionLoading());
      try {
        final transactions = repository.getTransactionsByUserId(event.userId);
        print('Transactions: $transactions');
        emit(TransactionLoaded(transactions));
      } catch (e) {
        emit(TransactionError(e.toString()));
      }
    });
  }
}
