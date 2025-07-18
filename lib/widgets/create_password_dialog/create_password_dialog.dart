import 'package:alofo/functions/get_validation_message.dart';
import 'package:alofo/http/requests.dart';
import 'package:alofo/models/models.dart';
import 'package:alofo/states/front_office_state.dart';
import 'package:alofo/widgets/button/button.dart';
import 'package:alofo/widgets/input/password_input.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreatePasswordDialog extends StatefulWidget {
  const CreatePasswordDialog({super.key});

  @override
  State<CreatePasswordDialog> createState() => _CreatePasswordDialogState();
}

class _CreatePasswordDialogState extends State<CreatePasswordDialog> {
  String? errorText;
  final controller = TextEditingController();
  final passwordConfirmController = TextEditingController();

  bool get isValid =>
      controller.text != '' &&
      passwordConfirmController.text != '' &&
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

    void onSubmited() {
      if (!isValid || frontOfficeState.user == null) return;
      var user = frontOfficeState.user!;
      user.password = controller.text;

      setState(() {
        isLoading = true;
      });

      updateUser({'password': user.password})
          .then((response) {
            if (response.data?['user'] != null) {
              var newUser = User.fromJson(response.data!['user']);
              frontOfficeState.setUser(newUser);

              if (context.mounted) {
                Navigator.of(context).pop();
              }
            }
          })
          .catchError((error) {})
          .whenComplete(() {
            setState(() {
              isLoading = true;
            });
          });
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
          controller: passwordConfirmController,
        ),
        Button(
          onPressed: isValid ? onSubmited : null,
          isLoading: isLoading,
          child: Text('Continue'),
        ),
      ],
    );
  }
}
