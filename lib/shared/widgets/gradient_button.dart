import 'package:aceplus/shared/utils/constant.dart';
import 'package:flutter/material.dart';

class GradientButton extends StatelessWidget {
  const GradientButton({
    super.key,
    required this.labelText,
    this.width,
    required this.onPressed,
  });

  final String labelText;
  final double? width;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        decoration: BoxDecoration(
          gradient: gold,
          borderRadius: BorderRadius.all(Radius.circular(50)),
        ),
        height: 40,
        child: Text(
          labelText,
          style: TextStyle(
            color: primaryBlack,
            fontSize: 16,
            fontFamily: poppins,
          ),
        ),
      ),
    );
  }
}
