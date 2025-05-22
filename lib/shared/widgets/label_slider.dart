import 'package:flutter/material.dart';
import '../utils/constant.dart';
import 'gradient_text.dart';

class LabeledSlider extends StatefulWidget {
  final String label;
  final double initialValue;
  final ValueChanged<double> onChanged;

  const LabeledSlider({
    super.key,
    required this.label,
    required this.initialValue,
    required this.onChanged,
  });

  @override
  LabeledSliderState createState() => LabeledSliderState();
}

class LabeledSliderState extends State<LabeledSlider> {
  late ValueNotifier<double> sliderValue;

  @override
  void initState() {
    super.initState();
    sliderValue = ValueNotifier(widget.initialValue);
  }

  @override
  void didUpdateWidget(covariant LabeledSlider oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialValue != widget.initialValue) {
      sliderValue.value = widget.initialValue;
    }
  }

  @override
  void dispose() {
    sliderValue.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GradientText(
          text: widget.label,
          textStyle: const TextStyle(fontSize: 12),
        ),
        ValueListenableBuilder<double>(
          valueListenable: sliderValue,
          builder: (context, value, child) {
            return SliderTheme(
              data: SliderTheme.of(context).copyWith(
                thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 0.0),
              ),
              child: Slider(
                min: 1,
                max: 100,
                divisions: 100,
                value: value,
                activeColor: primaryYellow,
                inactiveColor: primaryWhite.withAlpha(80),
                onChanged: (newValue) {
                  sliderValue.value = newValue;
                  widget.onChanged(newValue);
                },
              ),
            );
          },
        ),
      ],
    );
  }
}