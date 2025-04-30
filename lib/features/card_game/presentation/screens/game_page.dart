import 'package:aceplus/features/card_game/presentation/widgets/game_widgets/top_toolbar.dart';
import 'package:flutter/material.dart';
import '../widgets/game_widgets/bottom_bet_toolbar.dart';
import '../widgets/game_widgets/game_timer.dart';
import '../widgets/game_widgets/table_widget.dart';

class GamePage extends StatelessWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Positioned.fill(
          child: Image(
            image: AssetImage('assets/images/mainpage_landscape.png'),
            fit: BoxFit.cover,
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: const TopToolbarWidget(),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 175),
                    child: const GameTimerCircle(text: '10'),
                  ),
                ),
                const Center(
                  child: TableWithCards(),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: const BottomBetWidget(),
                ),
              ],
            )
          ),
        ),
      ],
    );
  }
}
