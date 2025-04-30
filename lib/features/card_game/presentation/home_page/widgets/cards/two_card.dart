import 'package:aceplus/shared/utils/constant.dart';
import 'package:flutter/material.dart';

class TwoCard extends StatefulWidget {
  const TwoCard({super.key});

  @override
  TwoCardState createState() => TwoCardState();
}

class TwoCardState extends State<TwoCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _bottomAnimation;
  late Animation<double> _rightAnimation;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    _bottomAnimation = Tween<double>(
      begin: 0,
      end: -75,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _rightAnimation = Tween<double>(
      begin: -300,
      end: 85,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _rotationAnimation = Tween<double>(
      begin: 0,
      end: -0.55,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Positioned(
          bottom: _bottomAnimation.value,
          right: _rightAnimation.value,
          child: Transform.rotate(
            angle: _rotationAnimation.value,
            child: Image.asset(
              fit: BoxFit.fill,
              height: 330,
              "${cardUrl}two.png",
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
