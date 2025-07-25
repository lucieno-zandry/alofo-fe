import 'package:alofo/widgets/setting_dialog/setting_dialog.dart';
import 'package:flutter/material.dart';

class SettingRow extends StatelessWidget {
  const SettingRow({
    super.key,
    required this.title,
    required this.dialogContent,
    required this.dialogTitle,
    this.value,
  });

  final String title;
  final String? value;
  final Widget dialogContent;
  final String dialogTitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title),
        Row(
          mainAxisSize: MainAxisSize.min,
          spacing: 10,
          children: [
            if (value != null) Text(value!),
            IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder:
                      (context) => SettingDialog(
                        content: dialogContent,
                        title: dialogTitle,
                      ),
                );
              },
              icon: Icon(Icons.chevron_right),
            ),
          ],
        ),
      ],
    );
  }
}
