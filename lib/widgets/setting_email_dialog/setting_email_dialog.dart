import 'package:alofo/functions/get_updated_validation_messages.dart';
import 'package:alofo/functions/get_validation_message.dart';
import 'package:alofo/http/requests.dart';
import 'package:alofo/models/models.dart';
import 'package:alofo/states/auth_dialog_state.dart';
import 'package:alofo/states/front_office_state.dart';
import 'package:alofo/widgets/auth_dialog/auth_dialog.dart';
import 'package:alofo/widgets/button/button.dart';
import 'package:alofo/widgets/input/password_input.dart';
import 'package:alofo/widgets/input/text_input.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

Map<String, String?> defaultValidationMessages = {
  'email': null,
  'password': null,
};

class SettingEmailDialog extends StatefulWidget {
  const SettingEmailDialog({super.key});

  @override
  State<SettingEmailDialog> createState() => _SettingEmailDialogState();
}

class _SettingEmailDialogState extends State<SettingEmailDialog> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  Map<String, String?>? validationMessages = defaultValidationMessages;
  FrontOfficeState frontOfficeState = Get.find<FrontOfficeState>();
  bool isLoading = false;

  @override
  void initState() {
    emailController.text = frontOfficeState.user?.email ?? '';
    super.initState();
  }

  bool get isValid =>
      emailController.text != frontOfficeState.user?.email &&
      emailController.text != '' &&
      passwordController.text != '' &&
      validationMessages == null;

  void onEmailChanged(value) {
    String? validationMessage = getValidationMessage('user.email', value);

    setState(() {
      validationMessages = getUpdatedValidationMessages(
        name: 'email',
        validationMessages: validationMessages,
        defaultValidationMessages: defaultValidationMessages,
        validationMessage: validationMessage,
      );
    });
  }

  void onPasswordChanged(value) {
    String? validationMessage = getValidationMessage('user.password', value);

    setState(() {
      validationMessages = getUpdatedValidationMessages(
        name: 'password',
        validationMessages: validationMessages,
        defaultValidationMessages: defaultValidationMessages,
        validationMessage: validationMessage,
      );
    });
  }

  void onSubmited() {
    if (!isValid) return;
    setState(() {
      isLoading = true;
    });

    updateUser({
          'email': emailController.text,
          'current_password': passwordController.text,
        })
        .then((response) {
          if (response.data?['user'] != null) {
            User user = User.fromJson(response.data!['user']);
            frontOfficeState.setUser(user);
          }

          Fluttertoast.showToast(msg: 'Email changed successfuly!');
          Future.delayed(Duration(seconds: 1), () {
            int? emailConfirmationIndex =
                authDialogMap['email_confirmation_code']?.index;

            if (mounted && emailConfirmationIndex != null) {
              showDialog(
                context: context,
                builder:
                    (authDialogContext) => AuthDialog(
                      defaultActive: emailConfirmationIndex,
                      onSuccess: () {
                        Navigator.of(authDialogContext).pop();
                        Future.delayed(Duration(seconds: 1), () {
                          if (mounted) Navigator.of(context).pop();
                        });

                        Fluttertoast.showToast(
                          msg: 'Email confirmed successfuly',
                        );
                      },
                    ),
                barrierDismissible: false,
              );
            }
          });
        })
        .catchError((error) {
          if (error is Map && error['errors'] != null) {
            setState(() {
              if (error['errors']['email']?[0] != null) {
                validationMessages = getUpdatedValidationMessages(
                  name: 'email',
                  validationMessages: validationMessages,
                  defaultValidationMessages: defaultValidationMessages,
                  validationMessage: error['errors']['email'][0],
                );
              }

              if (error['errors']['current_password']?[0] != null) {
                validationMessages = getUpdatedValidationMessages(
                  name: 'password',
                  validationMessages: validationMessages,
                  defaultValidationMessages: defaultValidationMessages,
                  validationMessage: error['errors']['current_password'][0],
                );
              }
            });
          } else {
            Fluttertoast.showToast(msg: error.toString());
          }
        })
        .whenComplete(() {
          setState(() {
            isLoading = false;
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      children: [
        TextInput(
          onChanged: onEmailChanged,
          label: 'email',
          controller: emailController,
          errorText: validationMessages?['email'],
        ),
        PasswordInput(
          onChanged: onPasswordChanged,
          controller: passwordController,
          errorText: validationMessages?['password'],
        ),
        Button(
          onPressed: isValid ? onSubmited : null,
          isLoading: isLoading,
          child: Text('Change Email'),
        ),
      ],
    );
  }
}
