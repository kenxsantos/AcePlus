import 'package:flutter/material.dart';
import 'bottom_bet_container.dart';
import 'bottom_bet_toolbar.dart';

class BottomBetWidget extends StatelessWidget {
  final ValueNotifier<bool> _isVisible = ValueNotifier<bool>(true);

  BottomBetWidget({super.key});

  void _toggleVisibility() {
    _isVisible.value = !_isVisible.value;
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        ValueListenableBuilder<bool>(
          valueListenable: _isVisible,
          builder: (context, isVisible, child) {
            return AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              bottom: isVisible ? 0 : -screenHeight * 0.26,
              child: const BottomBetContainer(),
            );
          },
        ),
        ValueListenableBuilder<bool>(
          valueListenable: _isVisible,
          builder: (context, isVisible, child) {
            return AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              bottom: isVisible ? screenHeight * 0.26 - 2 : 0,
              child: BottomToolbarWidget(onTap: _toggleVisibility),
            );
          },
        ),
      ],
    );
  }
}
