import 'package:aceplus/shared/utils/constant.dart';
import 'package:aceplus/shared/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextContainer extends StatelessWidget {
  const TextContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 50),
      child: Column(
        children: [
          Text(
            Str().appName.toUpperCase(),
            style: TextStyle(color: primaryYellow, fontSize: 80),
          ),
          Text(
            Str().subtext.toUpperCase(),
            style: TextStyle(color: primaryYellow, fontSize: 28),
          ),
          Text(
            Str().subtext2,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 12,
              fontFamily: GoogleFonts.poppins().fontFamily,
            ),
          ),
        ],
      ),
    );
  }
}
