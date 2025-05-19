import 'package:aceplus/features/card_game/presentation/game_page/widgets/cards_widget/bloc/card_bloc.dart';
import 'package:aceplus/features/card_game/presentation/game_page/widgets/cards_widget/card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AnimatedCards extends StatefulWidget {
  const AnimatedCards({super.key});

  @override
  State<AnimatedCards> createState() => _AnimatedCardsState();
}

class _AnimatedCardsState extends State<AnimatedCards>
    with TickerProviderStateMixin {
  List<int> cardNumbers = [0, 0, 0, 0];
  List<double> cardOdds = [0, 0, 0, 0];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CardBloc, CardState>(
      listener: (context, state) {
        if (state.status.isCardGenerated) {
          cardNumbers = state.numbers;
          cardOdds = state.odds;
          print("State Animate card numbers: $cardNumbers");
          print("State Animate card odds: $cardOdds");
        }
      },

      builder: (context, state) {
        bool isFlipped = false;
        bool isExpanded = false;

        if (state.status.isAnimateCard) {
          isExpanded = state.isExtended;
          isFlipped = state.isFlipped;
          print("State Animate isExpanded: ${state.isExtended}");
          print("State Animate isFlipped: ${state.isFlipped}");
        }
        if (state.status.isCardTap) {
          // tappedIndex = state.index;
          isExpanded = state.isExtended;

          print("State Animate isTapped: ${state.isTapped}");
        }

        return Stack(
          children: List.generate(
            cardNumbers.length,
            (index) => CardWidget(
              value: cardNumbers[index],
              odds: cardOdds[index],
              isFlipped: isFlipped,
              isExpanded: isExpanded,
              isTapped: state.tappedIndices.contains(index),
              index: index,
            ),
          ),
        );
      },
    );
  }
}
