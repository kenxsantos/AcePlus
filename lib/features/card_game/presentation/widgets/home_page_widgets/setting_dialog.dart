import 'package:aceplus/shared/utils/strings.dart';
import 'package:aceplus/shared/widgets/gradient_text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'dart:ui';
import '../../../../../shared/widgets/label_slider.dart';

class SettingDialog extends StatelessWidget {
  const SettingDialog({super.key});

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
                  LabeledSlider(
                    label: Str().bgMusic,
                    initialValue: 100,
                    onChanged: (value) {},
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
