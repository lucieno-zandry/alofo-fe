import 'package:alofo/classes/pages_uris.dart';
import 'package:alofo/states/settings_navbar_state.dart';
import 'package:alofo/widgets/app_container.dart';
import 'package:alofo/widgets/nav_link.dart';
import 'package:alofo/widgets/settings_navbar/settings_navbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Settings extends StatefulWidget {
  const Settings({super.key, required this.child});

  final Widget child;

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  void initState() {
    Get.put(SettingsNavbarState());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      margin: EdgeInsets.only(top: 150),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return AppContainer(
            child: ListView(
              children: [
                SettingsNavbar(
                  navLinks: [
                    NavLink(
                      href: PagesUris.settingsPage,
                      child: Text('Account'),
                    ),
                    NavLink(
                      href: PagesUris.addressesSettings,
                      child: Text('Shipping Addresses'),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                widget.child,
              ],
            ),
          );
        },
      ),
    );
  }
}
