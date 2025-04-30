import 'package:aceplus/features/card_game/presentation/wallet_page/widgets/receipt_info.dart';
import 'package:aceplus/shared/utils/constant.dart';
import 'package:aceplus/shared/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class ReceiptPage extends StatelessWidget {
  const ReceiptPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end, // Align title to the right
          children: [
            Text(
              Str().eWallet,
              style: TextStyle(
                color: primaryYellow,
                fontFamily: GoogleFonts.lemon().fontFamily,
                fontSize: 20,
              ),
            ),
          ],
        ),
        backgroundColor: primaryBlack,
        automaticallyImplyLeading: true,
        leading: IconButton(
          onPressed: () => context.goNamed("transaction-history"),
          color: primaryWhite,
          icon: Icon(Icons.arrow_back_ios_new_rounded),
        ),
      ),
      body: Container(
        alignment: Alignment.topCenter,
        color: primaryBlack,
        padding: EdgeInsets.all(25),
        child: Container(
          padding: EdgeInsets.all(25),
          width: 500,
          height: 350,
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 22, 22, 22),
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset('${iconUrl}receipt_icon.png'),
              Divider(height: 5),
              Column(
                children: [
                  ReceiptInfo(
                    txtTitle: "Amount",
                    txtValue: "-50.00",
                    txtColor: Colors.red,
                  ),
                  ReceiptInfo(
                    txtTitle: "Date",
                    txtValue: "April 1, 2025",
                    txtColor: primaryWhite,
                  ),
                  ReceiptInfo(
                    txtTitle: "Time",
                    txtValue: "9:45 AM",
                    txtColor: primaryWhite,
                  ),
                  ReceiptInfo(
                    txtTitle: "Reference No.",
                    txtValue: "213513203461348",
                    txtColor: primaryWhite,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
