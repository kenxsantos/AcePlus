import 'package:aceplus/features/card_game/presentation/bloc/card_bloc/card_bloc.dart';
import 'package:aceplus/features/card_game/presentation/widgets/game_page_widgets/card_widget.dart';
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
        }
      },

      builder: (context, state) {
        bool isFlipped = false;
        bool isExpanded = false;

        if (state.status.isAnimateCard) {
          isExpanded = state.isExtended;
          isFlipped = state.isFlipped;
        }
        if (state.status.isCardTap) {
          isExpanded = state.isExtended;
        }
        if (state.status.isPlaceBet) {
          isExpanded = state.isExtended;
          print("Bet ${state.lastSelectedCardIndex}");
          print("Bet ${state.bets}");
        }

        return Stack(
          children: List.generate(
            cardNumbers.length,
            (index) => CardWidget(
              value: cardNumbers[index],
              odds: cardOdds[index],
              isFlipped: isFlipped,
              isExpanded: isExpanded,
              isTapped: state.bets.containsKey(index),
              betAmount: state.bets[index],
              totalAmount: state.totalAmount[index],
              index: index,
            ),
          ),
        );
      },
    );
  }
}
