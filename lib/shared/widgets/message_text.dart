import 'package:flutter/material.dart';

import '../utils/constant.dart ';

class MessageDisplay extends StatelessWidget {
  final String message;
  final Color messageColor;

  const MessageDisplay({
    super.key,
    required this.message,
    required this.messageColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Center(
        child: Text(
          message,
          style: TextStyle(
            color: messageColor,
            fontSize: 12,
            fontFamily: poppins,
          ),
        ),
      ),
    );
  }
}