import 'package:aceplus/features/card_game/presentation/bloc/card_bloc/card_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bottom_bet_container.dart';
import 'bottom_bet_toolbar.dart';

class BottomBetWidget extends StatelessWidget {
  const BottomBetWidget({super.key});
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        BlocBuilder<CardBloc, CardState>(
          builder: (context, state) {
            return AnimatedPositioned(
              duration: const Duration(milliseconds: 600),
              curve: Curves.easeInOut,
              bottom: state.bets.isNotEmpty ? 0 : -screenHeight * 0.23,
              child: BottomBetContainer(),
            );
          },
        ),

        BlocBuilder<CardBloc, CardState>(
          builder: (context, state) {
            return AnimatedPositioned(
              duration: const Duration(milliseconds: 600),
              curve: Curves.easeInOut,
              bottom: state.bets.isNotEmpty ? screenHeight * 0.23 - 2 : 0,
              child: BottomToolbarWidget(),
            );
          },
        ),
      ],
    );
  }
}
