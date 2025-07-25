import 'package:alofo/classes/app_response.dart';
import 'package:alofo/classes/local_storage.dart';
import 'package:alofo/functions/debug.dart';
import 'package:alofo/functions/get_updated_validation_messages.dart';
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

  void updateForm({required String name, required String value}) {
    setState(() {
      form = {...form, name: value};
    });
  }

  void onPasswordChanged(String value) {
    String? validationMessage = getValidationMessage('user.password', value);

    setState(() {
      validationMessages = getUpdatedValidationMessages(
        name: 'password',
        validationMessage: validationMessage,
        defaultValidationMessages: defaultValidationMessages,
        validationMessages: validationMessages,
      );
    });

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

    setState(() {
      validationMessages = getUpdatedValidationMessages(
        name: 'email',
        validationMessage: validationMessage,
        defaultValidationMessages: defaultValidationMessages,
        validationMessages: validationMessages,
      );
    });

    updateForm(name: 'email', value: value);
  }

  @override
  Widget build(BuildContext context) {
    AuthDialogState state = Get.find<AuthDialogState>();
    FrontOfficeState frontOfficeState = Get.find<FrontOfficeState>();

    Future<Null> handleAuthentication({
      required Future<AppResponse> Function() authenticate,
      void Function()? onSuccess,
    }) {
      return authenticate()
          .then((response) async {
            if (response.data?['auth'] != null &&
                response.data?['token'] != null) {
              User user = User.fromJson(response.data!['auth']);
              frontOfficeState.setUser(user);

              await LocalStorage.saveItem(
                'authorization_token',
                response.data!['token'],
              );

              if (onSuccess != null) {
                onSuccess();
              }
            }
          })
          .onError((error, trace) {
            if (error is Map && error['errors'] != null) {
              if (error['errors']?['email'] != null) {
                setState(() {
                  validationMessages = getUpdatedValidationMessages(
                    name: 'email',
                    validationMessage: error['errors']!['email']![0],
                    defaultValidationMessages: defaultValidationMessages,
                    validationMessages: validationMessages,
                  );
                });
              }

              if (error['errors']?['password'] != null) {
                setState(() {
                  validationMessages = getUpdatedValidationMessages(
                    name: 'password',
                    validationMessage: error['errors']!['password']![0],
                    defaultValidationMessages: defaultValidationMessages,
                    validationMessages: validationMessages,
                  );
                });
              }
            } else if (context.mounted) {
              debug(context, error);
            }
          })
          .whenComplete(() {
            setState(() {
              isLoading = false;
            });
          });
    }

    Future<Null> onLoginSubmited() {
      return handleAuthentication(
        authenticate: () => logIn(form['email']!, form['password']!),
        onSuccess: () {
          if (context.mounted) {
            Navigator.of(context).pop();
          }
        },
      );
    }

    Future<Null> onRegisterSubmited() {
      String nextPage = 'email_confirmation_code';

      return handleAuthentication(
        authenticate: () => register(form['email']!),
        onSuccess: () {
          if (authDialogMap[nextPage] != null) {
            state.setActive(authDialogMap[nextPage]!.index);
          } else {
            Navigator.of(context).pop();
          }
        },
      );
    }

    void onCheckEmailSubmited() {
      getEmailInfo(form['email']!)
          .then((response) async {
            if (response.data != null &&
                response.data!['is_taken'] != null &&
                response.data!['is_taken'] == true) {
              setState(() {
                accountExists = true;
              });
            } else {
              await onRegisterSubmited();
            }
          })
          .onError((error, stackTrace) {
            if (error == null || error is! Map) return;
            if (error['message'] != null) {
              setState(() {
                validationMessages = getUpdatedValidationMessages(
                  name: 'email',
                  validationMessage: error['message'],
                  defaultValidationMessages: defaultValidationMessages,
                  validationMessages: validationMessages,
                );
              });
            } else if (context.mounted) {
              debug(context, error);
            }
          })
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
            if (accountExists)
              TextButton(
                onPressed: () {
                  int? passwordForgottenIndex =
                      authDialogMap['password_forgotten']?.index;

                  if (passwordForgottenIndex == null) return;
                  state.setActive(passwordForgottenIndex);
                },
                child: Text(
                  'Did you forget your password?',
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
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
