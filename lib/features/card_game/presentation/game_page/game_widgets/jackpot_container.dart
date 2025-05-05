import 'package:flutter/material.dart';

class JackpotContainer extends StatelessWidget {
  const JackpotContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final containerWidth = screenWidth * 0.4;
    final containerHeight = containerWidth * 0.3;
    final coinSize = containerHeight * 0.5;
    final fontSize = containerHeight * 0.35;
    final jackpotImageHeight = screenHeight * 0.11;

    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          width: containerWidth,
          height: containerHeight,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFE0E0E0), Color(0xFFFFFFFF), Color(0xFFE0E0E0)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(51),
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
            border: Border(
              left: BorderSide(color: Color(0xFFD4AF37), width: 6),
              right: BorderSide(color: Color(0xFFD4AF37), width: 6),
              top: BorderSide(color: Color(0xFF4CAF50), width: 3),
              bottom: BorderSide(color: Color(0xFF4CAF50), width: 3),
            ),
          ),
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(color: Color(0xFFD4AF37), width: 2),
                    bottom: BorderSide(color: Color(0xFFD4AF37), width: 2),
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/dollar_coin.png',
                          height: coinSize,
                          width: coinSize,
                        ),
                        ShaderMask(
                          shaderCallback:
                              (bounds) => LinearGradient(
                                colors: [
                                  Color(0xFF9F6014),
                                  Color(0xFF693D02),
                                  Color(0xFF4D2D02),
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ).createShader(bounds),
                          child: Text(
                            '185164',
                            style: TextStyle(
                              fontSize: fontSize,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // Inner shadow effect
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withAlpha(102),
                        Colors.transparent,
                        Colors.black.withAlpha(102),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Image.asset(
          'assets/images/jackpot_text.png',
          height: jackpotImageHeight,
        ),
      ],
    );
  }
}
