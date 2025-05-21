import 'dart:math';
import 'package:aceplus/features/card_game/presentation/bloc/card_bloc/card_bloc.dart';
import 'package:aceplus/features/card_game/presentation/widgets/game_page_widgets/odds_text_widget.dart';
import 'package:aceplus/shared/utils/card_enums.dart';
import 'package:flutter/material.dart';
import 'package:aceplus/shared/utils/constant.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CardWidget extends StatefulWidget {
  bool isFlipped;
  bool isExpanded;
  bool isTapped;
  final int value;
  final int index;
  final double odds;
  final double? betAmount;
  final double? totalAmount;
  CardWidget({
    super.key,
    required this.isFlipped,
    required this.isExpanded,
    required this.isTapped,
    required this.value,
    required this.index,
    required this.odds,
    required this.betAmount,
    required this.totalAmount,
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
          transformHitTests: true,
          child: Transform.rotate(
            angle: rotationAnimation.value,
            transformHitTests: true,
            child: Transform(
              transformHitTests: true,
              alignment: Alignment.center,
              transform:
                  Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..rotateY(flipAnimation.value),
              child: GestureDetector(
                onTap:
                    () => {
                      print("Card ${widget.index}"),
                      if (widget.isExpanded && !widget.isFlipped)
                        {
                          context.read<CardBloc>().add(
                            PlaceBet(index: widget.index),
                          ),
                          print("State Animate Index: ${widget.index}"),
                        },
                    },
                child:
                    isHalfway
                        ? AnimatedContainer(
                          duration: Duration(milliseconds: 200),
                          width: widget.isTapped ? 60 : 50,
                          height: widget.isTapped ? 85 : 75,
                          child: Image.asset(
                            getCardByValue(widget.value).cardPath,
                            fit: BoxFit.contain,
                          ),
                        )
                        : AnimatedContainer(
                          duration: Duration(milliseconds: 200),
                          width: widget.isTapped ? 60 : 50,
                          height: widget.isTapped ? 85 : 75,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Image.asset(
                                "${cardUrl}card_back.png",
                                width: double.infinity,
                                height: double.infinity,
                                fit: BoxFit.contain,
                              ),
                              if (widget.isExpanded)
                                OddsTextWidget(odds: widget.odds),
                              if (widget.isTapped && widget.betAmount != null)
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(widget.totalAmount != null ? "${widget.totalAmount}" : '0'),
                                    Positioned(
                                      bottom: 8,
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 6,
                                          vertical: 2,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.7),
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                        ),
                                        child: Text(
                                          widget.betAmount?.toStringAsFixed(
                                                0,
                                              ) ??
                                              '0',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        ),
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
