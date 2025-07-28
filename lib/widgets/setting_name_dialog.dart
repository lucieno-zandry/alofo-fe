import 'package:alofo/functions/get_validation_message.dart';
import 'package:alofo/http/requests.dart';
import 'package:alofo/models/models.dart';
import 'package:alofo/states/front_office_state.dart';
import 'package:alofo/widgets/button/button.dart';
import 'package:alofo/widgets/input/text_input.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class SettingNameDialog extends StatefulWidget {
  const SettingNameDialog({super.key});

  @override
  State<SettingNameDialog> createState() => _SettingNameDialogState();
}

class _SettingNameDialogState extends State<SettingNameDialog> {
  TextEditingController controller = TextEditingController();
  String? errorText;
  bool isLoading = false;
  bool get isValid => controller.text != '' && errorText == null;
  FrontOfficeState state = Get.find<FrontOfficeState>();

  @override
  void initState() {
    if (state.user?.name != null) {
      controller.text = state.user!.name!;
    }
    super.initState();
  }

  void onChanged(String value) {
    setState(() {
      errorText = getValidationMessage('user.name', value);
    });
  }

  void onSubmitted() {
    if (!isValid) return;

    setState(() {
      isLoading = true;
    });

    updateUser({'name': controller.text})
        .then((response) {
          if (response.data?['user'] != null) {
            User user = User.fromJson(response.data!['user']);
            state.setUser(user);
          }

          Fluttertoast.showToast(msg: 'Name updated successfuly');
          if (mounted) Navigator.of(context).pop();
        })
        .catchError((error) {
          if (error is Map && error['errors']?['name'] != null) {
            setState(() {
              errorText = error['errors']['name'];
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
      spacing: 15,
      children: [
        TextInput(
          onChanged: onChanged,
          label: 'name',
          controller: controller,
          errorText: errorText,
        ),
        Button(
          isLoading: isLoading,
          onPressed: isValid ? onSubmitted : null,
          child: Text('Change name'),
        ),
      ],
    );
  }
}
