import 'package:alofo/classes/screen.dart';
import 'package:alofo/widgets/email_confirmation_code_dialog/email_confirmation_code_dialog.dart';
import 'package:alofo/widgets/login_dialog/login_dialog.dart';
import 'package:alofo/widgets/page_selector/page_selector.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthDialogState with ChangeNotifier {
  int active = 0;

  setActive(int newActive) {
    active = newActive;
    notifyListeners();
  }
}

class AuthDialog extends StatelessWidget {
  const AuthDialog({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return AlertDialog(
      title: Text('Login / Register', textAlign: TextAlign.center),
      content: SingleChildScrollView(
        child: ChangeNotifierProvider(
          create: (context) => AuthDialogState(),
          child: SizedBox(
            width: Screen.responsive(
              width: screenWidth,
              standard: Screen.clamp(
                200,
                Screen.percentageOf(screenWidth, 50),
                400,
              ),
            ),
            child: Builder(
              builder: (context) {
                AuthDialogState state = context.watch<AuthDialogState>();

                return PageSelector(
                  active: state.active,
                  children: [LoginDialog(), EmailConfirmationCodeDialog()],
                );
              },
            ),
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
