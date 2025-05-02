import 'package:flutter/material.dart';

class TableWithCards extends StatefulWidget {
  const TableWithCards({super.key});

  @override
  State<TableWithCards> createState() => _TableWithCardsState();
}

class _TableWithCardsState extends State<TableWithCards> {
  final ValueNotifier<bool> _isDistributedNotifier = ValueNotifier<bool>(false);

  @override
  void dispose() {
    _isDistributedNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final tableHeight = screenHeight * 0.25;

    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset(
          'assets/images/table.png',
          width: screenWidth * 0.95,
          height: MediaQuery.of(context).size.height * 0.25,
          fit: BoxFit.fill,
        ),
        ValueListenableBuilder<bool>(
          valueListenable: _isDistributedNotifier,
          builder: (context, isDistributed, child) {
            final tableWidth = screenWidth * 0.95;
            final tableHeight = screenHeight * 0.25;

            final double cardSpacing = 10.0;
            final double cardWidth = 50.0;
            final double cardHeight = 66.0;
            final double totalWidth = (4 * cardWidth) + (3 * cardSpacing);
            final double startLeft = (tableWidth - totalWidth) / 2;

            final double tableTop = (screenHeight / 2) - (tableHeight / 2);
            final double tableLeft = (screenWidth - tableWidth) / 2;

            return Stack(
              children: [
                ...List.generate(4, (index) {
                  return AnimatedPositioned(
                    duration: const Duration(seconds: 1),
                    curve: Curves.easeInOut,
                    top:
                        isDistributed
                            ? tableTop +
                                (tableHeight / 2) -
                                (cardHeight / 2) + 3
                            : tableTop + 3,
                    left:
                        isDistributed
                            ? tableLeft +
                                startLeft +
                                (index * (cardWidth + cardSpacing))
                            : tableLeft,
                    child: Image.asset(
                      'assets/images/card_back.png',
                      width: cardWidth,
                      height: cardHeight,
                    ),
                  );
                }),
                Positioned(
                  top: tableTop,
                  left: tableLeft,
                  child: GestureDetector(
                    onTap: () {
                      _isDistributedNotifier.value =
                          !_isDistributedNotifier.value;
                    },
                    child: Image.asset(
                      'assets/images/stack_of_cards.png',
                      width: 50,
                      height: 75,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
        Positioned(
          top: (screenHeight / 2) - (tableHeight / 2),
          left: (screenWidth * 0.025),
          child: GestureDetector(
            onTap: () {
              _isDistributedNotifier.value = !_isDistributedNotifier.value;
            },
            child: Image.asset(
              'assets/images/stack_of_cards.png',
              width: 50,
              height: 75,
            ),
          ),
        ),
      ],
    );
  }
}
