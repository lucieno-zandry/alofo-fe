import 'package:alofo/classes/local_storage.dart';
import 'package:alofo/http/requests.dart';
import 'package:alofo/models/models.dart';
import 'package:alofo/states/app_http_state.dart';
import 'package:alofo/states/auth_dialog_state.dart';
import 'package:alofo/states/front_office_state.dart';
import 'package:alofo/states/navbar_state.dart';
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
    super.initState();
    bool aPopUpIsActive = false;

    Get.put(FrontOfficeState(context: context));
    Get.put(AppHttpState(context: context));
    Get.put(NavbarState());

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Handle authentication
      LocalStorage.getItem<String>('authorization_token').then((token) {
        if (token == null) return;
        getAuthUser()
            .then((response) {
              if (response.data?['user'] != null) {
                var state = Get.find<FrontOfficeState>();
                var user = User.fromJson(response.data!['user']);

                LocalStorage.getItem<String>('client_code').then((clientCode) {
                  if (clientCode != "empty") {
                    LocalStorage.saveItem(
                      'client_code',
                      user.clientCodeId.toString(),
                    );
                  }
                });

                state.setUser(user);
              }
            })
            .catchError((error) {
              if (!mounted) return;
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) {
                  return AuthDialog();
                },
              );
            });
      });

      // Handle Password Reset
      var params = Uri.base.queryParameters;
      var action = params['action'];
      var type = params['type'];

      if (action != null && type != null) {
        if (type == 'auth') {
          int? targetIndex = authDialogMap[action]?.index;

          if (targetIndex != null) {
            aPopUpIsActive = true;
            Future.delayed(Duration(seconds: 2), () {
              if (!mounted) return;
              showDialog(
                context: context,
                builder:
                    (BuildContext context) =>
                        AuthDialog(defaultActive: targetIndex),
              );
            });
          }
        }
      }

      if (!aPopUpIsActive) {
        // Handle client code
        LocalStorage.getItem<String>('client_code').then((clientCode) {
          if (clientCode == null) {
            int? defaultActiveIndex =
                authDialogMap['insert_client_code']?.index;
            if (defaultActiveIndex == null) return;

            Future.delayed(Duration(seconds: 2), () {
              if (mounted) {
                showDialog(
                  context: context,
                  builder:
                      (BuildContext context) =>
                          AuthDialog(defaultActive: defaultActiveIndex),
                );
              }
            });
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: NavbarDrawer(
        topActions: leftActions(context),
        bottomActions: rightActions(context),
      ),
      body: Stack(children: [widget.child, Navbar()]),
    );
  }
}
