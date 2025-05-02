import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BottomToolbarWidget extends StatelessWidget {
  final VoidCallback onTap;

  const BottomToolbarWidget({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: onTap,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            'assets/images/bottom_placing_bet.png',
            width: screenWidth,
            height: screenHeight * 0.08,
            fit: BoxFit.fill,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
            child: SizedBox(
              width: screenWidth * 0.9,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Stack(
                    children: [
                      Text(
                        'Place your bets !',
                        style: GoogleFonts.lemon(
                          textStyle: TextStyle(
                            fontSize: screenHeight * 0.018,
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
                          textStyle: TextStyle(
                            fontSize: screenHeight * 0.018,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFFFFD700),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: screenHeight * 0.04,
                    child: ElevatedButton(
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
                          textStyle: TextStyle(
                            fontSize: screenHeight * 0.015,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
