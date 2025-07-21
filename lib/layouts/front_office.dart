import 'package:alofo/states/front_office_state.dart';
import 'package:alofo/widgets/auth_dialog/auth_dialog.dart';
import 'package:alofo/widgets/navbar/navbar.dart';
import 'package:alofo/widgets/navbar_drawer/navbar_drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FrontOffice extends StatefulWidget {
  const FrontOffice({super.key, required this.child});
  final Widget child;

  @override
  State<FrontOffice> createState() => _FrontOfficeState();
}

class _FrontOfficeState extends State<FrontOffice> {
  @override
  void initState() {
    var params = Get.parameters;
    var action = params['action'];
    var type = params['type'];

    if (action != null && type != null) {
      if (type == 'auth') {
        int? targetIndex = authDialogMap[action];

        if (targetIndex != null) {
          showDialog(
            context: context,
            builder: (context) {
              return AuthDialog(defaultActive: targetIndex);
            },
          );
        }
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Get.put(FrontOfficeState());

    return Scaffold(
      endDrawer: NavbarDrawer(
        topActions: leftActions(context),
        bottomActions: rightActions(context),
      ),
      body: Stack(children: [widget.child, Navbar()]),
    );
  }
}
