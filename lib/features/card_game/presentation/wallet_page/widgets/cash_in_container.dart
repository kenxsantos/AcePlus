import 'package:aceplus/shared/utils/constant.dart';
import 'package:aceplus/shared/utils/strings.dart';
import 'package:aceplus/shared/widgets/solid_button.dart';
import 'package:aceplus/shared/widgets/wallet_text_field.dart';
import 'package:flutter/material.dart';

class CashInContainer extends StatelessWidget {
  const CashInContainer({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 30),
          child: Image.asset("${imageUrl}gcash_logo.png"),
        ),
        WalletTextField(labelText: Str().enterAccNo),
        WalletTextField(labelText: Str().enterAmount),
        SolidButton(labelText: text, onPressed: () => print("Cash in")),
      ],
    );
  }
}
