import 'package:aceplus/shared/utils/constant.dart';
import 'package:flutter/material.dart';

class ReceiptInfo extends StatelessWidget {
  const ReceiptInfo({
    super.key,
    required this.txtTitle,
    required this.txtValue,
    required this.txtColor,
  });

  final String txtTitle;
  final InlineSpan txtValue;
  final Color txtColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(txtTitle, style: TextStyle(color: primaryWhite, fontSize: 12)),
          RichText(
            text: txtValue,
          ),
        ],
      ),
    );
  }
}
