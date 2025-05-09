import 'package:aceplus/shared/utils/constant.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class HistoryTile extends StatelessWidget {
  const HistoryTile({
    super.key,
    required this.text,
    required this.color,
    required this.date,
    required this.amount,
  });

  final String text;
  final Color color;
  final DateTime date;
  final String amount;

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
                    DateFormat('h:mm a').format(date),
                    style: TextStyle(
                      fontSize: 10,
                      color: primaryWhite,
                      fontFamily: roboto,
                    ),
                  ),
                  Text(
                    text,
                    style: TextStyle(
                      fontSize: 20,
                      color: primaryWhite,
                      fontFamily: roboto,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    DateFormat('MMMM d, y').format(date),
                    style: TextStyle(
                      fontSize: 10,
                      color: primaryWhite,
                      fontFamily: roboto,
                    ),
                  ),
                ],
              ),
              Text(
                amount,
                style: TextStyle(
                  fontSize: 18,
                  color: color,
                  fontFamily: roboto,
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
