import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aceplus/features/card_game/presentation/game_page/widgets/timer_widget/bloc/timer_bloc.dart';
import 'card_1.dart';
import 'card_2.dart';
import 'card_3.dart';
import 'card_4.dart';

class AnimatedCards extends StatefulWidget {
  const AnimatedCards({super.key});

  @override
  _AnimatedCardsState createState() => _AnimatedCardsState();
}

class _AnimatedCardsState extends State<AnimatedCards>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> rotationAnimation1,
      rotationAnimation2,
      rotationAnimation3,
      rotationAnimation4;
  late Animation<Offset> positionAnimation1,
      positionAnimation2,
      positionAnimation3,
      positionAnimation4;

  bool _isExpanded = false; // 🚀 Tracks whether cards are spread out

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    rotationAnimation1 = _createRotationAnimation();
    rotationAnimation2 = _createRotationAnimation();
    rotationAnimation3 = _createRotationAnimation();
    rotationAnimation4 = _createRotationAnimation();

    _updateAnimations();
  }

  // 🔄 Rotation Animation
  Animation<double> _createRotationAnimation() {
    return Tween<double>(
      begin: 0,
      end: 2 * pi,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
  }

  // 🔀 Updates Animations Based on `_isExpanded`
  void _updateAnimations() {
    positionAnimation1 = _createPositionAnimation(1);
    positionAnimation2 = _createPositionAnimation(2);
    positionAnimation3 = _createPositionAnimation(3);
    positionAnimation4 = _createPositionAnimation(4);
  }

  // 📌 Moves each card further to the right OR resets
  Animation<Offset> _createPositionAnimation(int index) {
    return Tween<Offset>(
      begin: _isExpanded ? Offset(index * 0.33, 0) : Offset.zero,
      end: _isExpanded ? Offset.zero : Offset(index * 0.33, 0),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
  }

  // 🎬 Triggers animation when state changes
  void _animateCards() {
    setState(() {
      _isExpanded = !_isExpanded;
      _updateAnimations();
    });

    _controller.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TimerBloc, TimerState>(
      listener: (context, state) {
        if (state.status.isChooseCard) {
          _animateCards();
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.centerLeft,
            children: [
              Card1(
                controller: _controller,
                rotationAnimation: rotationAnimation1,
                positionAnimation: positionAnimation1,
              ),
              Card2(
                controller: _controller,
                rotationAnimation: rotationAnimation2,
                positionAnimation: positionAnimation2,
              ),
              Card3(
                controller: _controller,
                rotationAnimation: rotationAnimation3,
                positionAnimation: positionAnimation3,
              ),
              Card4(
                controller: _controller,
                rotationAnimation: rotationAnimation4,
                positionAnimation: positionAnimation4,
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
