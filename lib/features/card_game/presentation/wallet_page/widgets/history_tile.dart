import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HistoryTile extends StatelessWidget {
  const HistoryTile({super.key, required this.text, required this.color});

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF000000),
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: const Color.fromARGB(255, 83, 83, 83),
          ),
        ),
      ),
      child: Card(
        color: const Color(0xFF000000),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
          side: BorderSide(width: 1, style: BorderStyle.solid),
        ),
        elevation: 4,
        margin: const EdgeInsets.symmetric(vertical: 5),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "9:45 PM",
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.white,
                      fontFamily: GoogleFonts.roboto().fontFamily,
                    ),
                  ),
                  Text(
                    text,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontFamily: GoogleFonts.roboto().fontFamily,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "April 1, 2025",
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.white,
                      fontFamily: GoogleFonts.roboto().fontFamily,
                    ),
                  ),
                ],
              ),
              Text(
                "₱ 200.00",
                style: TextStyle(
                  fontSize: 18,
                  color: color,
                  fontFamily: GoogleFonts.roboto().fontFamily,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
