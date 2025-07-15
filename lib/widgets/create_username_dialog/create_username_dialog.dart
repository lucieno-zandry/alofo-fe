import 'package:alofo/functions/get_validation_message.dart';
import 'package:alofo/http/requests.dart';
import 'package:alofo/models/models.dart';
import 'package:alofo/states/auth_dialog_state.dart';
import 'package:alofo/states/front_office_state.dart';
import 'package:alofo/widgets/button/button.dart';
import 'package:alofo/widgets/input/text_input.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateUsernameDialog extends StatefulWidget {
  const CreateUsernameDialog({super.key});

  @override
  State<CreateUsernameDialog> createState() => _CreateUsernameDialogState();
}

class _CreateUsernameDialogState extends State<CreateUsernameDialog> {
  String? errorText;
  final controller = TextEditingController();

  bool get isValid => controller.text != '' && errorText == null;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void onChanged(String value) {
    String? validationMessage = getValidationMessage('user.name', value);
    if (errorText == validationMessage) return;

    setState(() {
      errorText = validationMessage;
    });
  }

  @override
  Widget build(BuildContext context) {
    AuthDialogState state = Get.find<AuthDialogState>();
    FrontOfficeState frontOfficeState = Get.find<FrontOfficeState>();
    bool isLoading = false;

    void onSubmited() {
      if (!isValid || frontOfficeState.user == null) return;
      setState(() {
        isLoading = true;
      });

      var user = frontOfficeState.user!;
      user.name = controller.text;

      updateUser(user)
          .then((response) {
            if (response['data']?['user'] != null) {
              var newUser = User.fromJson(response['data']['user']);
              frontOfficeState.setUser(newUser);
            }
          })
          .catchError((error) {})
          .whenComplete(() {
            setState(() {
              isLoading = false;
            });
          });

      state.setActive(++state.active);
    }

    return Column(
      spacing: 10,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Create an username',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        TextInput(
          onChanged: onChanged,
          label: 'username',
          errorText: errorText,
          controller: controller,
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
