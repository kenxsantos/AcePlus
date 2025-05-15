import 'package:flutter/material.dart';
import 'dart:async';

class OddsTextWidget extends StatefulWidget {
  final double odds;

  const OddsTextWidget({super.key, required this.odds});

  @override
  State<OddsTextWidget> createState() => _OddsTextWidgetState();
}

class _OddsTextWidgetState extends State<OddsTextWidget>
    with TickerProviderStateMixin {
  late AnimationController bounceController;
  late Animation<double> bounceAnimation;
  bool showText = false;

  @override
  void initState() {
    super.initState();

    // Delay before showing text (Fade-in effect)
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        setState(() {
          showText = true;
        });

        // Start bounce animation
        bounceController.forward();
      }
    });

    // Bounce Animation Setup
    bounceController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    bounceAnimation = Tween<double>(begin: 0, end: 10).animate(
      CurvedAnimation(parent: bounceController, curve: Curves.bounceOut),
    );
  }

  @override
  void dispose() {
    bounceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 300),
      opacity: showText ? 1.0 : 0.0, // Fade-in effect

      child: AnimatedBuilder(
        animation: bounceAnimation,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(0, -bounceAnimation.value), // Bounce effect
            child: Text(
              widget.odds == 1.00 ? "" : widget.odds.toStringAsFixed(2),
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                shadows: [
                  Shadow(
                    blurRadius: 2,
                    color: Colors.black,
                    offset: Offset(1, 1),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
