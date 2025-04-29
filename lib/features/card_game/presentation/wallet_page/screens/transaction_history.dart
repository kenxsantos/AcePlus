import 'package:aceplus/features/card_game/presentation/wallet_page/widgets/history_tab.dart';
import 'package:aceplus/features/card_game/presentation/wallet_page/widgets/wallet_tab.dart';
import 'package:aceplus/shared/widgets/gradient_gold_container.dart';
import 'package:flutter/material.dart';

class TransactionHistory extends StatefulWidget {
  const TransactionHistory({super.key});

  @override
  State<TransactionHistory> createState() => _TransactionHistoryState();
}

class _TransactionHistoryState extends State<TransactionHistory> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Column(
        children: [
          GradientGoldContainer(),
          Expanded(
            child: Container(color: Colors.black, child: HistoryTabBar()),
          ),
        ],
      ),
    );
  }
}
