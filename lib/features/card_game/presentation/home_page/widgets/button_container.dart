import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../auth_dialog/auth_bloc/auth_bloc.dart';
import '../../auth_dialog/auth_bloc/auth_state.dart';
import '../../auth_dialog/screens/auth_dialog.dart';
import 'package:aceplus/shared/widgets/gradient_button.dart';
import 'package:aceplus/shared/utils/strings.dart';

class ButtonContainer extends StatelessWidget {
  const ButtonContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        final isLoggedIn = state is SearchResult || state is AuthSuccess;
        return Container(
          margin: EdgeInsets.only(top: 50),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GradientButton(
                labelText: Str().playNow,
                onPressed: () {
                  if (isLoggedIn && state is SearchResult) {
                    final userId = state.auth?.id;
                    context.go('/game/$userId');
                  } else {
                    showDialog(
                      context: context,
                      builder: (context) => AuthDialog(),
                    );
                  }
                },
              ),
              if (isLoggedIn)
                GradientButton(
                  labelText: Str().wallet,
                  onPressed: () => context.goNamed("wallet"),
                ),
            ],
          ),
        );
      },
    );
  }
}
