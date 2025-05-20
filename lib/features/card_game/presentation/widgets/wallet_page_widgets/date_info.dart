import 'package:aceplus/shared/utils/constant.dart';
import 'package:flutter/material.dart';

class DateInfo extends StatelessWidget {
  const DateInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'April',
          style: TextStyle(
            fontSize: 14,
            color: primaryWhite,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          '29',
          style: TextStyle(
            fontSize: 16,
            color: primaryWhite,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
