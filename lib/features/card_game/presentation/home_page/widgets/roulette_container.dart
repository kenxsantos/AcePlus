import 'package:aceplus/shared/utils/constant.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class RouletteContainer extends StatefulWidget {
  const RouletteContainer({super.key});

  @override
  RouletteContainerState createState() => RouletteContainerState();
}

class RouletteContainerState extends State<RouletteContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 10000),
    )..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: -10,
      left: -150,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.rotate(
            angle: _controller.value * 2 * pi,
            child: Image.asset(
              fit: BoxFit.fill,
              width: 450,
              height: 450,
              "${imageUrl}roulette.png",
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
