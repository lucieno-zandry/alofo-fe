import 'package:flutter/material.dart';

class RangeInput extends StatelessWidget {
  const RangeInput({
    super.key,
    required this.currentRange,
    required this.onChanged,
    this.min = 0,
    this.max = 10_000,
    this.divisions = 20,
  });

  final RangeValues currentRange;
  final Function(RangeValues)? onChanged;
  final double min;
  final double max;
  final int divisions;

  @override
  Widget build(BuildContext context) {
    return RangeSlider(
      values: currentRange,
      min: min,
      max: max,
      divisions: divisions,
      labels: RangeLabels(
        currentRange.start.round().toString(),
        currentRange.end.round().toString(),
      ),
      onChanged: onChanged,
    );
  }
}
