import 'package:flutter/material.dart';

class CheckCircleAnimation extends StatefulWidget {
  const CheckCircleAnimation({super.key});

  @override
  State<CheckCircleAnimation> createState() => _CheckCircleAnimationState();
}

class _CheckCircleAnimationState extends State<CheckCircleAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
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
    return AnimatedBuilder(animation: _animation, builder: (context, child) {
      return CustomPaint(
        painter: CheckCirclePainter(_animation.value),
        size: const Size(50, 50),
      );
    });
  }
}

class CheckCirclePainter extends CustomPainter {
  final double progress;

  CheckCirclePainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5.0
      ..strokeCap = StrokeCap.round;

    final Path circlePath = Path()
      ..addArc(Rect.fromCircle(center: Offset(size.width / 2, size.height / 2),
          radius: size.width / 2), 0, 2 * 3.1416 * progress);

    final Path checkPath = Path();
    checkPath.moveTo(size.width * 0.3, size.height * 0.5);
    checkPath.lineTo(size.width * 0.45, size.height * progress * 0.7);
    checkPath.lineTo(size.width * 0.75, size.height * 0.3 * progress);

    canvas.drawPath(circlePath, paint);
    canvas.drawPath(checkPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
