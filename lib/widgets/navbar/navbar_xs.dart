import 'package:alofo/types/nav_link_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class NavbarXs extends StatelessWidget {
  const NavbarXs({
    super.key,
    required this.leftActions,
    required this.rightActions,
  });

  final List<NavLinkData> leftActions;
  final List<Widget> rightActions;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            onPressed: () {
              context.go('/');
            },
            child: SvgPicture.asset('assets/images/logo.svg'),
          ),
          Row(
            spacing: 10,
            children: [
              rightActions[2],
              rightActions[3],
              IconButton(
                icon: Icon(
                  Icons.menu,
                  color: DefaultTextStyle.of(context).style.color,
                ),
                onPressed: () {
                  Scaffold.of(context).openEndDrawer();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
