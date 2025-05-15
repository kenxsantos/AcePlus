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
        if (state is CardGenerated) {
          cardNumbers = state.numbers;
          cardOdds = state.odds;
        }
      },

      builder: (context, state) {
        bool isFlipped = false;
        bool isExpanded = false;
        int? tappedIndex;

        if (state is CardIsAnimated) {
          isExpanded = state.isExtended;
          isFlipped = state.isFlipped;
        }
        if (state is CardIsTapped) {
          tappedIndex = state.index;
          print("State USer TAPP: ${state.index}");
        }

        return Stack(
          children: List.generate(
            cardNumbers.length,
            (index) => CardWidget(
              value: cardNumbers[index],
              odds: cardOdds[index],
              isFlipped: isFlipped,
              isExpanded: isExpanded,

              index: index,
            ),
          ),
        );
      },
    );
  }
}
