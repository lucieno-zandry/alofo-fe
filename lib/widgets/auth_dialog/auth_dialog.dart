import 'package:alofo/classes/screen.dart';
import 'package:alofo/states/auth_dialog_state.dart';
import 'package:alofo/widgets/create_password_dialog/create_password_dialog.dart';
import 'package:alofo/widgets/create_username_dialog/create_username_dialog.dart';
import 'package:alofo/widgets/email_confirmation_code_dialog/email_confirmation_code_dialog.dart';
import 'package:alofo/widgets/login_dialog/login_dialog.dart';
import 'package:alofo/widgets/page_selector/page_selector.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

const authDialogMap = {
  'login': 0,
  'confirm_email': 1,
  'create_username': 2,
  'create_password': 3,
};

class AuthDialog extends StatelessWidget {
  const AuthDialog({super.key, this.withDefault = 'login'});

  final String withDefault;

  int get defaultActive =>
      authDialogMap[withDefault] != null ? authDialogMap[withDefault]! : 0;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    Get.put(AuthDialogState(active: defaultActive));

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
        GetBuilder<AuthDialogState>(
          builder: (state) {
            return Row(
              spacing: 10,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (state.active > 0)
                  TextButton(
                    onPressed: () {
                      state.setActive(--state.active);
                    },
                    child: Row(
                      spacing: 5,
                      children: [Icon(Icons.arrow_back), Text('Back')],
                    ),
                  ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('Close'),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
