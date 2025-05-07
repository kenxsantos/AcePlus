import 'dart:math';
import 'package:flutter/material.dart';

class Card1 extends StatelessWidget {
  final AnimationController flipController;
  final Animation<double> flipAnimation;

  final AnimationController controller;
  final Animation<double> rotationAnimation;
  final Animation<Offset> positionAnimation;
  final bool isFlipped;

  const Card1({
    super.key,
    required this.flipController,
    required this.flipAnimation,
    required this.controller,
    required this.rotationAnimation,
    required this.positionAnimation,
    required this.isFlipped,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: isFlipped ? flipAnimation : controller,
      builder: (context, child) {
        final isHalfway = flipAnimation.value > pi / 2;
        return Transform.translate(
          offset:
              positionAnimation.value * MediaQuery.of(context).size.width / 2,
          child: Transform.rotate(
            angle: rotationAnimation.value,
            child: Transform(
              alignment: Alignment.center,
              transform:
                  Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..rotateY(flipAnimation.value),
              child:
                  isHalfway
                      ? Image.asset(
                        "assets/images/joker.png",
                        width: 50,
                        height: 66,
                      )
                      : Image.asset(
                        "assets/images/card_back.png",
                        width: 50,
                        height: 66,
                      ),
            ),
          ),
        );
      },
    );
  }
}
