import 'package:flutter/material.dart';

class XCircleAnimation extends StatefulWidget {
  const XCircleAnimation({super.key});

  @override
  State<XCircleAnimation> createState() => _XCircleAnimationState();
}

class _XCircleAnimationState extends State<XCircleAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    )..forward();
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return CustomPaint(
          painter: XCirclePainter(_animation.value),
          size: const Size(50, 50),
        );
      },
    );
  }
}

class XCirclePainter extends CustomPainter {
  final double progress;

  XCirclePainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5.0
      ..strokeCap = StrokeCap.round;

    // Draw the circle
    final Path circlePath = Path()
      ..addArc(
        Rect.fromCircle(
          center: Offset(size.width / 2, size.height / 2),
          radius: size.width / 2,
        ),
        0,
        2 * 3.1416 * progress,
      );

    // Draw the "X"
    final Path xPath = Path();
    xPath.moveTo(size.width * 0.3, size.height * 0.3);
    xPath.lineTo(size.width * 0.7 * progress, size.height * 0.7 * progress);
    xPath.moveTo(size.width * 0.7, size.height * 0.3);
    xPath.lineTo(size.width * 0.3 * progress, size.height * 0.7 * progress);

    canvas.drawPath(circlePath, paint);
    canvas.drawPath(xPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}