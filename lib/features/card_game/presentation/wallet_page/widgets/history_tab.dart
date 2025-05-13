import 'package:aceplus/shared/widgets/centered_text.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aceplus/features/card_game/presentation/wallet_page/transaction_bloc/transaction_bloc.dart';
import 'package:aceplus/features/card_game/presentation/wallet_page/transaction_bloc/transaction_event.dart';
import 'package:aceplus/features/card_game/presentation/wallet_page/transaction_bloc/transaction_state.dart';
import 'package:aceplus/features/card_game/presentation/wallet_page/widgets/history_tile.dart';
import 'package:aceplus/shared/utils/constant.dart';
import 'package:aceplus/shared/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HistoryTabBar extends StatefulWidget {
  final String id;

  const HistoryTabBar({super.key, required this.id});

  @override
  State<HistoryTabBar> createState() => _HistoryTabBarState();
}

class _HistoryTabBarState extends State<HistoryTabBar>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  late final String id;

  @override
  void initState() {
    super.initState();
    id = widget.id;
    _tabController = TabController(length: 2, vsync: this);

    _tabController.addListener(() {
      if (_tabController.index == 0) {
        context.read<TransactionBloc>().add(
          LoadTransactionByType(
            userId: int.parse(widget.id),
            transactionType: Str().cashIn,
          ),
        );
      } else if (_tabController.index == 1) {
        context.read<TransactionBloc>().add(
          LoadTransactionByType(
            userId: int.parse(widget.id),
            transactionType: Str().cashOut,
          ),
        );
      }
    });

    context.read<TransactionBloc>().add(
      LoadTransactionByType(
        userId: int.parse(widget.id),
        transactionType: Str().cashIn,
      ),
    );
  }

  @override
  void dispose() {
    _tabController.removeListener(() {});
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TabBar.secondary(
          indicatorColor: primaryYellow,
          labelColor: primaryYellow,
          controller: _tabController,
          tabs: <Widget>[Tab(text: Str().cashIn), Tab(text: Str().cashOut)],
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: <Widget>[
              // Cash In Transactions
              BlocBuilder<TransactionBloc, TransactionState>(
                builder: (context, state) {
                  if (state is TransactionLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is TransactionsLoaded) {
                    final cashInTransactions =
                        state.transactions
                            .where((t) => t.transactionType == Str().cashIn)
                            .toList();
                    return ListView.builder(
                      itemCount: cashInTransactions.length,
                      itemBuilder: (context, index) {
                        final transaction = cashInTransactions[index];
                        return GestureDetector(
                          onTap:
                              () => context.go(
                                '/show-receipt/$id/${transaction.transactionId}',
                              ),
                          child: HistoryTile(
                            text: transaction.transactionType,
                            color: Color(0xFF42F271),
                            date: transaction.transactionDate,
                            amount: double.parse(
                              transaction.amount.toString(),
                            ).toStringAsFixed(2),
                          ),
                        );
                      },
                    );
                  } else if (state is NoDataState) {
                    return CenteredText(state.message, Colors.white);
                  } else if (state is TransactionError) {
                    return CenteredText(state.error, Color(0xFFF56C6C));
                  } else {
                    return CenteredText("No Transactions Found", Colors.white);
                  }
                },
              ),
              // Cash Out Transactions
              BlocBuilder<TransactionBloc, TransactionState>(
                builder: (context, state) {
                  if (state is TransactionLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is TransactionsLoaded) {
                    final cashOutTransactions =
                        state.transactions
                            .where((t) => t.transactionType == Str().cashOut)
                            .toList();
                    return ListView.builder(
                      itemCount: cashOutTransactions.length,
                      itemBuilder: (context, index) {
                        final transaction = cashOutTransactions[index];
                        return GestureDetector(
                          onTap:
                              () => context.go(
                                '/show-receipt/$id/${transaction.transactionId}',
                              ),
                          child: HistoryTile(
                            text: transaction.transactionType,
                            color: Colors.red,
                            date: transaction.transactionDate,
                            amount: transaction.amount.toString(),
                          ),
                        );
                      },
                    );
                  } else if (state is NoDataState) {
                    return CenteredText(state.message, Colors.white);
                  } else if (state is TransactionError) {
                    return CenteredText(state.error, Color(0xFFF56C6C));
                  } else {
                    return CenteredText("No Transactions Found", Colors.white);
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
