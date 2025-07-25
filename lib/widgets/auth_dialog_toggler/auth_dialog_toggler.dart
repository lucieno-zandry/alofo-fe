import 'package:alofo/states/auth_dialog_state.dart';
import 'package:alofo/states/front_office_state.dart';
import 'package:alofo/widgets/auth_dialog/auth_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthDialogToggler extends StatelessWidget {
  const AuthDialogToggler({super.key});

  @override
  Widget build(BuildContext context) {
    Color? color = DefaultTextStyle.of(context).style.color;

    return GetBuilder<FrontOfficeState>(
      builder: (frontOfficeState) {
        if (frontOfficeState.user == null) {
          return TextButton(
            onPressed: () {
              showDialog(
                context: context,
                builder:
                    (BuildContext context) => AuthDialog(
                      defaultActive: authDialogMap['login']!.index,
                    ),
                barrierDismissible: false,
              );
            },
            child: Row(
              spacing: 5,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.person, color: color),
                Text("Login / Signup", style: TextStyle(color: color)),
              ],
            ),
          );
        }

        return SizedBox();
      },
    );
  }
}
