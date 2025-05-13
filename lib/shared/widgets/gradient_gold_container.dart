import 'package:aceplus/shared/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: '\u20B1 ',
                      style: TextStyle(
                        fontFamily: 'Arial',
                        fontSize: 25,
                        color: totalMoney is String ? Colors.red : Colors.black,
                      ),
                    ),
                    TextSpan(
                      text: totalMoney is String
                          ? totalMoney
                          : NumberFormat('#,##0.00').format(totalMoney),
                      style: TextStyle(
                        fontSize: 25,
                        color: totalMoney is String ? Colors.red : Colors.black,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          actionButton,
        ],
      ),
    );
  }
}
