import 'package:alofo/widgets/button/button.dart';
import 'package:alofo/widgets/input/password_input.dart';
import 'package:flutter/material.dart';

class SettingPasswordDialog extends StatelessWidget {
  const SettingPasswordDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      children: [
        PasswordInput(onChanged: (value) {}, label: 'Current password'),
        PasswordInput(onChanged: (value) {}, label: 'New password'),
        PasswordInput(onChanged: (value) {}, label: 'Password confirmation'),
        Button(onPressed: () {}, child: Text('Update password')),
      ],
    );
  }
}
