import 'package:flutter/material.dart';

class ReceiptInfo extends StatelessWidget {
  const ReceiptInfo({
    super.key,
    required this.txtTitle,
    required this.txtValue,
    required this.txtColor,
  });

  final String txtTitle;
  final String txtValue;
  final Color txtColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(txtTitle, style: TextStyle(color: Colors.white, fontSize: 12)),
          Text(txtValue, style: TextStyle(color: txtColor, fontSize: 12)),
        ],
      ),
    );
  }
}
