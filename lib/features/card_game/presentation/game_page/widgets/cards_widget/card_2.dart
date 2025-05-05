import 'package:flutter/material.dart';

class Card2 extends StatelessWidget {
  final AnimationController controller;
  final Animation<double> rotationAnimation;
  final Animation<Offset> positionAnimation;

  const Card2({
    super.key,
    required this.controller,
    required this.rotationAnimation,
    required this.positionAnimation,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Transform.translate(
          offset:
              positionAnimation.value * MediaQuery.of(context).size.width / 2,
          child: Transform.rotate(angle: rotationAnimation.value, child: child),
        );
      },
      child: Image.asset("assets/images/card_back.png", width: 50, height: 66),
    );
  }
}
