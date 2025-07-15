// Example debug widget
import 'package:flutter/material.dart';

class DebugDump extends StatelessWidget {
  final Object data;
  const DebugDump(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black87,
      padding: const EdgeInsets.all(8),
      child: Text(
        data.toString(),
        style: const TextStyle(color: Colors.greenAccent, fontSize: 12),
      ),
    );
  }
}
