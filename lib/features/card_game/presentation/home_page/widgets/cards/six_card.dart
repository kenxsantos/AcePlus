import 'package:aceplus/shared/utils/constant.dart';
import 'package:flutter/material.dart';

class SixCard extends StatefulWidget {
  const SixCard({super.key});

  @override
  SixCardState createState() => SixCardState();
}

class SixCardState extends State<SixCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _bottomAnimation;
  late Animation<double> _rightAnimation;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _bottomAnimation = Tween<double>(
      begin: 0,
      end: -150,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _rightAnimation = Tween<double>(
      begin: -300,
      end: 150,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _rotationAnimation = Tween<double>(
      begin: 0,
      end: -0.8,
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
              "${cardUrl}six.png",
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
