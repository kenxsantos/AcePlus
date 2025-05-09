import 'package:aceplus/features/card_game/presentation/wallet_page/widgets/cash_process_container.dart';
import 'package:aceplus/shared/utils/constant.dart';
import 'package:aceplus/shared/utils/strings.dart';
import 'package:flutter/material.dart';

class WalletTabBar extends StatefulWidget {
  final String id;
  const WalletTabBar({super.key, required this.id});

  @override
  State<WalletTabBar> createState() => _WalletTabBarState();
}

class _WalletTabBarState extends State<WalletTabBar>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  late final String id;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    id = widget.id;
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
              Container(
                color: primaryBlack,
                margin: const EdgeInsets.all(16.0),
                child: CashInContainer(text: Str().cashIn, id: id),
              ),
              Container(
                color: primaryBlack,
                margin: const EdgeInsets.all(16.0),
                child: CashInContainer(text: Str().cashOut, id: id),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
