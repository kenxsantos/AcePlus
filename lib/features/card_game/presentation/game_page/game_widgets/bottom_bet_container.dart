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
    return Container(
      width: MediaQuery.of(context).size.width * 0.95,
      height: MediaQuery.of(context).size.height * 0.23,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF383B5A), Color(0xFF212231)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
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
                        height: 62,
                        width: 62,
                      ),
                      Text(
                        text,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
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
