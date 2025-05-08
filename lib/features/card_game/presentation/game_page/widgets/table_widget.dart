import 'package:aceplus/features/card_game/presentation/game_page/widgets/cards_widget/animated_cards.dart';
import 'package:aceplus/shared/utils/constant.dart';
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

            final double tableTop = (screenHeight / 2) - (tableHeight / 2);
            final double tableLeft = (screenWidth - tableWidth) / 2;
            return Stack(
              children: [
                Positioned(
                  top: tableTop,
                  left: tableLeft,
                  child: SizedBox(
                    width: 50,
                    height: 75,
                    child: AnimatedCards(),
                  ),
                ),
                Positioned(
                  top: tableTop,
                  left: tableLeft,
                  child: SizedBox(
                    width: 50,
                    height: 75,
                    child: Image.asset("${cardUrl}stack_of_cards.png"),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
