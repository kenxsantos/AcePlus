import 'package:flutter/material.dart';
import '../widgets/game_widgets/bottom_bet_toolbar.dart';
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
              alignment: Alignment.center,
              children: [
                const TableWithCards(),
                const BottomBetWidget()
              ],
            ),
          ),
        ),
      ],
    );
  }
}
