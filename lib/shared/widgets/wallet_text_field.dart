import 'package:aceplus/shared/utils/constant.dart';
import 'package:flutter/material.dart';

class WalletTextField extends StatelessWidget {
  const WalletTextField({
    super.key,
    required this.labelText,
    required this.controller,
    this.onChanged,
  });

  final String labelText;
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      margin: EdgeInsets.only(bottom: 6),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(
            fontSize: 12,
            color: const Color.fromARGB(255, 175, 175, 175),
          ),
          filled: true,
          fillColor: const Color.fromARGB(255, 83, 82, 82),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color.fromARGB(255, 114, 114, 114),
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color.fromARGB(255, 83, 82, 82),
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red, width: 1.0),
            borderRadius: BorderRadius.circular(8.0),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 16.0,
          ),
        ),
        style: const TextStyle(fontSize: 16.0, color: primaryBlack),
      ),
    );
  }
}