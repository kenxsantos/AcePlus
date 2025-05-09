import 'dart:math';

import 'package:aceplus/features/card_game/presentation/game_page/widgets/cards_widget/bloc/card_bloc.dart';
import 'package:aceplus/features/card_game/presentation/game_page/widgets/cards_widget/card_1.dart';
import 'package:aceplus/features/card_game/presentation/game_page/widgets/cards_widget/card_2.dart';
import 'package:aceplus/features/card_game/presentation/game_page/widgets/cards_widget/card_3.dart';
import 'package:aceplus/features/card_game/presentation/game_page/widgets/cards_widget/card_4.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aceplus/features/card_game/presentation/game_page/widgets/timer_widget/bloc/timer_bloc.dart';

class AnimatedCards extends StatefulWidget {
  const AnimatedCards({super.key});

  @override
  State<AnimatedCards> createState() => _AnimatedCardsState();
}

class _AnimatedCardsState extends State<AnimatedCards>
    with TickerProviderStateMixin {
  List<int> cardNumbers = [0, 0, 0, 0];
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CardBloc, CardState>(
      listenWhen: (previous, current) => current is CardIsAnimated,
      listener: (context, state) {
        if (state is CardIsAnimated) {
          print(
            "Listener: Expanded - ${state.isExtended}, Flipped - ${state.isFlipped}",
          );
        }
      },
      buildWhen: (previous, current) => current is CardIsAnimated,
      builder: (context, state) {
        bool isFlipped = false;
        bool isExpanded = false;
        List<int> cardNumbers = [0, 0, 0, 0];

        if (state is CardIsAnimated) {
          isExpanded = state.isExtended;
          isFlipped = state.isFlipped;
          print("Builder: Expanded - $isExpanded, Flipped - $isFlipped");
        }
        if (state is CardGenerated) {
          cardNumbers = state.numbers;
          print("Received CardGenerated state with numbers: $cardNumbers");
        }

        return Column(
          children: [
            Stack(
              children: [
                Card1(
                  value: cardNumbers[0],
                  isFlipped: isFlipped,
                  isExpanded: isExpanded,
                ),
                Card2(
                  value: cardNumbers[1],
                  isFlipped: isFlipped,
                  isExpanded: isExpanded,
                ),
                Card3(
                  value: cardNumbers[2],
                  isFlipped: isFlipped,
                  isExpanded: isExpanded,
                ),
                Card4(
                  value: cardNumbers[3],
                  isFlipped: isFlipped,
                  isExpanded: isExpanded,
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
