import 'package:aceplus/features/card_game/presentation/home_page/screens/home_page.dart';
import 'package:aceplus/features/card_game/presentation/wallet_page/screens/receipt_page.dart';
import 'package:aceplus/features/card_game/presentation/wallet_page/screens/transaction_history_page.dart';
import 'package:aceplus/features/card_game/presentation/wallet_page/screens/wallet_page.dart';
import 'package:go_router/go_router.dart';

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
          path: '/wallet',
          name: 'wallet',
          builder: (context, state) => const WalletPage(),
        ),
        GoRoute(
          path: '/transaction-history',
          name: 'transaction-history',
          builder: (context, state) => const TransactionHistoryPage(),
        ),
        GoRoute(
          path: '/show-receipt',
          name: 'show-receipt',
          builder: (context, state) => const ReceiptPage(),
        ),
      ],
    );
  }
}
