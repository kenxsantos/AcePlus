import 'package:aceplus/shared/utils/constant.dart';
import 'package:aceplus/shared/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CashInButton extends StatelessWidget {
  final String id;
  const CashInButton({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.goNamed("wallet", pathParameters: {"id": id}),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 5,
              color: const Color.fromARGB(255, 177, 177, 177),
            ),
          ),
          borderRadius: BorderRadius.all(Radius.circular(8)),
          color: primaryWhite,
        ),
        padding: EdgeInsets.all(8),
        child: Row(
          children: [
            Icon((Icons.add), size: 24, color: Color(0xFF5349DD)),
            SizedBox(width: 10),
            Text(
              Str().cashIn.toUpperCase(),
              style: TextStyle(
                color: const Color(0xFF5349DD),
                fontFamily: nunito,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
