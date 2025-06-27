import 'package:alofo/types/nav_link_data.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NavLink extends StatelessWidget {
  final NavLinkData navLinkData;
  const NavLink({super.key, required this.navLinkData});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        context.go(navLinkData.href);
      },
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.all(
          DefaultTextStyle.of(context).style.color, // Use inherited color
        ),
      ),
      child: navLinkData.child,
    );
  }
}
