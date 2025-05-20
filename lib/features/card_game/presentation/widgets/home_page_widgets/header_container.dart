import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../bloc/auth_bloc/auth_bloc.dart';
import '../../bloc/auth_bloc/auth_event.dart';
import '../../bloc/auth_bloc/auth_state.dart';
import '../auth_dialog_widgets/auth_dialog.dart';
import '../../../../../shared/widgets/confirmation_dialog.dart';
import '../../../../../shared/utils/logged_in_checker.dart';
import '../../bloc/sound_bloc/sound_bloc.dart';
import '../../bloc/sound_bloc/sound_event.dart';
import '../../bloc/sound_bloc/sound_state.dart';
import 'package:aceplus/shared/utils/constant.dart';

class HeaderContainer extends StatelessWidget {
  const HeaderContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SoundBloc, SoundState>(
      builder: (context, state) {
        final isPlaying = state is SoundPlaying;
        print("Sound is playing: $isPlaying");

        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "ACE +",
                style: TextStyle(color: primaryYellow, fontSize: 20),
              ),
              Row(
                children: [
                  IconButton(
                    icon: Icon(
                      isPlaying
                          ? Icons.volume_up_rounded
                          : Icons.volume_off_rounded,
                    ),
                    color: isPlaying ? primaryYellow : Colors.white70,
                    iconSize: 26,
                    onPressed: () {
                      context.read<SoundBloc>().add(ToggleSound());
                    },
                  ),
                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      if (state is SearchUserResult || state is AuthSuccess) {
                        return Row(
                          children: [
                            IconButton(
                              onPressed: () async {
                                final userId = await AuthUtils.getUserId();
                                if (userId != null && context.mounted) {
                                  context.go('/wallet/$userId');
                                }
                              },
                              icon: Icon(Icons.wallet),
                              color: primaryYellow,
                              iconSize: 26,
                            ),
                            IconButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder:
                                      (context) => ConfirmationDialog(
                                        title: "Logout Confirmation",
                                        content:
                                            "Are you sure you want to logout?",
                                        onConfirm: () {
                                          Navigator.of(context).pop();
                                          context.read<AuthBloc>().add(
                                            LogoutAuth(),
                                          );
                                        },
                                      ),
                                );
                              },
                              icon: Icon(Icons.logout, color: primaryYellow),
                            ),
                          ],
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
            ],
          ),
        );
      },
    );
  }
}
