import 'package:aceplus/features/card_game/presentation/auth_dialog/screens/auth_dialog.dart';
import 'package:aceplus/shared/utils/constant.dart';
import 'package:flutter/material.dart';

class HeaderContainer extends StatelessWidget {
  const HeaderContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("ACE +", style: TextStyle(color: primaryYellow, fontSize: 20)),
          IconButton(
            onPressed:
                () => showDialog(
                  context: context,
                  builder: (context) => AuthDialog(),
                ),

            icon: Image.asset("${iconUrl}user_icon.png"),
          ),
        ],
      ),
    );
  }
}
