import 'package:aceplus/shared/utils/strings.dart';
import 'package:aceplus/shared/widgets/gradient_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'dart:ui';
import '../../../../../shared/widgets/label_slider.dart';
import '../../bloc/setting_bloc/setting_bloc.dart';
import '../../bloc/setting_bloc/setting_event.dart';
import '../../bloc/setting_bloc/setting_state.dart';

class SettingDialog extends StatefulWidget {
  const SettingDialog({super.key});

  @override
  State<SettingDialog> createState() => _SettingDialogState();
}

class _SettingDialogState extends State<SettingDialog> {
  @override
  void initState() {
    super.initState();
    context.read<SettingBloc>().add(LoadBackgroundVolumeEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.8,
          maxHeight: MediaQuery.of(context).size.height * 0.6,
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(26, 249, 198, 14),
                    blurRadius: 5.0,
                    spreadRadius: 10.0,
                    offset: const Offset(0.0, 3.0),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: GradientText(
                          text: Str().settingTitle,
                          textStyle: TextStyle(fontSize: 18),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.close),
                        iconSize: 24,
                        color: Colors.white70,
                        onPressed: () {
                          GoRouter.of(context).pop();
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 14),
                  BlocBuilder<SettingBloc, SettingState>(
                    builder: (context, state) {
                      return LabeledSlider(
                        label: Str().bgMusic,
                        initialValue: state.volume.toDouble(),
                        onChanged: (value) {
                          context.read<SettingBloc>().add(
                            ChangeBackgroundVolumeEvent(value.toDouble()),
                          );
                        },
                      );
                    },
                  ),
                  LabeledSlider(
                    label: Str().cardSound,
                    initialValue: 100,
                    onChanged: (value) {},
                  ),
                  LabeledSlider(
                    label: Str().wheelSound,
                    initialValue: 100,
                    onChanged: (value) {},
                  ),
                  LabeledSlider(
                    label: Str().winSound,
                    initialValue: 100,
                    onChanged: (value) {},
                  ),
                  SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
