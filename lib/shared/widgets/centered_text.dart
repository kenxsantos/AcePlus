import 'package:flutter/material.dart';

import '../utils/constant.dart ';

class CenteredText extends StatelessWidget {
  final String text;
  final Color color;

  const CenteredText(this.text, this.color, {super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: 14.0,
          fontWeight: FontWeight.bold,
          fontFamily: poppins
        ),
      ),
    );
  }
}