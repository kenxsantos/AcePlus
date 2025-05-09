import 'dart:math';
import 'package:aceplus/features/card_game/presentation/game_page/widgets/cards_widget/bloc/card_bloc.dart';
import 'package:aceplus/features/card_game/presentation/game_page/widgets/timer_widget/bloc/timer_bloc.dart';
import 'package:flutter/material.dart';
import 'package:aceplus/shared/utils/card_enums.dart';
import 'package:aceplus/shared/utils/constant.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Card3 extends StatefulWidget {
  bool isFlipped;
  bool isExpanded;
  final int value;

  Card3({
    super.key,
    required this.isFlipped,
    required this.isExpanded,
    required this.value,
  });

  @override
  State<Card3> createState() => _Card3State();
}

class _Card3State extends State<Card3> with TickerProviderStateMixin {
  late AnimationController flipController;
  late AnimationController expandController;
  late Animation<double> flipAnimation;
  late Animation<double> rotationAnimation;
  late Animation<Offset> positionAnimation;

  @override
  void initState() {
    super.initState();

    flipController = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );

    expandController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    flipAnimation = Tween<double>(
      begin: 0,
      end: pi,
    ).animate(CurvedAnimation(parent: flipController, curve: Curves.easeOut));

    rotationAnimation = _createRotationAnimation();
    _updateAnimations();
  }

  @override
  void didUpdateWidget(Card3 oldWidget) {
    super.didUpdateWidget(oldWidget);

    print(
      "Card3 Updated! Old Expanded: ${oldWidget.isExpanded}, New: ${widget.isExpanded}",
    );
    print(
      "Card3 Updated! Old Flipped: ${oldWidget.isFlipped}, New: ${widget.isFlipped}",
    );

    if (widget.isExpanded != oldWidget.isExpanded) {
      print("Expand Animation Triggered: ${widget.isExpanded}");
      widget.isExpanded
          ? expandController.forward(from: 0)
          : expandController.reverse();
    }

    if (widget.isFlipped != oldWidget.isFlipped) {
      print("Flip Animation Triggered: ${widget.isFlipped}");
      widget.isFlipped
          ? flipController.forward(from: 0)
          : flipController.reverse();
    }
  }

  Animation<double> _createRotationAnimation() {
    return Tween<double>(
      begin: 0,
      end: 2 * pi,
    ).animate(CurvedAnimation(parent: expandController, curve: Curves.easeOut));
  }

  Animation<Offset> _createPositionAnimation(int index) {
    return Tween<Offset>(
      begin: widget.isExpanded ? Offset(index * 0.33, 033) : Offset.zero,
      end: widget.isExpanded ? Offset.zero : Offset(index * 0.33, 0.33),
    ).animate(CurvedAnimation(parent: expandController, curve: Curves.easeOut));
  }

  void _updateAnimations() {
    positionAnimation = _createPositionAnimation(3);
  }

  void _animateCards() {
    if (widget.isExpanded) {
      expandController.forward(from: 0);
    } else {
      expandController.reverse();
    }
  }

  void _flipCards() {
    if (widget.isFlipped) {
      flipController.forward(from: 0);
    } else {
      flipController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TimerBloc, TimerState>(
      listener: (context, state) {
        if (state.status.isCompleted) {
          _animateCards();
        }
        if (state.status.isShowCards) {
          _flipCards();
        }
        if (state.status.isCloseCards) {
          _flipCards();
          flipController.reverse();
          expandController.reverse();
        }
      },

      child: AnimatedBuilder(
        animation: widget.isFlipped ? flipController : expandController,
        builder: (context, child) {
          final isHalfway = flipAnimation.value > pi / 2;
          return Transform.translate(
            offset:
                positionAnimation.value * MediaQuery.of(context).size.width / 2,
            child: Transform.rotate(
              angle: rotationAnimation.value,
              child: Transform(
                alignment: Alignment.center,
                transform:
                    Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..rotateY(flipAnimation.value),
                child:
                    isHalfway
                        ? Image.asset(
                          "${cardUrl}ace.png",
                          width: 50,
                          height: 66,
                        )
                        : Image.asset(
                          "${cardUrl}card_back.png",
                          width: 50,
                          height: 66,
                        ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    flipController.dispose();
    expandController.dispose();
    super.dispose();
  }
}
