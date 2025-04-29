import 'package:aceplus/shared/utils/constant.dart';
import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({super.key, required this.labelText});

  final String labelText;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: double.infinity,
        alignment: Alignment.center,
        margin: EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
          color: primaryYellow,
          borderRadius: BorderRadius.all(Radius.circular(50)),
        ),
        height: 60,
        child: Text(
          labelText,
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
      ),
    );
  }
}
