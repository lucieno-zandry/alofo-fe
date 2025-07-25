import 'package:alofo/functions/get_validation_message.dart';
import 'package:alofo/http/requests.dart';
import 'package:alofo/models/models.dart';
import 'package:alofo/states/auth_dialog_state.dart';
import 'package:alofo/states/front_office_state.dart';
import 'package:alofo/widgets/button/button.dart';
import 'package:alofo/widgets/input/text_input.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class CreateUsernameDialog extends StatefulWidget {
  const CreateUsernameDialog({super.key});

  @override
  State<CreateUsernameDialog> createState() => _CreateUsernameDialogState();
}

class _CreateUsernameDialogState extends State<CreateUsernameDialog> {
  String? errorText;
  final controller = TextEditingController();
  bool isLoading = false;

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

    void onSubmited() {
      if (!isValid || frontOfficeState.user == null) return;
      var user = frontOfficeState.user!;
      user.name = controller.text;

      setState(() {
        isLoading = true;
      });

      updateUser({'name': user.name})
          .then((response) {
            if (response.data?['user'] != null) {
              var newUser = User.fromJson(response.data!['user']);
              frontOfficeState.setUser(newUser);
              state.setActive(++state.active);
            }
          })
          .catchError((error) {
            if (error is Map && error['message'] != null) {
              setState(() {
                errorText = error['message'];
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
          child: Text('CONTINUE'),
        ),
      ],
    );
  }
}
