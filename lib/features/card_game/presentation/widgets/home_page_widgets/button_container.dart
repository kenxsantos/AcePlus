import 'package:aceplus/features/card_game/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:aceplus/features/card_game/presentation/bloc/auth_bloc/auth_state.dart';
import 'package:aceplus/features/card_game/presentation/widgets/auth_dialog_widgets/auth_dialog.dart';
import 'package:aceplus/features/card_game/presentation/bloc/timer_bloc/timer_bloc.dart';
import 'package:aceplus/features/card_game/presentation/widgets/home_page_widgets/setting_dialog.dart';
import 'package:aceplus/shared/utils/logged_in_checker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:aceplus/shared/widgets/gradient_button.dart';
import 'package:aceplus/shared/utils/strings.dart';

class ButtonContainer extends StatelessWidget {
  const ButtonContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        final isLoggedIn = state is SearchUserResult || state is AuthSuccess;
        return Container(
          margin: EdgeInsets.only(top: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: 175,
                child: GradientButton(
                  labelText: Str().playNow,
                  onPressed: () async {
                    if (isLoggedIn) {
                      final userId = await AuthUtils.getUserId();
                      if (userId != null) {
                        if (context.mounted) {
                          context.go('/game/$userId');
                          context.read<TimerBloc>().add(
                            TimerStarting(duration: 5),
                          );
                        }
                      }
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) => AuthDialog(),
                      );
                    }
                  },
                ),
              ),
              if (isLoggedIn) ...[
                SizedBox(height: 20),
                SizedBox(
                  width: 175,
                  child: GradientButton(
                    labelText: Str().instruction,
                    onPressed: () {},
                  ),
                ),
              ],
              SizedBox(height: 20),
              SizedBox(
                width: 175,
                child: GradientButton(
                  labelText: Str().settings,
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => SettingDialog(),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
