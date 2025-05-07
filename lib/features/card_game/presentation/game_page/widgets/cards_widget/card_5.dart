// import 'dart:math';
// import 'package:flutter/material.dart';

// class Card5 extends StatefulWidget {
//   const Card5({
//     super.key,
//     required this.isExpanded,
//     required this.isFlipped,
//     required this.flipController,
//     required this.flipAnimation,
//   });

//   final bool isExpanded;
//   final bool isFlipped;
//   final AnimationController flipController;
//   final Animation<double> flipAnimation;
//   @override
//   State<Card5> createState() => _Card5State();
// }

// class _Card5State extends State<Card5> with TickerProviderStateMixin {
//   late AnimationController _controller;

//   late Animation<double> rotationAnimation;
//   late Animation<Offset> positionAnimation;

//   @override
//   void initState() {
//     super.initState();

//     _controller = AnimationController(
//       duration: const Duration(milliseconds: 500),
//       vsync: this,
//     );

//     rotationAnimation = _createRotationAnimation();
//     positionAnimation = _createPositionAnimation(1);

//     // _controller.forward();
//     _updateAnimations();
//     Future.delayed(Duration(milliseconds: 500 * 1), () {
//       _controller.forward();
//     });
//   }

//   Animation<double> _createRotationAnimation() {
//     return Tween<double>(
//       begin: 0,
//       end: 2 * pi,
//     ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
//   }

//   Animation<Offset> _createPositionAnimation(int index) {
//     return Tween<Offset>(
//       begin: widget.isExpanded ? Offset(index * 0.33, 0.33) : Offset.zero,
//       end: widget.isExpanded ? Offset.zero : Offset(index * 0.33, 0.33),
//     ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
//   }

//   void _updateAnimations() {
//     positionAnimation = _createPositionAnimation(1);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(
//       animation: widget.isFlipped ? widget.flipAnimation : _controller,
//       builder: (context, child) {
//         final isHalfway = widget.flipAnimation.value > pi / 2;
//         return Transform.translate(
//           offset:
//               positionAnimation.value * MediaQuery.of(context).size.width / 2,
//           child: Transform.rotate(
//             angle: rotationAnimation.value,
//             child: Transform(
//               alignment: Alignment.center,
//               transform:
//                   Matrix4.identity()
//                     ..setEntry(3, 2, 0.001)
//                     ..rotateY(widget.flipAnimation.value),
//               child:
//                   isHalfway
//                       ? Image.asset(
//                         "assets/images/joker.png",
//                         width: 50,
//                         height: 66,
//                       )
//                       : Image.asset(
//                         "assets/images/card_back.png",
//                         width: 50,
//                         height: 66,
//                       ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
import 'dart:math';
import 'package:flutter/material.dart';

class Card5 extends StatefulWidget {
  const Card5({super.key, required this.isExpanded, required this.isFlipped});

  final bool isExpanded;
  final bool isFlipped;
  @override
  State<Card5> createState() => _Card5State();
}

class _Card5State extends State<Card5> with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _flipController;
  late Animation<double> _flipAnimation;
  late Animation<double> rotationAnimation;
  late Animation<Offset> positionAnimation;

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

    rotationAnimation = _createRotationAnimation();
    positionAnimation = _createPositionAnimation();

    if (widget.isExpanded) {
      Future.delayed(const Duration(milliseconds: 200), () {
        _controller.forward();
      });
    }
  }

  Animation<double> _createRotationAnimation() {
    return Tween<double>(
      begin: 0,
      end: 2 * pi,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
  }

  Animation<Offset> _createPositionAnimation() {
    return Tween<Offset>(
      begin: widget.isExpanded ? Offset(0.33, 0.33) : Offset.zero,
      end: widget.isExpanded ? Offset.zero : Offset(0.33, 0.33),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.isFlipped ? _flipAnimation : _controller,
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
                        "assets/images/joker.png",
                        width: 50,
                        height: 66,
                      )
                      : Image.asset(
                        "assets/images/card_back.png",
                        width: 50,
                        height: 66,
                      ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _flipController.dispose();
    super.dispose();
  }
}
