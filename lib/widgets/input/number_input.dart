import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NumberInput extends StatefulWidget {
  final int value;
  final int min;
  final int max;
  final ValueChanged<int> onChanged;
  final String? label;
  final VoidCallback? onIncremented;
  final VoidCallback? onDecremented;

  const NumberInput({
    super.key,
    required this.value,
    required this.min,
    required this.max,
    required this.onChanged,
    this.label,
    this.onIncremented,
    this.onDecremented,
  });

  @override
  State<NumberInput> createState() => _NumberInputState();
}

class _NumberInputState extends State<NumberInput> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.value.toString());
  }

  @override
  void didUpdateWidget(NumberInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != int.tryParse(_controller.text)) {
      _controller.text = widget.value.toString();
    }
  }

  void _onChanged(String value) {
    final intValue = int.tryParse(value);
    if (intValue != null) {
      int clamped = intValue.clamp(widget.min, widget.max);
      if (clamped != widget.value) {
        widget.onChanged(clamped);
      }
      if (clamped.toString() != value) {
        _controller.text = clamped.toString();
        _controller.selection = TextSelection.fromPosition(
          TextPosition(offset: _controller.text.length),
        );
      }
    }
  }

  void _increment() {
    if (widget.value < widget.max) {
      widget.onChanged(widget.value + 1);
      widget.onIncremented?.call();
    }
  }

  void _decrement() {
    if (widget.value > widget.min) {
      widget.onChanged(widget.value - 1);
      widget.onDecremented?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      decoration: InputDecoration(
        labelText: widget.label,
        border: const OutlineInputBorder(),
        suffixIcon: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.remove),
              onPressed: widget.value > widget.min ? _decrement : null,
              tooltip: 'Decrement',
            ),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: widget.value < widget.max ? _increment : null,
              tooltip: 'Increment',
            ),
          ],
        ),
      ),
      onChanged: _onChanged,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
