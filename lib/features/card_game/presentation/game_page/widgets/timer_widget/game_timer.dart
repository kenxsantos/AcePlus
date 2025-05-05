import 'package:aceplus/features/card_game/presentation/game_page/widgets/timer_widget/bloc/timer_bloc.dart';
import 'package:aceplus/shared/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class GameTimerCircle extends StatelessWidget {
  final String text;

  const GameTimerCircle({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final circleSize = screenWidth * 0.18;
    final borderWidth = circleSize * 0.07;
    final fontSize = circleSize * 0.5;
    return BlocListener<TimerBloc, TimerState>(
      listener: (context, state) async {
        if (state.status.isCompleted) {
          await Future.delayed(Duration(seconds: 1), () {
            context.read<TimerBloc>().add(TimerStarted(duration: 10));
          });
        }
        if (state.status.isShowed) {
          await Future.delayed(Duration(seconds: 1), () {
            context.read<TimerBloc>().add(ShowCards(duration: 5));
          });
        }

        print("State: ${state.status}");
      },
      child: BlocBuilder<TimerBloc, TimerState>(
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
      ),
    );
  }
}
