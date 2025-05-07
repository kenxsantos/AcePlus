import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:aceplus/shared/utils/constant.dart';

import 'gradient_button.dart';

class ConfirmationDialog extends StatelessWidget {
  final String title;
  final String content;
  final VoidCallback onConfirm;

  const ConfirmationDialog({
    super.key,
    required this.title,
    required this.content,
    required this.onConfirm,
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
                      fontSize: 18,
                      fontFamily: poppins,
                    ),
                  ),
                  const SizedBox(height: 10),
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
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            color: Colors.grey,
                            fontFamily: poppins,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      SizedBox(
                        width: 125,
                        child: GradientButton(
                          labelText: 'Confirm',
                          onPressed: onConfirm,
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
