import 'package:flutter/material.dart';

class BottomBetContainer extends StatelessWidget {
  BottomBetContainer({super.key});

  final List<String> texts = [
    "1",
    "5",
    "10",
    "50",
    "100",
    "500",
    "1k",
    "5k",
    "10k",
  ];

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    final double chipSize = screenWidth * 0.15;
    final double fontSize = screenHeight * 0.02;

    return Container(
      width: screenWidth * 0.95,
      height: screenHeight * 0.23,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF272D69), Color(0xFF201C48), Color(0xFF272D69)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(104),
            spreadRadius: 6,
            blurRadius: 20,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Wrap(
            spacing: 10.0,
            runSpacing: 10.0,
            alignment: WrapAlignment.center,
            children:
                texts.map((text) {
                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset(
                        'assets/images/chip.png',
                        height: chipSize,
                        width: chipSize,
                      ),
                      Text(
                        text,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: fontSize,
                        ),
                      ),
                    ],
                  );
                }).toList(),
          ),
        ),
      ),
    );
  }
}
