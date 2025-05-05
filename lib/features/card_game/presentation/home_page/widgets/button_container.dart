import 'package:aceplus/features/card_game/presentation/game_page/widgets/timer_widget/bloc/timer_bloc.dart';
import 'package:aceplus/shared/utils/strings.dart';
import 'package:aceplus/shared/widgets/gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ButtonContainer extends StatelessWidget {
  const ButtonContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 50),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GradientButton(
            labelText: Str().playNow,
            onPressed:
                () => {
                  context.go('/game'),
                  context.read<TimerBloc>().add(TimerStarting(duration: 5)),
                },
          ),
          GradientButton(
            labelText: Str().wallet,
            onPressed: () => context.goNamed("wallet"),
          ),
        ],
      ),
    );
  }
}
