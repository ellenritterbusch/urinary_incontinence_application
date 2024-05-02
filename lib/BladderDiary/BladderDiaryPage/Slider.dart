
import 'package:flutter/material.dart';

 double currentSliderValue = 0;
class SeveritySlider extends StatefulWidget {
  final Function(double) sliderChanged;
  const SeveritySlider({super.key, required this.sliderChanged});

  @override
  State<SeveritySlider> createState() => _SeveritySliderState();
}

class _SeveritySliderState extends State<SeveritySlider> {

  @override
  Widget build(BuildContext context) {
    return 
      SliderTheme(
        data: const SliderThemeData(
          valueIndicatorTextStyle: TextStyle(fontSize: 25),
          trackHeight: 8
        ),
        child: Slider(
            value: currentSliderValue,
            max: 3,
            min: 0,
            divisions: 3,
            label: currentSliderValue.round().toString(),
            onChanged:  widget.sliderChanged,
           ));
  }
}