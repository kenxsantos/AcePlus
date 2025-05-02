import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BottomBetWidget extends StatelessWidget {
  const BottomBetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset(
          'assets/images/bottom_placing_bet.png',
          width: MediaQuery.of(context).size.width * 1,
          height: 75,
          fit: BoxFit.fill,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Stack(
                children: [
                  Text(
                    'Place your bets !',
                    style: GoogleFonts.lemon(
                      textStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        foreground:
                            Paint()
                              ..style = PaintingStyle.stroke
                              ..strokeWidth = 1.5
                              ..color = const Color(0xFF7D1F22),
                      ),
                    ),
                  ),
                  Text(
                    'Place your bets !',
                    style: GoogleFonts.lemon(
                      textStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFFFD700),
                      ),
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  // Add cancel button functionality here
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFD700),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                    side: const BorderSide(
                      color: Color(0xFF7D1F22),
                      width: 1.5,
                    ),
                  ),
                ),
                child: Text(
                  'Cancel',
                  style: GoogleFonts.lemon(
                    textStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
