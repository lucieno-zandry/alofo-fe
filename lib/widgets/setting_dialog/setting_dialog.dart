import 'package:alofo/classes/screen.dart';
import 'package:flutter/material.dart';

class SettingDialog extends StatelessWidget {
  const SettingDialog({super.key, required this.title, required this.content});

  final Widget content;
  final String title;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return AlertDialog(
      title: Text(title, textAlign: TextAlign.center),
      content: SingleChildScrollView(
        child: SizedBox(
          width: Screen.responsive(
            width: screenWidth,
            standard: Screen.clamp(
              200,
              Screen.percentageOf(screenWidth, 50),
              400,
            ),
          ),
          child: content,
        ),
      ),
      shape: Border.all(style: BorderStyle.none),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('CLOSE'),
        ),
      ],
    );
  }
}
