import 'dart:ui';
import 'package:aceplus/shared/widgets/check_circle_animation.dart';
import 'package:aceplus/shared/widgets/error_circle_animation.dart';
import 'package:flutter/material.dart';
import 'package:aceplus/shared/utils/constant.dart';
import 'gradient_button.dart';

class StateDialog extends StatelessWidget {
  final String title;
  final String content;
  final String state;

  const StateDialog({
    super.key,
    required this.title,
    required this.content,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.8,
          maxHeight: MediaQuery.of(context).size.height * 0.6,
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(26, 249, 198, 14),
                    blurRadius: 5.0,
                    spreadRadius: 10.0,
                    offset: const Offset(0.0, 3.0),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      fontFamily: poppins,
                    ),
                  ),
                  const SizedBox(height: 20),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    transitionBuilder: (child, animation) {
                      return ScaleTransition(scale: animation, child: child);
                    },
                    child: Center(
                      child: state == "success"
                          ? const CheckCircleAnimation()
                          : const XCircleAnimation()
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    content,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                      fontFamily: poppins,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: 125,
                        child: GradientButton(
                          labelText: 'Okay',
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
