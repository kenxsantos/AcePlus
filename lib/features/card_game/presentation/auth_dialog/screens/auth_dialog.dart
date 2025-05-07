import 'dart:ui';
import 'package:aceplus/features/card_game/presentation/auth_dialog/widgets/auth_tab.dart';
import 'package:flutter/material.dart';

class AuthDialog extends StatelessWidget {
  final ValueNotifier<bool> isLogin = ValueNotifier<bool>(true);

  AuthDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
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

            height: 420,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [Expanded(child: AuthTabBar())],
            ),
          ),
        ],
      ),
    );
  }
}
