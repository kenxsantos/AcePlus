import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../../shared/utils/logged_in_checker.dart';
import '../../../../../shared/widgets/confirmation_dialog.dart';
import '../../auth_dialog/auth_bloc/auth_bloc.dart';
import '../../auth_dialog/auth_bloc/auth_event.dart';
import '../../auth_dialog/auth_bloc/auth_state.dart';
import '../../auth_dialog/screens/auth_dialog.dart';
import 'package:aceplus/shared/utils/constant.dart';

class HeaderContainer extends StatefulWidget {
  const HeaderContainer({super.key});

  @override
  State<HeaderContainer> createState() => _HeaderContainerState();
}

class _HeaderContainerState extends State<HeaderContainer> {
  final isPlaying = ValueNotifier<bool>(true);

  final AudioPlayer player = AudioPlayer();

  void toggleVolume() {
    isPlaying.value = !isPlaying.value;
    if (isPlaying.value) {
      player.resume();
    } else {
      player.pause();
    }
  }

  Future<void> setupAudio() async {
    await player.setReleaseMode(ReleaseMode.loop);
    await player.play(AssetSource('sounds/jazz_music_bg.MP3'));
  }

  @override
  void initState() {
    super.initState();
    setupAudio();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 50, right: 20, left: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("ACE +", style: TextStyle(color: primaryYellow, fontSize: 20)),
          Row(
            children: [
              ValueListenableBuilder(
                valueListenable: isPlaying,
                builder: (context, value, child) {
                  return IconButton(
                    icon: Icon(
                      value
                          ? Icons.volume_up_rounded
                          : Icons.volume_off_rounded,
                    ),
                    color: value ? primaryYellow : Colors.white70,
                    iconSize: 26,
                    onPressed: toggleVolume,
                  );
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
                                    content: "Are you sure you want to logout?",
                                    onConfirm: () {
                                      Navigator.of(context).pop();
                                      context.read<AuthBloc>().add(LogoutAuth());
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
  }
}
