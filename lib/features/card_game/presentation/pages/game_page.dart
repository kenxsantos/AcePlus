import 'package:aceplus/features/card_game/presentation/widgets/game_page_widgets/top_widget.dart';
import 'package:flutter/material.dart';
import '../widgets/game_page_widgets/bottom_widget.dart';
import '../widgets/game_page_widgets/game_timer.dart';
import '../widgets/game_page_widgets/table_widget.dart';

class GamePage extends StatelessWidget {
  const GamePage({super.key, required String id});

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
                  child: const TopBetWidget(),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.2,
                    ),
                    child: const GameTimerCircle(),
                  ),
                ),
                const Center(child: TableWithCards()),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: BottomBetWidget(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
