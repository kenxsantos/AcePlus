import 'package:aceplus/shared/utils/constant.dart';
import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const CardGame());
}

class CardGame extends StatelessWidget {
  const CardGame({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: CardGameScreen());
  }
}

class CardGameScreen extends StatefulWidget {
  @override
  _CardGameScreenState createState() => _CardGameScreenState();
}

class _CardGameScreenState extends State<CardGameScreen>
    with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  late List<Animation<Offset>> _positionAnimations;
  late List<Animation<double>> _rotationAnimations;
  bool _cardsVisible = false;

  final List<Offset> centerPositions = [
    Offset(0, 0), // Leftmost card
    Offset(20, 0), // Left-center card
    Offset(40, 0), // Right-center card
    Offset(60, 0), // Rightmost card
  ];

  @override
  void initState() {
    super.initState();

    // Create controllers for each card
    _controllers = List.generate(
      4,
      (i) => AnimationController(
        duration: const Duration(milliseconds: 400),
        vsync: this,
      ),
    );

    // Define movement animations (top center to center)
    _positionAnimations = List.generate(
      4,
      (i) => Tween<Offset>(
        begin: Offset(0, -200), // Start from the stack at the top
        end: centerPositions[i], // Move to its center position
      ).animate(
        CurvedAnimation(parent: _controllers[i], curve: Curves.easeOut),
      ),
    );

    // Define rotation animations (spinning effect)
    _rotationAnimations = List.generate(
      4,
      (i) => Tween<double>(begin: 0, end: 2 * pi).animate(
        CurvedAnimation(parent: _controllers[i], curve: Curves.easeOut),
      ),
    );
  }

  void _revealCards() async {
    setState(() {
      _cardsVisible = true;
    });

    // Animate each card with a staggered delay
    for (int i = 0; i < 4; i++) {
      await Future.delayed(const Duration(milliseconds: 400));
      _controllers[i].forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Staggered Card Placement')),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          // Stack of cards at the top center
          GestureDetector(onTap: _revealCards, child: const DeckWidget()),
          // Display cards only when revealed
          if (_cardsVisible)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                4,
                (i) => AnimatedBuilder(
                  animation: _controllers[i],
                  builder: (context, child) {
                    return Transform.translate(
                      offset: _positionAnimations[i].value,
                      child: Transform.rotate(
                        angle: _rotationAnimations[i].value,
                        child: child,
                      ),
                    );
                  },
                  child: CardWidget(index: i),
                ),
              ),
            ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }
}

class DeckWidget extends StatelessWidget {
  const DeckWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 150,
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(child: Image.asset("${cardUrl}stack_of_cards.png")),
    );
  }
}

class CardWidget extends StatelessWidget {
  final int index;
  const CardWidget({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Center(child: Image.asset("${cardUrl}card_back.png"));
  }
}
