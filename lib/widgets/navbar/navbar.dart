import 'package:alofo/classes/app_colors.dart';
import 'package:alofo/classes/screen.dart';
import 'package:alofo/widgets/auth_dialog_toggler/auth_dialog_toggler.dart';
import 'package:alofo/widgets/navbar/navbar_xl.dart';
import 'package:alofo/widgets/navbar/navbar_xs.dart';
import 'package:alofo/types/nav_link_data.dart';
import 'package:alofo/widgets/user_dropdown/user_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Map<String, Map<String, Color>> navbarTheme = {
  '/': {'color': AppColors.light(), 'backgroundColor': AppColors.primary()},
  'default': {'color': AppColors.dark(), 'backgroundColor': AppColors.light()},
};

List<NavLinkData> leftActions(BuildContext context) => [
  NavLinkData(child: Text('PRODUCTS'), href: '/products'),
  NavLinkData(child: Text('WOMEN'), href: '/women'),
  NavLinkData(child: Text('MEN'), href: '/men'),
  NavLinkData(child: Text('ACCESSORIES'), href: '/accessories'),
];

List<Widget> rightActions(BuildContext context) {
  Color? color = DefaultTextStyle.of(context).style.color;

  return [
    Text('ABOUT'),
    Text('CONTACT US'),
    Text('\$0.00'),
    IconButton(onPressed: () {}, icon: Icon(Icons.shopping_bag, color: color)),
    AuthDialogToggler(),
    UserDropdown(),
  ];
}

class Navbar extends StatelessWidget {
  const Navbar({super.key});

  @override
  Widget build(BuildContext context) {
    String? currentPath = GoRouter.of(context).state.path;
    Color backgroundColor =
        navbarTheme[currentPath]?['backgroundColor'] ??
        navbarTheme['default']!['backgroundColor']!;
    Color color =
        navbarTheme[currentPath]?['color'] ?? navbarTheme['default']!['color']!;

    return Container(
      padding: EdgeInsets.symmetric(vertical: 30),
      color: backgroundColor,
      child: DefaultTextStyle(
        style: TextStyle(color: color),
        child: Builder(
          builder: (context) {
            return Screen.responsive<Widget>(
              width: MediaQuery.of(context).size.width,
              standard: NavbarXs(
                leftActions: leftActions(context),
                rightActions: rightActions(context),
              ),
              lg: NavbarXl(
                leftActions: leftActions(context),
                rightActions: rightActions(context),
              ),
            );
          },
        ),
      ),
    );
  }
}
