import 'package:alofo/classes/local_storage.dart';
import 'package:alofo/functions/get_validation_message.dart';
import 'package:alofo/http/requests.dart';
import 'package:alofo/models/user.dart';
import 'package:alofo/states/auth_dialog_state.dart';
import 'package:alofo/states/front_office_state.dart';
import 'package:alofo/widgets/auth_dialog/auth_dialog.dart';
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
  bool get isValid => errorText == null && controller.text != '';
  bool userIsNotInterested = true;

  void onChanged(value) {
    setState(() {
      errorText = getValidationMessage('client_code.code', value);
    });
  }

  void handleRequest(Future<Null> Function() request) {
    request()
        .catchError((error) {
          if (error is Map && error['errors']['client_code'] != null) {
            setState(() {
              errorText = error['errors']['client_code'][0];
            });
          }
        })
        .whenComplete(() {
          LocalStorage.saveItem('client_code', controller.text);

          setState(() {
            isLoading = false;
          });
        });
  }

  void onSubmitted() {
    if (!isValid) return;

    setState(() {
      isLoading = true;
      userIsNotInterested = false;
    });

    if (state.user == null) {
      handleRequest(
        () => checkClientCodeUsability(controller.text).then((response) {
          Fluttertoast.showToast(msg: 'Client code saved.');

          if (mounted) {
            Navigator.of(context).pop();

            int? targetIndex = authDialogMap['login']?.index;
            if (targetIndex == null) return;

            Future.delayed(Duration(seconds: 500), () {
              if (!state.context.mounted) return;
              showDialog(
                context: state.context,
                builder: (context) => AuthDialog(defaultActive: targetIndex),
              );
            });
          }
        }),
      );
    } else {
      handleRequest(
        () => updateUser({'client_code': controller.text}).then((response) {
          if (response.data?['user'] != null) {
            User user = User.fromJson(response.data?['user']);
            state.setUser(user);
          }

          if (mounted) {
            Navigator.of(context).pop();
          }

          Fluttertoast.showToast(msg: 'You are now a special client!');
        }),
      );
    }
  }

  @override
  void dispose() {
    if (userIsNotInterested) {
      LocalStorage.saveItem('client_code', 'empty');
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        spacing: 15,
        children: [
          TextInput(
            onChanged: onChanged,
            errorText: errorText,
            label: 'Client code',
            controller: controller,
          ),
          Button(
            variant: 'secondary',
            onPressed: isValid ? onSubmitted : null,
            isLoading: isLoading,
            child: Text('Submit'),
          ),
        ],
      ),
    );
  }
}
