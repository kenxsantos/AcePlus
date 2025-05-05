import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../auth_dialog/auth_bloc/auth_bloc.dart';
import '../../auth_dialog/auth_bloc/auth_event.dart';
import '../../auth_dialog/auth_bloc/auth_state.dart';
import '../../auth_dialog/screens/auth_dialog.dart';
import 'package:aceplus/shared/utils/constant.dart';

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
          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is SearchResult || state is AuthSuccess) {
                return IconButton(
                  onPressed: () {
                    context.read<AuthBloc>().add(LogoutAuth());
                  },
                  icon: Icon(Icons.logout, color: primaryYellow),
                );
              } else {
                return IconButton(
                  onPressed:
                      () => showDialog(
                        context: context,
                        builder: (context) => AuthDialog(),
                      ),
                  icon: Image.asset("${iconUrl}user_icon.png"),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
