import 'package:alofo/functions/get_validation_message.dart';
import 'package:alofo/http/requests.dart';
import 'package:alofo/states/auth_dialog_state.dart';
import 'package:alofo/widgets/button/button.dart';
import 'package:alofo/widgets/input/text_input.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class PasswordForgottenDialog extends StatefulWidget {
  const PasswordForgottenDialog({super.key});

  @override
  State<PasswordForgottenDialog> createState() =>
      _PasswordForgottenDialogState();
}

class _PasswordForgottenDialogState extends State<PasswordForgottenDialog> {
  String? errorText;
  TextEditingController emailController = TextEditingController();
  bool isLoading = false;
  AuthDialogState state = Get.find<AuthDialogState>();

  bool get isValid => errorText == null && emailController.text != '';

  onSubmited() {
    if (errorText != null) return;
    setState(() {
      isLoading = true;
    });
    sendPasswordResetLink(emailController.text)
        .then((response) {
          Fluttertoast.showToast(
            msg: "Password reset link sent!",
            webShowClose: true,
            gravity: ToastGravity.TOP_RIGHT,
            toastLength: Toast.LENGTH_LONG,
          );

          if (context.mounted) Navigator.of(context).pop();
          state.updateState(newActive: 0, newHistory: [0]);
        })
        .catchError((error) {
          if (error is Map) {
            if (error['errors']?['email'] != null) {
              setState(() {
                errorText = error['errors']['email'];
              });
            }
          }
        })
        .whenComplete(() {
          setState(() {
            isLoading = false;
          });
        });
  }

  onEmailChanged(value) {
    String? validationMessage = getValidationMessage('user.email', value);

    setState(() {
      errorText = validationMessage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 20,
      children: [
        Text('Enter your email adress'),
        TextInput(
          onChanged: onEmailChanged,
          controller: emailController,
          label: 'email',
          errorText: errorText,
        ),
        Button(
          variant: 'primary',
          onPressed: isValid ? onSubmited : null,
          isLoading: isLoading,
          child: Text('Get Link'),
        ),
      ],
    );
  }
}
