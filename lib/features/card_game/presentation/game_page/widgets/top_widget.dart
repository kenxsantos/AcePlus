import 'package:aceplus/features/card_game/presentation/game_page/widgets/jackpot_container.dart';
import 'package:aceplus/features/card_game/presentation/game_page/widgets/top_toolbar.dart';
import 'package:flutter/material.dart';

class TopBetWidget extends StatelessWidget {
  const TopBetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    final jackpotOffset = screenHeight * 0.08;

    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        TopToolbarWidget(),
        Positioned(
          bottom: -jackpotOffset,
          child: SizedBox(width: screenWidth * 0.8, child: JackpotContainer()),
        ),
      ],
    );
  }
}
