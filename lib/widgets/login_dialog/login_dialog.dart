import 'package:alofo/functions/get_validation_message.dart';
import 'package:alofo/http/requests.dart';
import 'package:alofo/widgets/auth_dialog/auth_dialog.dart';
import 'package:alofo/widgets/button/button.dart';
import 'package:alofo/widgets/input/password_input.dart';
import 'package:alofo/widgets/input/text_input.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Map<String, String?> defaultValidationMessages = {
  'email': null,
  'password': null,
};

Map<String, String> defaultForm = {'email': '', 'password': ''};

class LoginDialog extends StatefulWidget {
  const LoginDialog({super.key});

  @override
  State<LoginDialog> createState() => _LoginDialogState();
}

class _LoginDialogState extends State<LoginDialog> {
  Map<String, String?>? validationMessages = defaultValidationMessages;

  bool accountExists = false;

  bool get buttonIsDisabled => validationMessages != null;

  bool isLoading = false;

  Map<String, String> form = defaultForm;

  void updateValidationMessages({
    required String name,
    String? validationMessage,
  }) {
    setState(() {
      if (validationMessages == null) {
        if (validationMessage != null) {
          validationMessages = {
            ...defaultValidationMessages,
            name: validationMessage,
          };
        }
      } else {
        var newValidationMessages = validationMessages;
        newValidationMessages![name] = validationMessage;

        bool newValidationMessagesisEmpty = newValidationMessages.entries.every(
          (validation) {
            return validation.value == null;
          },
        );

        validationMessages =
            newValidationMessagesisEmpty ? null : newValidationMessages;
      }
    });
  }

  void updateForm({required String name, required String value}) {
    setState(() {
      form = {...form, name: value};
    });
  }

  void onPasswordChanged(String value) {
    String? validationMessage = getValidationMessage('user.password', value);

    updateValidationMessages(
      name: 'password',
      validationMessage: validationMessage,
    );

    updateForm(name: 'password', value: value);
  }

  void onEmailChanged(String value) {
    String? validationMessage = getValidationMessage('user.email', value);

    setState(() {
      accountExists = false;
      if (validationMessages?['password'] != null) {
        validationMessages = defaultValidationMessages;
      }
    });

    updateValidationMessages(
      name: 'email',
      validationMessage: validationMessage,
    );

    updateForm(name: 'email', value: value);
  }

  @override
  Widget build(BuildContext context) {
    AuthDialogState state = context.watch<AuthDialogState>();

    void onSubmited() {
      setState(() {
        isLoading = true;
        validationMessages = defaultValidationMessages;
      });

      getEmailInfo(form['email']!)
          .then((response) {
            if (response['is_taken']!) {
              setState(() {
                accountExists = true;
              });
            } else {
              state.setActive(1);
            }
          })
          .onError((error, stackTrace) {})
          .whenComplete(() {
            setState(() {
              isLoading = false;
            });
          });
    }

    return LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            spacing: 20,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextInput(
                onChanged: onEmailChanged,
                label: "Email",
                errorText: validationMessages?['email'],
              ),
              if (accountExists)
                PasswordInput(
                  onChanged: onPasswordChanged,
                  label: "Password",
                  errorText: validationMessages?['password'],
                ),
              SizedBox(
                width: constraints.maxWidth,
                child: Button(
                  onPressed: buttonIsDisabled ? null : onSubmited,
                  variant: 'primary',
                  isLoading: isLoading,
                  child: Text('CONTINUE'),
                ),
              ),
            ],
          );
        },
      );
  }
}
