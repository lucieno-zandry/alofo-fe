import 'package:alofo/classes/local_storage.dart';
import 'package:alofo/classes/pages_uris.dart';
import 'package:alofo/states/front_office_state.dart';
import 'package:alofo/widgets/button/button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    var state = Get.find<FrontOfficeState>();

    return AlertDialog(
      title: Text('You are about to be logged out!'),
      actions: [
        Button(
          variant: 'danger',
          onPressed: () {
            state.setUser(null);
            LocalStorage.removeItem('authorization_token');
            LocalStorage.removeItem('client_code');
            context.go(PagesUris.homePage);
            Navigator.of(context).pop();
          },
          child: Text('Log out'),
        ),
      ],
      shape: Border.all(style: BorderStyle.none),
    );
  }
}
