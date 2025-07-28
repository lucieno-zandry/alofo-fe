import 'package:alofo/classes/local_storage.dart';
import 'package:alofo/functions/get_validation_message.dart';
import 'package:alofo/http/requests.dart';
import 'package:alofo/models/user.dart';
import 'package:alofo/states/front_office_state.dart';
import 'package:alofo/widgets/button/button.dart';
import 'package:alofo/widgets/input/text_input.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class InsertClientCodeDialog extends StatefulWidget {
  const InsertClientCodeDialog({super.key});

  @override
  State<InsertClientCodeDialog> createState() => _InsertClientCodeDialogState();
}

class _InsertClientCodeDialogState extends State<InsertClientCodeDialog> {
  String? errorText;
  FrontOfficeState state = Get.find<FrontOfficeState>();
  TextEditingController controller = TextEditingController();
  bool isLoading = false;

  void onChanged(value) {
    setState(() {
      errorText = getValidationMessage('client_code.code', value);
    });
  }

  void onSubmitted() {
    setState(() {
      isLoading = true;
    });

    if (state.user == null) {
      LocalStorage.saveItem('client_code', controller.text);

      Future.delayed(Duration(seconds: 1), () {
        if (mounted) {
          setState(() {
            isLoading = false;
          });
          Navigator.of(context).pop();
          Fluttertoast.showToast(msg: 'Client code saved.');
        }
      });
    } else {
      updateUser({'client_code': controller.text})
          .then((response) {
            if (response.data?['user'] != null) {
              User user = User.fromJson(response.data?['user']);
              state.setUser(user);
            }

            Fluttertoast.showToast(msg: 'You are now a special client!');
          })
          .catchError((error) {
            if (error is Map && error['errors']['client_code'] != null) {
              setState(() {
                errorText = error['errors']['client_code'][0];
              });
            }
          })
          .whenComplete(() {
            isLoading = false;
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        spacing: 15,
        children: [
          Text('Do you have a client code?'),
          TextInput(
            onChanged: onChanged,
            errorText: errorText,
            label: 'Client code',
          ),
          Button(
            variant: 'secondary',
            onPressed: onSubmitted,
            child: Text('Submit'),
          ),
        ],
      ),
    );
  }
}
