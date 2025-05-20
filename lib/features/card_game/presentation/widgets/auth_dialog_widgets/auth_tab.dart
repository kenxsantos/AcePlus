import 'package:aceplus/features/card_game/presentation/widgets/auth_dialog_widgets/login_form.dart';
import 'package:aceplus/features/card_game/presentation/widgets/auth_dialog_widgets/register_form.dart';
import 'package:aceplus/shared/utils/constant.dart';
import 'package:aceplus/shared/utils/strings.dart';

import 'package:flutter/material.dart';

class AuthTabBar extends StatefulWidget {
  const AuthTabBar({super.key});

  @override
  State<AuthTabBar> createState() => _AuthTabBarState();
}

class _AuthTabBarState extends State<AuthTabBar>
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
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: FractionallySizedBox(
            widthFactor: 0.85,
            child: TabBar.secondary(
              indicatorColor: Color(0xFFE7BB68),
              indicatorWeight: 5,
              dividerHeight: 5,
              labelColor: primaryWhite,
              controller: _tabController,
              tabs: <Widget>[
                Tab(
                  child: Text(Str().logIn, style: TextStyle(fontFamily: poppins)),
                ),
                Tab(
                  child: Text(
                    Str().register,
                    style: TextStyle(fontFamily: poppins),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 345,
          child: TabBarView(
            controller: _tabController,
            children: <Widget>[
              Center(child: LoginForm()),
              Center(child: RegisterForm()),
            ],
          ),
        ),
      ],
    );
  }
}
