import 'package:aceplus/features/card_game/presentation/wallet_page/screens/transaction_history.dart';
import 'package:aceplus/features/card_game/presentation/wallet_page/screens/wallet_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  late final GoRouter router;

  AppRouter() {
    router = GoRouter(
      initialLocation: '/',
      routes: [
        ShellRoute(
          builder: (context, state, child) {
            return Scaffold(
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
              body: child,
            );
          },
          routes: [
            GoRoute(
              path: '/',
              name: 'home',
              builder: (context, state) => const WalletPage(),
            ),
            GoRoute(
              path: '/transaction-history',
              name: 'transaction-history',
              builder: (context, state) => const TransactionHistory(),
            ),
          ],
        ),
      ],
    );
  }
}
