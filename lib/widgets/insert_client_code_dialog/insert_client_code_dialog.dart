import 'package:alofo/widgets/button/button.dart';
import 'package:alofo/widgets/input/text_input.dart';
import 'package:flutter/material.dart';

class InsertClientCodeDialog extends StatefulWidget {
  const InsertClientCodeDialog({super.key});

  @override
  State<InsertClientCodeDialog> createState() => _InsertClientCodeDialogState();
}

class _InsertClientCodeDialogState extends State<InsertClientCodeDialog> {
  String? errorText;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 20,
      children: [
        Text('Do you have a client code?'),
        TextInput(
          onChanged: (value) {},
          errorText: errorText,
          label: 'Client code',
        ),
        Button(variant: 'secondary', onPressed: () {}, child: Text('Submit')),
      ],
    );
  }
}
