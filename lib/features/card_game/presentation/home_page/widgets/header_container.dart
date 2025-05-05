import 'package:aceplus/features/card_game/presentation/auth_dialog/screens/auth_dialog.dart';
import 'package:aceplus/shared/utils/constant.dart';
import 'package:aceplus/shared/utils/logged_in_checker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../auth_dialog/auth_bloc/auth_bloc.dart';
import '../../auth_dialog/auth_bloc/auth_event.dart';

class HeaderContainer extends StatelessWidget {
  const HeaderContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 50, right: 20, left: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("ACE +", style: TextStyle(color: primaryYellow, fontSize: 20)),
          FutureBuilder<bool>(
            future: AuthUtils.isLoggedIn(),
            builder: (context, snapshot) {
              final isLoggedIn = snapshot.data ?? false;

              return isLoggedIn
                  ? IconButton(
                      onPressed: () {
                        context.read<AuthBloc>().add(LogoutAuth());
                      },
                      icon: Icon(Icons.logout, color: primaryYellow),
                    )
                  : IconButton(
                      onPressed: () => showDialog(
                        context: context,
                        builder: (context) => AuthDialog(),
                      ),
                      icon: Image.asset("${iconUrl}user_icon.png"),
                    );
            },
          ),
        ],
      ),
    );
  }
}