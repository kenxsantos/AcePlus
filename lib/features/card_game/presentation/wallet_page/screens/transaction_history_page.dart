import 'package:aceplus/features/card_game/presentation/wallet_page/widgets/history_tab.dart';
import 'package:aceplus/shared/utils/constant.dart';
import 'package:aceplus/shared/utils/strings.dart';
import 'package:aceplus/shared/widgets/gradient_gold_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../transaction_bloc/transaction_bloc.dart';
import '../transaction_bloc/transaction_event.dart';
import '../transaction_bloc/transaction_state.dart';
import '../widgets/cash_in_button.dart';

class TransactionHistoryPage extends StatefulWidget {
  final String id;

  const TransactionHistoryPage({super.key, required this.id});

  @override
  State<TransactionHistoryPage> createState() => _TransactionHistoryPageState();
}

class _TransactionHistoryPageState extends State<TransactionHistoryPage> {
  late final String id;

  @override
  void initState() {
    super.initState();
    id = widget.id;
    context.read<TransactionBloc>().add(LoadTotalMoney(int.parse(id)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              Str().eWallet,
              style: TextStyle(
                color: primaryYellow,
                fontFamily: lemon,
                fontSize: 20,
              ),
            ),
          ],
        ),
        backgroundColor: primaryBlack,
        automaticallyImplyLeading: true,
        leading: IconButton(
          onPressed: () => context.go('/wallet/$id'),
          color: primaryWhite,
          icon: Icon(Icons.arrow_back_ios_new_rounded),
        ),
      ),
      body: Container(
        color: primaryBlack,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            BlocBuilder<TransactionBloc, TransactionState>(
              builder: (context, state) {
                if (state is TotalMoneySuccessState) {
                  return GradientGoldContainer(
                    balanceText: Str().currentBalance,
                    totalMoney: state.totalMoney,
                    actionButton: CashInButton(id: id),
                  );
                } else if (state is TotalMoneyError) {
                  return GradientGoldContainer(
                    balanceText: Str().currentBalance,
                    totalMoney: "Failed to fetch data",
                    actionButton: CashInButton(id: id),
                  );
                }
                return GradientGoldContainer(
                  balanceText: Str().currentBalance,
                  totalMoney: 0,
                  actionButton: CashInButton(id: id),
                );
              },
            ),
            Expanded(
              child: Container(color: primaryBlack, child: HistoryTabBar()),
            ),
          ],
        ),
      ),
    );
  }
}
