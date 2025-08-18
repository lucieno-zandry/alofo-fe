import 'package:alofo/widgets/nav_link_items/nav_link_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class NavbarXl extends StatelessWidget {
  final List<Widget> rightActions;

  const NavbarXl({
    super.key,
    required this.rightActions,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: TextButton(
            onPressed: () {
              context.go('/');
            },
            child: SvgPicture.asset('assets/images/logo.svg'),
          ),
        ),
        Expanded(
          flex: 11,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                NavLinkItems(),
                Row(spacing: 20, children: rightActions),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
