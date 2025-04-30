import 'package:aceplus/features/card_game/presentation/wallet_page/widgets/history_tab.dart';
import 'package:aceplus/shared/utils/constant.dart';
import 'package:aceplus/shared/utils/strings.dart';
import 'package:aceplus/shared/widgets/gradient_gold_container.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class TransactionHistoryPage extends StatefulWidget {
  const TransactionHistoryPage({super.key});

  @override
  State<TransactionHistoryPage> createState() => _TransactionHistoryPageState();
}

class _TransactionHistoryPageState extends State<TransactionHistoryPage> {
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
        backgroundColor: Colors.black,
        automaticallyImplyLeading: true,
        leading: IconButton(
          onPressed: () => context.goNamed("home"),
          color: Colors.white,
          icon: Icon(Icons.arrow_back_ios_new_rounded),
        ),
      ),
      body: Container(
        color: Colors.black,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            GradientGoldContainer(),
            Expanded(
              child: Container(color: Colors.black, child: HistoryTabBar()),
            ),
          ],
        ),
      ),
    );
  }
}
