import 'package:alofo/classes/setting_row.dart';
import 'package:alofo/states/front_office_state.dart';
import 'package:alofo/widgets/setting_email_dialog/setting_email_dialog.dart';
import 'package:alofo/widgets/setting_name_dialog.dart';
import 'package:alofo/widgets/setting_password_dialog/setting_password_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddressesPage extends StatelessWidget {
  const AddressesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FrontOfficeState>(
      builder: (state) {
        return SingleChildScrollView(
          child: Column(
            spacing: 10,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('General', style: Theme.of(context).textTheme.titleSmall),
              SettingRow(
                title: 'Email address',
                dialogContent: SettingEmailDialog(),
                dialogTitle: 'Change your email',
                value: state.user?.email,
              ),
              SettingRow(
                title: 'Password',
                dialogTitle: 'Change your password',
                dialogContent: SettingPasswordDialog(),
              ),
              SettingRow(
                title: 'Name',
                dialogTitle: 'Change your name',
                value: state.user?.name,
                dialogContent: SettingNameDialog(),
              ),
            ],
          ),
        );
      },
    );
  }
}
