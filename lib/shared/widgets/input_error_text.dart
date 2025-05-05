import 'package:flutter/material.dart';

import '../utils/constant.dart ';

class InputErrorText extends StatelessWidget {
  final String error;

  const InputErrorText({
    super.key,
    required this.error,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Flexible(
            child: Text(
              error,
              style: TextStyle(
                color: Colors.red,
                fontSize: 8,
                fontFamily: poppins,
              ),
              textAlign: TextAlign.right,
              softWrap: true,
              overflow: TextOverflow.visible,
            ),
          ),
        ],
      ),
    );
  }
}