import 'package:flutter/material.dart';

import '../utils/constant.dart ';

class GradientText extends StatelessWidget {
  final String text;
  final TextStyle textStyle;
  final Gradient gradient;

  const GradientText({
    super.key,
    required this.text,
    required this.textStyle,
    this.gradient = gold,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) {
        return gradient.createShader(bounds);
      },
      child: Text(
        text,
        style: textStyle.copyWith(color: Colors.white),
      ),
    );
  }
}
