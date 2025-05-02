import 'package:flutter/material.dart';
import '../game_widgets/bottom_bet_toolbar.dart';
import '../game_widgets/game_timer.dart';
import '../game_widgets/table_widget.dart';
import '../game_widgets/top_toolbar.dart';

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
                    padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.2),
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
