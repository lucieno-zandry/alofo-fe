import 'package:alofo/states/navbar_state.dart';
import 'package:alofo/widgets/nav_link.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavLinkItems extends StatelessWidget {
  const NavLinkItems({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NavbarState>(
      builder: (navbarState) {
        return Row(
          spacing: 20,
          children: [
            if (navbarState.categories != null)
              for (var category in navbarState.categories!)
                NavLink(
                  href: '/products/${category.id!}',
                  child: Text(category.title!.toUpperCase()),
                ),
          ],
        );
      },
    );
  }
}
