import 'package:aceplus/shared/utils/strings.dart';
import 'package:aceplus/shared/widgets/gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ButtonContainer extends StatelessWidget {
  const ButtonContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 50),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GradientButton(
            labelText: Str().playNow,
            onPressed: () => print("Go to Play Now"),
          ),
          GradientButton(
            labelText: Str().instruction,
            onPressed: () => print("Go to Instruction"),
          ),
        ],
      ),
    );
  }
}
