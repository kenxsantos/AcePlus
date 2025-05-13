import 'dart:math';
import 'package:aceplus/features/card_game/presentation/game_page/widgets/cards_widget/odds_text_widget.dart';
import 'package:aceplus/shared/utils/card_enums.dart';
import 'package:flutter/material.dart';
import 'package:aceplus/shared/utils/constant.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CardWidget extends StatefulWidget {
  bool isFlipped;
  bool isExpanded;
  final int value;
  final int index;
  final double odds;

  CardWidget({
    super.key,
    required this.isFlipped,
    required this.isExpanded,
    required this.value,
    required this.index,
    required this.odds,
  });

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> with TickerProviderStateMixin {
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
      duration: Duration(milliseconds: 200 + widget.index * 200),
      vsync: this,
    );

    flipAnimation = Tween<double>(
      begin: 0,
      end: pi,
    ).animate(CurvedAnimation(parent: flipController, curve: Curves.easeOut));

    rotationAnimation = Tween<double>(
      begin: 0,
      end: 2 * pi,
    ).animate(CurvedAnimation(parent: expandController, curve: Curves.easeOut));

    positionAnimation = Tween<Offset>(
      begin:
          widget.isExpanded
              ? Offset((widget.index + 1) * 0.33, 0.33)
              : Offset.zero,
      end:
          widget.isExpanded
              ? Offset.zero
              : Offset((widget.index + 1) * 0.33, 0.33),
    ).animate(CurvedAnimation(parent: expandController, curve: Curves.easeOut));
  }

  @override
  void didUpdateWidget(CardWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.isExpanded != oldWidget.isExpanded) {
      widget.isExpanded
          ? expandController.forward(from: 0)
          : expandController.reverse();
    }

    if (widget.isFlipped != oldWidget.isFlipped) {
      widget.isFlipped
          ? flipController.forward(from: 0)
          : flipController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([flipController, expandController]),
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
                        getCardByValue(widget.value).cardPath,
                        width: 50,
                        height: 66,
                      )
                      : Stack(
                        alignment: Alignment.center, // Centers the text
                        children: [
                          Image.asset(
                            "${cardUrl}card_back.png",
                            width: 50,
                            height: 66,
                          ),
                          widget.isExpanded
                              ? OddsTextWidget(odds: widget.odds)
                              : SizedBox(),
                        ],
                      ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    flipController.dispose();
    expandController.dispose();
    super.dispose();
  }
}
