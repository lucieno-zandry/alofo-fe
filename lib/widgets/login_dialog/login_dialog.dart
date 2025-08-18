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
  'client_code': null,
};

class LoginDialog extends StatefulWidget {
  const LoginDialog({super.key});

  @override
  State<LoginDialog> createState() => _LoginDialogState();
}

class _LoginDialogState extends State<LoginDialog> {
  Map<String, String?>? validationMessages = {...defaultValidationMessages};
  TextEditingController clientCodeController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool accountExists = false;

  bool get buttonIsDisabled => validationMessages != null;

  bool isLoading = false;

  bool clientCodeFieldIsVisible = false;

  @override
  void initState() {
    LocalStorage.getItem<String>('client_code').then((clientCode) {
      if (clientCode == null) return;
      clientCodeController.text = clientCode;
    });

    super.initState();
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
  }

  void onEmailChanged(String value) {
    String? validationMessage = getValidationMessage('user.email', value);

    setState(() {
      accountExists = false;
      if (validationMessages?['password'] != null) {
        validationMessages = {...defaultValidationMessages};
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
          .then((response) {
            if (response.data?['auth'] != null &&
                response.data?['token'] != null) {
              User user = User.fromJson(response.data!['auth']);
              frontOfficeState.setUser(user);

              LocalStorage.saveItem(
                'authorization_token',
                response.data!['token'],
              );

              LocalStorage.getItem<String>('client_code').then((clientCode) {
                if (clientCode != "empty") {
                  LocalStorage.saveItem(
                    'client_code',
                    user.clientCodeId.toString(),
                  );
                }
              });

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

              if (error['errors']?['client_code'] != null) {
                setState(() {
                  validationMessages = getUpdatedValidationMessages(
                    name: 'client_code',
                    validationMessage: error['errors']!['client_code']![0],
                    defaultValidationMessages: defaultValidationMessages,
                    validationMessages: validationMessages,
                  );

                  if (!clientCodeFieldIsVisible) {
                    clientCodeFieldIsVisible = true;
                  }
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
        authenticate:
            () => logIn(emailController.text, passwordController.text),
        onSuccess: () {
          if (context.mounted) {
            Navigator.of(context).pop();
          }
        },
      );
    }

    Future<Null> onRegisterSubmited() async {
      String nextPage = 'email_confirmation_code';

      var data = {'email': emailController.text, 'name': 'New User'};
      String? clientCode = await LocalStorage.getItem<String>('client_code');

      if (clientCode != null) {
        data['client_code'] = clientCode;
      }

      return handleAuthentication(
        authenticate: () => register(data),
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
      getEmailInfo(emailController.text)
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

    void onClientCodeChanged(String value) {
      String? validationMessage = getValidationMessage(
        'client_code.code',
        value,
      );

      setState(() {
        validationMessages = getUpdatedValidationMessages(
          name: 'client_code',
          validationMessages: validationMessages,
          defaultValidationMessages: defaultValidationMessages,
          validationMessage: validationMessage,
        );
      });
    }

    void onSubmitted() {
      setState(() {
        isLoading = true;
        validationMessages = {...defaultValidationMessages};
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
              controller: emailController,
            ),
            if (accountExists)
              PasswordInput(
                onChanged: onPasswordChanged,
                label: "Password",
                errorText: validationMessages?['password'],
                controller: passwordController,
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
            if (clientCodeFieldIsVisible)
              TextInput(
                onChanged: onClientCodeChanged,
                label: 'Client code',
                controller: clientCodeController,
                errorText: validationMessages?['client_code'],
              ),
            SizedBox(
              width: constraints.maxWidth,
              child: Button(
                onPressed: buttonIsDisabled ? null : onSubmitted,
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
