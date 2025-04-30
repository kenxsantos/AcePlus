import 'package:flutter/material.dart';

class TableWithCards extends StatefulWidget {
  const TableWithCards({super.key});

  @override
  State<TableWithCards> createState() => _TableWithCardsState();
}

class _TableWithCardsState extends State<TableWithCards> {
  bool _isDistributed = false;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final double stackTop = (screenHeight / 2) - 135;
    final double stackLeft = (screenWidth / 2) - 175;

    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset(
          'assets/images/table.png',
          width: screenWidth * 0.95,
          height: 275,
          fit: BoxFit.fill,
        ),
        Stack(
          children: List.generate(4, (index) {
            final double cardSpacing = 10.0;
            final double totalWidth = (4 * 60) + (3 * cardSpacing);
            final double startLeft = (screenWidth - totalWidth) / 2;

            return AnimatedPositioned(
              duration: const Duration(seconds: 1),
              curve: Curves.easeInOut,
              top: _isDistributed ? (screenHeight / 2) - 42.5 : stackTop,
              left:
                  _isDistributed
                      ? startLeft + (index * (60 + cardSpacing))
                      : stackLeft,
              child: Image.asset(
                'assets/images/card_back.png',
                width: 60,
                height: 85,
              ),
            );
          }),
        ),
        Positioned(
          top: stackTop,
          left: stackLeft,
          child: GestureDetector(
            onTap: () {
              setState(() {
                _isDistributed = !_isDistributed;
              });
            },
            child: Image.asset(
              'assets/images/stack_of_cards.png',
              width: 60,
              height: 85,
            ),
          ),
        ),
      ],
    );
  }
}
