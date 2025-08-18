import 'package:alofo/classes/local_storage.dart';
import 'package:alofo/functions/get_validation_message.dart';
import 'package:alofo/http/requests.dart';
import 'package:alofo/models/models.dart';
import 'package:alofo/states/auth_dialog_state.dart';
import 'package:alofo/states/front_office_state.dart';
import 'package:alofo/widgets/button/button.dart';
import 'package:alofo/widgets/input/password_input.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class CreatePasswordDialog extends StatefulWidget {
  const CreatePasswordDialog({super.key});

  @override
  State<CreatePasswordDialog> createState() => _CreatePasswordDialogState();
}

class _CreatePasswordDialogState extends State<CreatePasswordDialog> {
  String? errorText;
  final controller = TextEditingController();
  final passwordConfirmationController = TextEditingController();

  bool get isValid =>
      controller.text != '' &&
      passwordConfirmationController.text != '' &&
      errorText == null;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void onChanged(String value) {
    String? validationMessage = getValidationMessage('user.password', value);
    if (errorText == validationMessage) return;

    setState(() {
      errorText = validationMessage;
    });
  }

  void onPasswordConfirmChanged(String value) {
    setState(() {
      if (controller.text != value) {
        errorText = "The passwords don't match";
      } else if (errorText != null) {
        errorText = null;
      }
    });
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    FrontOfficeState frontOfficeState = Get.find<FrontOfficeState>();
    AuthDialogState authDialogState = Get.find<AuthDialogState>();

    void handleHttpAction(Future<Null> Function() httpAction) {
      httpAction()
          .catchError((error) {
            if (error is Map) {
              if (error['errors']?['password'] != null) {
                setState(() {
                  errorText = error['errors']['password'][0];
                });
              } else if (error['message'] != null) {
                Fluttertoast.showToast(msg: error['message']);
              }
            } else {
              Fluttertoast.showToast(
                msg: error.toString(),
                gravity: ToastGravity.TOP_RIGHT,
              );
            }
          })
          .whenComplete(() {
            setState(() {
              isLoading = false;
            });
          });
    }

    Future<Null> onPasswordReset() {
      return resetPassword(
        password: controller.text,
        token: Uri.base.queryParameters['token']!,
        passwordConfirmation: passwordConfirmationController.text,
      ).then((response) {
        if (response.data?['token'] != null && response.data?['auth'] != null) {
          LocalStorage.saveItem('authorization_token', response.data!['token']);
          var newUser = User.fromJson(response.data!['auth']);
          frontOfficeState.setUser(newUser);
        } else {
          Fluttertoast.showToast(
            msg: 'Password reset successful, log in to reconnect',
          );
        }

        Uri.base.resolve('/');

        if (context.mounted) {
          Navigator.of(context).pop();
        }
      });
    }

    Future<Null> onPasswordCreated() {
      return updateUser({
        'password': controller.text,
        'password_confirmation': passwordConfirmationController.text,
        'current_password': '000000',
      }).then((response) async {
        String? clientCode = await LocalStorage.getItem<String>('client_code');

        if (clientCode == null || clientCode == 'empty') {
          int? nextIndex = authDialogMap['insert_client_code']?.index;

          if (nextIndex != null) {
            authDialogState.setActive(nextIndex);
          }
        } else if (context.mounted) {
          Navigator.of(context).pop();
        }
      });
    }

    void onSubmitted() {
      if (!isValid) return;

      String? token = Uri.base.queryParameters['token'];

      setState(() {
        isLoading = true;
      });

      if (frontOfficeState.user != null) {
        handleHttpAction(onPasswordCreated);
      } else if (token != null) {
        handleHttpAction(onPasswordReset);
      }
    }

    return Column(
      spacing: 10,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Create a password',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        PasswordInput(
          onChanged: onChanged,
          label: 'New password',
          controller: controller,
          errorText: errorText,
        ),
        PasswordInput(
          onChanged: onPasswordConfirmChanged,
          label: 'Confirm password',
          controller: passwordConfirmationController,
        ),
        Button(
          onPressed: isValid ? onSubmitted : null,
          isLoading: isLoading,
          child: Text('Continue'),
        ),
      ],
    );
  }
}
