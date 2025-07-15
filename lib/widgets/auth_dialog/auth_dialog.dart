import 'package:alofo/classes/screen.dart';
import 'package:alofo/states/auth_dialog_state.dart';
import 'package:alofo/widgets/create_password_dialog/create_password_dialog.dart';
import 'package:alofo/widgets/create_username_dialog/create_username_dialog.dart';
import 'package:alofo/widgets/email_confirmation_code_dialog/email_confirmation_code_dialog.dart';
import 'package:alofo/widgets/login_dialog/login_dialog.dart';
import 'package:alofo/widgets/page_selector/page_selector.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthDialog extends StatelessWidget {
  const AuthDialog({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    Get.put(AuthDialogState());

    return AlertDialog(
      title: Text('Login / Register', textAlign: TextAlign.center),
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
          child: GetBuilder<AuthDialogState>(
            builder: (state) {
              return PageSelector(
                active: state.active,
                children: [
                  LoginDialog(),
                  EmailConfirmationCodeDialog(),
                  CreateUsernameDialog(),
                  CreatePasswordDialog(),
                ],
              );
            },
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Close'),
        ),
      ],
    );
  }
}
