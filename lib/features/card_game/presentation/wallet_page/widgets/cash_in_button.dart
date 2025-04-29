import 'package:aceplus/shared/utils/strings.dart';
import 'package:flutter/material.dart';

class CashInButton extends StatelessWidget {
  const CashInButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 5,
            color: const Color.fromARGB(255, 177, 177, 177),
          ),
        ),
        borderRadius: BorderRadius.all(Radius.circular(8)),
        color: Colors.white,
      ),
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Icon((Icons.add), size: 24, color: Color(0xFF5349DD)),
          SizedBox(width: 10),
          Text(
            Str().cashIn.toUpperCase(),
            style: TextStyle(color: const Color(0xFF5349DD)),
          ),
        ],
      ),
    );
  }
}
