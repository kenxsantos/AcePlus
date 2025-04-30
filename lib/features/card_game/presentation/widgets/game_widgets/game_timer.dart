import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GameTimerCircle extends StatelessWidget {
  final String text;

  const GameTimerCircle({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 100,
      child: Container(
        width: 300,
        height: 300,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.transparent,
          border: Border.all(
            color: const Color(0xFF7D1F22),
            width: 4, // Border width
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Text(
              text,
              style: GoogleFonts.lemon(
                textStyle: TextStyle(
                  fontSize: 60,
                  fontWeight: FontWeight.bold,
                  foreground: Paint()
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = 6
                    ..color = const Color(0xFF7D1F22),
                ),
              ),
            ),
            Text(
              text,
              style: GoogleFonts.lemon(
                textStyle: const TextStyle(
                  fontSize: 60,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFFD700),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}