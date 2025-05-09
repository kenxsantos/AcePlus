import 'package:aceplus/shared/utils/constant.dart';
import 'package:flutter/material.dart';

class GradientGoldContainer extends StatelessWidget {
  final String balanceText;
  final dynamic totalMoney;
  final Widget actionButton;

  const GradientGoldContainer({
    super.key,
    required this.balanceText,
    required this.totalMoney,
    required this.actionButton,
  });

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
              Text(balanceText),
              Text(
                totalMoney is String
                    ? totalMoney
                    : totalMoney.toStringAsFixed(2),
                style: TextStyle(
                  fontSize: 25,
                  color: totalMoney is String ? Colors.red : Colors.black,
                ),
              ),
            ],
          ),
          actionButton,
        ],
      ),
    );
  }
}
