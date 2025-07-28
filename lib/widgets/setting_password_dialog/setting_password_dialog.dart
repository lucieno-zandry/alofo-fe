import 'package:alofo/functions/get_updated_validation_messages.dart';
import 'package:alofo/functions/get_validation_message.dart';
import 'package:alofo/http/requests.dart';
import 'package:alofo/widgets/button/button.dart';
import 'package:alofo/widgets/input/password_input.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Map<String, String?> defaultValidationMessages = const {
  'current_password': null,
  'new_password': null,
  'password_confirmation': null,
};

class SettingPasswordDialog extends StatefulWidget {
  const SettingPasswordDialog({super.key});

  @override
  State<SettingPasswordDialog> createState() => _SettingPasswordDialogState();
}

class _SettingPasswordDialogState extends State<SettingPasswordDialog> {
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController passwordConfirmationController =
      TextEditingController();

  Map<String, String?>? validationMessages = {...defaultValidationMessages};

  bool get isValid =>
      currentPasswordController.text != '' &&
      newPasswordController.text != '' &&
      passwordConfirmationController.text != '' &&
      validationMessages == null;

  bool isLoading = false;

  String? getPasswordConfirmationValidationMessage(String value) {
    String? validationMessage;

    if (value != newPasswordController.text) {
      validationMessage = "The password confirmation does not match";
    }

    return validationMessage;
  }

  void onNewPasswordChanged(value) {
    String? validationMessage = getValidationMessage('user.password', value);

    if (value == currentPasswordController.text) {
      validationMessage = 'Choose a different password!';
    } else if (passwordConfirmationController.text != '') {
      // Password confirmation and the new password should be synchronized
      validationMessages = getUpdatedValidationMessages(
        name: 'password_confirmation',
        validationMessages: validationMessages,
        defaultValidationMessages: defaultValidationMessages,
        validationMessage: getPasswordConfirmationValidationMessage(
          passwordConfirmationController.text,
        ),
      );
    }

    setState(() {
      validationMessages = getUpdatedValidationMessages(
        name: 'new_password',
        validationMessages: validationMessages,
        defaultValidationMessages: defaultValidationMessages,
        validationMessage: validationMessage,
      );
    });
  }

  void onPasswordConfirmationChanged(value) {
    String? validationMessage = getPasswordConfirmationValidationMessage(value);

    setState(() {
      validationMessages = getUpdatedValidationMessages(
        name: 'password_confirmation',
        validationMessages: validationMessages,
        defaultValidationMessages: defaultValidationMessages,
        validationMessage: validationMessage,
      );
    });
  }

  void onCurrentPasswordChanged(value) {
    String? validationMessage = getValidationMessage('user.password', value);

    setState(() {
      validationMessages = getUpdatedValidationMessages(
        name: 'current_password',
        validationMessages: validationMessages,
        defaultValidationMessages: defaultValidationMessages,
        validationMessage: validationMessage,
      );
    });
  }

  void onSubmitted() {
    if (!isValid) return;
    setState(() {
      isLoading = true;
    });

    updateUser({
          'current_password': currentPasswordController.text,
          'password': newPasswordController.text,
          'password_confirmation': passwordConfirmationController.text,
        })
        .then((_) {
          Fluttertoast.showToast(msg: 'Password updated successfully');
          if (mounted) Navigator.of(context).pop();
        })
        .catchError((error) {
          if (error is Map && error['errors'] != null) {
            Map<String, String?>? newValidationMessages = {
              ...defaultValidationMessages,
            };

            if (error['errors']['password'] != null) {
              newValidationMessages = getUpdatedValidationMessages(
                name: 'new_password',
                validationMessages: newValidationMessages,
                defaultValidationMessages: defaultValidationMessages,
                validationMessage: error['errors']['password'][0],
              );
            }

            if (error['errors']['current_password'] != null) {
              newValidationMessages = getUpdatedValidationMessages(
                name: 'current_password',
                validationMessages: newValidationMessages,
                defaultValidationMessages: defaultValidationMessages,
                validationMessage: error['errors']['current_password'][0],
              );
            }

            if (error['errors']['password_confirmation'] != null) {
              newValidationMessages = getUpdatedValidationMessages(
                name: 'password_confirmation',
                validationMessages: newValidationMessages,
                defaultValidationMessages: defaultValidationMessages,
                validationMessage: error['errors']['password_confirmation'][0],
              );
            }

            setState(() {
              validationMessages = newValidationMessages;
            });
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
        PasswordInput(
          onChanged: onCurrentPasswordChanged,
          label: 'Current password',
          controller: currentPasswordController,
          errorText: validationMessages?['current_password'],
        ),
        PasswordInput(
          onChanged: onNewPasswordChanged,
          label: 'New password',
          controller: newPasswordController,
          errorText: validationMessages?['new_password'],
        ),
        PasswordInput(
          onChanged: onPasswordConfirmationChanged,
          label: 'Password confirmation',
          controller: passwordConfirmationController,
          errorText: validationMessages?['password_confirmation'],
        ),
        Button(
          onPressed: isValid ? onSubmitted : null,
          isLoading: isLoading,
          child: Text('Update password'),
        ),
      ],
    );
  }
}
