import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GameTimerCircle extends StatelessWidget {
  final String text;

  const GameTimerCircle({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final circleSize = screenWidth * 0.18;
    final borderWidth = circleSize * 0.07;
    final fontSize = circleSize * 0.5;

    return SizedBox(
      width: circleSize,
      height: circleSize,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.transparent,
          border: Border.all(
            color: const Color(0xFF7D1F22),
            width: borderWidth,
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Text(
              text,
              style: GoogleFonts.lemon(
                textStyle: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                  foreground:
                      Paint()
                        ..style = PaintingStyle.stroke
                        ..strokeWidth = borderWidth
                        ..color = const Color(0xFF7D1F22),
                ),
              ),
            ),
            Text(
              text,
              style: GoogleFonts.lemon(
                textStyle: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFFFFD700),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
