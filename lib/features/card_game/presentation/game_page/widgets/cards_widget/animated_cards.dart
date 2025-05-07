import 'dart:math';
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
  _AnimatedCardsState createState() => _AnimatedCardsState();
}

class _AnimatedCardsState extends State<AnimatedCards>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  late AnimationController _flipController;
  late Animation<double> _flipAnimation;

  late Animation<double> rotationAnimation1,
      rotationAnimation2,
      rotationAnimation3,
      rotationAnimation4;
  late Animation<Offset> positionAnimation1,
      positionAnimation2,
      positionAnimation3,
      positionAnimation4;

  bool _isExpanded = false;
  bool _isFlipped = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _flipController = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );

    _flipAnimation = Tween<double>(
      begin: 0,
      end: pi, // Flip halfway, then swap image
    ).animate(CurvedAnimation(parent: _flipController, curve: Curves.easeOut));

    rotationAnimation1 = _createRotationAnimation();
    rotationAnimation2 = _createRotationAnimation();
    rotationAnimation3 = _createRotationAnimation();
    rotationAnimation4 = _createRotationAnimation();
    _updateAnimations();
  }

  Animation<double> _createRotationAnimation() {
    return Tween<double>(
      begin: 0,
      end: 2 * pi,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
  }

  Animation<Offset> _createPositionAnimation(int index) {
    return Tween<Offset>(
      begin: _isExpanded ? Offset(index * 0.33, 033) : Offset.zero,
      end: _isExpanded ? Offset.zero : Offset(index * 0.33, 0.33),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
  }

  void _updateAnimations() {
    positionAnimation1 = _createPositionAnimation(1);
    positionAnimation2 = _createPositionAnimation(2);
    positionAnimation3 = _createPositionAnimation(3);
    positionAnimation4 = _createPositionAnimation(4);
  }

  void _animateCards() {
    setState(() {
      _updateAnimations();
    });
    _controller.forward(from: 0);
  }

  void _flipCards() {
    setState(() {
      _isFlipped = !_isFlipped;
    });

    if (_isFlipped) {
      _flipController.forward(from: 0);
    } else {
      _flipController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TimerBloc, TimerState>(
      listener: (context, state) {
        if (state.status.isCompleted) {
          _animateCards();
          setState(() {
            _isExpanded = true;
          });
        }
        if (state.status.isShowCards) {
          _flipCards();
        }
        if (state.status.isCloseCards) {
          _flipCards();
          _flipController.reverse();
          _controller.reverse();
          setState(() {
            _isExpanded = false;
            _isFlipped = false;
          });
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.centerLeft,
            children: [
              Card1(
                flipController: _flipController,
                flipAnimation: _flipAnimation,
                isFlipped: _isFlipped,
                controller: _controller,
                rotationAnimation: rotationAnimation1,
                positionAnimation: positionAnimation1,
              ),
              Card2(
                flipAnimation: _flipAnimation,
                controller: _controller,
                rotationAnimation: rotationAnimation2,
                positionAnimation: positionAnimation2,
                isFlipped: _isFlipped,
              ),
              Card3(
                flipAnimation: _flipAnimation,
                controller: _controller,
                rotationAnimation: rotationAnimation3,
                positionAnimation: positionAnimation3,
                isFlipped: _isFlipped,
              ),
              Card4(
                flipAnimation: _flipAnimation,
                controller: _controller,
                rotationAnimation: rotationAnimation4,
                positionAnimation: positionAnimation4,
                isFlipped: _isFlipped,
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
    _flipController.dispose();
    super.dispose();
  }
}
