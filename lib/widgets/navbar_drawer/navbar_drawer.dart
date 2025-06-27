import 'package:alofo/widgets/nav_link.dart';
import 'package:alofo/types/nav_link_data.dart';
import 'package:flutter/material.dart';

class NavbarDrawer extends StatelessWidget {
  const NavbarDrawer({
    super.key,
    required this.topActions,
    required this.bottomActions,
  });

  final List<NavLinkData> topActions;
  final List<Widget> bottomActions;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.only(top: 50),
        child: ListView(
          children: [
            Column(
              children: [
                for (NavLinkData navLinkData in topActions)
                  NavLink(navLinkData: navLinkData),
                SizedBox(height: 50),
                for (Widget navLink in bottomActions) navLink,
              ],
            ),
          ],
        ),
      ),
    );
  }
}
