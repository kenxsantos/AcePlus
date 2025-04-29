import 'package:aceplus/features/card_game/presentation/wallet_page/widgets/cash_in_container.dart';
import 'package:aceplus/features/card_game/presentation/wallet_page/widgets/history_tile.dart';
import 'package:aceplus/shared/utils/constant.dart';
import 'package:aceplus/shared/utils/strings.dart';
import 'package:flutter/material.dart';

class HistoryTabBar extends StatefulWidget {
  const HistoryTabBar({super.key});

  @override
  State<HistoryTabBar> createState() => _HistoryTabBarState();
}

class _HistoryTabBarState extends State<HistoryTabBar>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
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
              ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {},
                    child: HistoryTile(text: Str().cashIn),
                  );
                },
              ),
              ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {},
                    child: HistoryTile(text: Str().cashOut),
                  );
                },
              ),
              // Container(
              //   color: Colors.black,
              //   margin: const EdgeInsets.all(16.0),
              //   child: CashInContainer(text: Str().cashOut),
              // ),
            ],
          ),
        ),
      ],
    );
  }
}
