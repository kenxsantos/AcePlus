import 'package:aceplus/shared/utils/constant.dart';
import 'package:flutter/material.dart';

class AceCard extends StatefulWidget {
  const AceCard({super.key});

  @override
  AceCardState createState() => AceCardState();
}

class AceCardState extends State<AceCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _animation = Tween<double>(
      begin: -300,
      end: -120,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Positioned(
          bottom: -15,
          right: _animation.value,
          child: Image.asset(
            fit: BoxFit.fill,
            height: 360,
            "${cardUrl}ace.png",
          ),
        );
      },
    );
  }
}
