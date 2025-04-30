import 'package:aceplus/features/card_game/presentation/wallet_page/widgets/wallet_tab.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({super.key});

  @override
  WalletPageState createState() => WalletPageState();
}

class WalletPageState extends State<WalletPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: true,
        leading: IconButton(
          onPressed: () => {},
          color: Colors.white,
          icon: Icon(Icons.arrow_back_ios_new_rounded),
        ),
        actions: [
          IconButton(
            onPressed: () => context.goNamed("transaction-history"),
            icon: Icon(Icons.list),
            color: Colors.white,
            iconSize: 30,
          ),
        ],
      ),
      body: WalletTabBar(),
    );
  }
}
