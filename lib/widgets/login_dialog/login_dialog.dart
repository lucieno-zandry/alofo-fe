import 'package:alofo/functions/debug.dart';
import 'package:alofo/functions/get_validation_message.dart';
import 'package:alofo/http/requests.dart';
import 'package:alofo/models/models.dart';
import 'package:alofo/states/auth_dialog_state.dart';
import 'package:alofo/states/front_office_state.dart';
import 'package:alofo/widgets/button/button.dart';
import 'package:alofo/widgets/input/password_input.dart';
import 'package:alofo/widgets/input/text_input.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
    AuthDialogState state = Get.find<AuthDialogState>();
    FrontOfficeState frontOfficeState = Get.find<FrontOfficeState>();

    void onLoginSubmited() {
      logIn(form['email']!, form['password']!)
          .then((response) {
            if (response['errors'] != null) {
              if (response['errors']?['email'] != null) {
                updateValidationMessages(
                  name: 'email',
                  validationMessage: response['errors']!['email']![0],
                );
              }

              if (response['errors']?['password'] != null) {
                updateValidationMessages(
                  name: 'password',
                  validationMessage: response['errors']!['password']![0],
                );
              }
            } else if (response['data'] != null) {
              if (response['data']!['user'] != null) {
                User user = User.fromJson(response['data']!['user']!);
                // user is an instance of 'User' here, so it works
                frontOfficeState.setUser(user);

                if (context.mounted) {
                  Navigator.of(context).pop();
                }
                // close the current dialog here
              }
            }
          })
          .onError((error, trace) {
            if (context.mounted) {
              debug(context, error);
            }
          })
          .whenComplete(() {
            setState(() {
              isLoading = false;
            });
          });
    }

    void onCheckEmailSubmited() {
      getEmailInfo(form['email']!)
          .then((response) {
            if (response['is_taken']!) {
              setState(() {
                accountExists = true;
              });
            } else {
              state.setActive(++state.active);
            }
          })
          .onError((error, stackTrace) {})
          .whenComplete(() {
            setState(() {
              isLoading = false;
            });
          });
    }

    void onSubmited() {
      setState(() {
        isLoading = true;
        validationMessages = defaultValidationMessages;
      });

      accountExists ? onLoginSubmited() : onCheckEmailSubmited();
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
