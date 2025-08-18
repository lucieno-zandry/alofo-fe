import 'package:alofo/states/navbar_state.dart';
import 'package:alofo/types/nav_link_data.dart';
import 'package:alofo/widgets/nav_link.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
    return GetBuilder<NavbarState>(
      builder: (navbarState) {
        return Drawer(
          child: Padding(
            padding: const EdgeInsets.only(top: 50),
            child: ListView(
              children: [
                Column(
                  children: [
                    if (navbarState.categories != null)
                      Column(
                        spacing: 10,
                        children: [
                          for (var category in navbarState.categories!)
                            NavLink(
                              href: '/products/${category.id}',
                              child: Text(category.title!),
                            ),
                        ],
                      ),
                    SizedBox(height: 50),
                    Column(
                      spacing: 10,
                      children: [for (Widget navLink in bottomActions) navLink],
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
