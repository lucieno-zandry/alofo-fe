import 'package:alofo/classes/auth_dialog_item.dart';
import 'package:alofo/classes/screen.dart';
import 'package:alofo/states/auth_dialog_state.dart';
import 'package:alofo/widgets/page_selector/page_selector.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthDialog extends StatefulWidget {
  const AuthDialog({super.key, this.defaultActive = 0});

  final int defaultActive;

  @override
  State<AuthDialog> createState() => _AuthDialogState();
}

class _AuthDialogState extends State<AuthDialog> {
  @override
  void initState() {
    Get.put(AuthDialogState(active: widget.defaultActive));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    var authDialogList = authDialogMap.values;

      return AlertDialog(
      title: Text('Login / Register', textAlign: TextAlign.center),
      shape: Border.all(style: BorderStyle.none),

      content: SingleChildScrollView(
        child: SizedBox(
          width: Screen.responsive(
            width: screenWidth,
            standard: Screen.clamp(
              200,
              Screen.percentageOf(screenWidth, 50),
              400,
            ),
          ),
          child: GetBuilder<AuthDialogState>(
            builder: (state) {
              return PageSelector(
                active: state.active,
                children:
                    authDialogList
                        .map((authDialogItem) => authDialogItem.widget)
                        .toList(),
              );
            },
          ),
        ),
      ),
      actions: [
        GetBuilder<AuthDialogState>(
          builder: (state) {
            AuthDialogItem currentAuthDialogItem = authDialogList.firstWhere(
              (authDialogItem) => authDialogItem.index == state.active,
            );

            return Row(
              spacing: 10,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (state.history.length > 1)
                  TextButton(
                    onPressed: () {
                      state.previous();
                    },
                    child: Row(
                      spacing: 5,
                      children: [Icon(Icons.arrow_back), Text('Back')],
                    ),
                  ),
                if (!currentAuthDialogItem.isMandatory)
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text('Close'),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }
}
