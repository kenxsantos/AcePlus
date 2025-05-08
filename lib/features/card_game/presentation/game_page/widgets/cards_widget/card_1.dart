import 'dart:math';
import 'package:aceplus/features/card_game/presentation/game_page/widgets/cards_widget/bloc/card_bloc.dart';
import 'package:aceplus/shared/utils/card_enums.dart';
import 'package:aceplus/shared/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Card1 extends StatefulWidget {
  const Card1({
    super.key,
    // required this.isFlipped,
    required this.value,
    // required this.isExpanded,
    required this.controller,
    required this.flipController,
    required this.state,
  });

  final AnimationController controller;
  final AnimationController flipController;
  // final bool isFlipped;
  // final bool isExpanded;
  final int value;
  final CardState state;

  @override
  State<Card1> createState() => _Card1State();
}

class _Card1State extends State<Card1> {
  late Animation<double> _flipAnimation;

  late Animation<double> rotationAnimation;
  late Animation<Offset> positionAnimation;
  late bool isFlipped = false;
  late bool isExtended = false;

  @override
  void initState() {
    super.initState();

    _flipAnimation = Tween<double>(
      begin: 0,
      end: pi, // Flip halfway, then swap image
    ).animate(
      CurvedAnimation(parent: widget.flipController, curve: Curves.easeOut),
    );

    rotationAnimation = _createRotationAnimation();
    positionAnimation = _createPositionAnimation(1);

    if (isFlipped) {
      widget.flipController.forward(from: 0);
      print("isFlippedForward: $isFlipped");
    } else {
      widget.flipController.reverse();
    }
  }

  Animation<double> _createRotationAnimation() {
    return Tween<double>(begin: 0, end: 2 * pi).animate(
      CurvedAnimation(parent: widget.controller, curve: Curves.easeOut),
    );
  }

  Animation<Offset> _createPositionAnimation(int index) {
    return Tween<Offset>(
      begin: isExtended ? Offset(index * 0.33, 033) : Offset.zero,
      end: isExtended ? Offset.zero : Offset(index * 0.33, 0.33),
    ).animate(
      CurvedAnimation(parent: widget.controller, curve: Curves.easeOut),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.state is CardIsFlipped) {
      isFlipped = (widget.state as CardIsFlipped).isFlipped;
    } else if (widget.state is CardIsExtended) {
      isExtended = (widget.state as CardIsExtended).isExtended;
    }

    if (widget.state is CardGenerated) {
      return AnimatedBuilder(
        animation: isFlipped ? widget.flipController : widget.controller,
        builder: (context, child) {
          final isHalfway = _flipAnimation.value > pi / 2;
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
                      ..rotateY(_flipAnimation.value),
                child:
                    isHalfway
                        ? Image.asset(
                          Cards.values
                              .firstWhere(
                                (card) =>
                                    card.value ==
                                    (widget.state as CardGenerated).numbers[0],
                              )
                              .cardPath,
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
      );
    }

    return const SizedBox.shrink();
  }
}
