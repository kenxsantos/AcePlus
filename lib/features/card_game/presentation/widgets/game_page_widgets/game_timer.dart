import 'package:aceplus/features/card_game/presentation/bloc/card_bloc/card_bloc.dart';
import 'package:aceplus/features/card_game/presentation/bloc/timer_bloc/timer_bloc.dart';
import 'package:aceplus/shared/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class GameTimerCircle extends StatelessWidget {
  const GameTimerCircle({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final circleSize = screenWidth * 0.18;
    final borderWidth = circleSize * 0.07;
    final fontSize = circleSize * 0.5;
    return BlocConsumer<TimerBloc, TimerState>(
      listener: (context, state) {
        if (state.status.isCompleted) {
          context.read<CardBloc>().add(CardRandomize());
          context.read<CardBloc>().add(
            CardToggelAnimate(isFlipped: false, isExtended: true),
          );
          context.read<TimerBloc>().add(TimerStarted(duration: 10));
        }
        if (state.status.isShowCards) {
          context.read<CardBloc>().add(
            CardToggelAnimate(isFlipped: true, isExtended: true),
          );
          context.read<TimerBloc>().add(ShowCards(duration: 3));
        }
        if (state.status.isCloseCards) {
          context.read<TimerBloc>().add(TimerStarting(duration: 3));
          context.read<CardBloc>().add(
            CardToggelAnimate(isFlipped: false, isExtended: false),
          );
          context.read<CardBloc>().add(ResetSelectedCards());
        }

        print("State Updated: ${state.status}");
      },

      builder: (context, state) {
        return Column(
          children: [
            Text(
              state.text,
              style: GoogleFonts.lemon(
                textStyle: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: primaryYellow,
                ),
              ),
            ),
            SizedBox(
              width: circleSize,
              height: circleSize,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.transparent,
                  border: Border.all(
                    color: const Color(0xFF7D1F22),
                    width: borderWidth,
                  ),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Text(
                      state.duration.toString(),
                      style: GoogleFonts.lemon(
                        textStyle: TextStyle(
                          fontSize: fontSize,
                          fontWeight: FontWeight.bold,
                          foreground:
                              Paint()
                                ..style = PaintingStyle.stroke
                                ..strokeWidth = borderWidth
                                ..color = const Color(0xFF7D1F22),
                        ),
                      ),
                    ),
                    Text(
                      state.duration.toString(),
                      style: GoogleFonts.lemon(
                        textStyle: TextStyle(
                          fontSize: fontSize,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFFFFD700),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
