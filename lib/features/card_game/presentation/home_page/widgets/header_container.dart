import 'package:aceplus/shared/utils/constant.dart';
import 'package:flutter/material.dart';

class HeaderContainer extends StatelessWidget {
  const HeaderContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 50, right: 20, left: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("ACE +", style: TextStyle(color: primaryYellow, fontSize: 20)),
          Image.asset("${iconUrl}user_icon.png"),
        ],
      ),
    );
  }
}
