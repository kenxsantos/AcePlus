import 'package:aceplus/shared/utils/constant.dart';
import 'package:flutter/material.dart';

class SolidButton extends StatelessWidget {
  const SolidButton({
    super.key,
    required this.labelText,
    this.fontFamily,
    required this.onPressed,
  });

  final String labelText;
  final String? fontFamily;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        alignment: Alignment.center,
        margin: EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
          color: primaryYellow,
          borderRadius: BorderRadius.all(Radius.circular(50)),
        ),
        height: 45,
        child: Text(
          labelText,
          style: TextStyle(
            color: primaryBlack,
            fontSize: 16,
            fontFamily: fontFamily,
          ),
        ),
      ),
    );
  }
}
