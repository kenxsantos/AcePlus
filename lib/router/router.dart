import 'package:aceplus/features/card_game/presentation/home_page/screens/home_page.dart';
import 'package:aceplus/features/card_game/presentation/wallet_page/screens/receipt_page.dart';
import 'package:aceplus/features/card_game/presentation/wallet_page/screens/transaction_history_page.dart';
import 'package:aceplus/features/card_game/presentation/wallet_page/screens/wallet_page.dart';
import 'package:go_router/go_router.dart';

import '../features/card_game/presentation/game_page/screens/game_page.dart';

class AppRouter {
  late final GoRouter router;

  AppRouter() {
    router = GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/',
          name: 'home',
          builder: (context, state) => const HomePage(),
        ),
        GoRoute(
          path: '/play-game',
          name: 'play-game',
          builder: (context, state) => const HomePage(),
        ),
        GoRoute(
          path: '/wallet/:id',
          name: 'wallet',
          builder: (context, state) {
            final id = state.pathParameters['id'];
            return WalletPage(id: id!);
          },
        ),
        GoRoute(
          path: '/transaction-history/:id',
          name: 'transaction-history',
          builder: (context, state) => TransactionHistoryPage(
            id: state.pathParameters['id'] ?? '',
          ),
        ),
        GoRoute(
          path: '/show-receipt/:id',
          name: 'show-receipt',
          builder: (context, state) {
            final id = state.pathParameters['id'];
            return ReceiptPage(id: id!);
          },
        ),
        GoRoute(
          path: '/game/:id',
          name: 'game',
          builder: (context, state) {
            final id = state.pathParameters['id'];
            return GamePage(id: id!);
          },
        ),
      ],
    );
  }
}
