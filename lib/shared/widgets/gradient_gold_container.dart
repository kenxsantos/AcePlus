import 'package:aceplus/features/card_game/presentation/wallet_page/widgets/cash_in_button.dart';
import 'package:aceplus/shared/utils/constant.dart';
import 'package:flutter/material.dart';

class GradientGoldContainer extends StatelessWidget {
  const GradientGoldContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100.0,
      margin: EdgeInsets.all(6),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: gold,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Current Balance"),
              Text(" 1,000,000.00", style: TextStyle(fontSize: 25)),
            ],
          ),
          CashInButton(),
        ],
      ),
    );
  }
}
