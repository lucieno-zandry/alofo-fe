import 'package:alofo/classes/account_sidebar_menu_item.dart';
import 'package:alofo/classes/pages_uris.dart';
import 'package:alofo/widgets/anchor/anchor.dart';
import 'package:flutter/material.dart';

List<AccountSidebarMenuItem> accountSidebarMenuItems = [
  AccountSidebarMenuItem(href: PagesUris.settingsPage, name: 'Settings'),
  AccountSidebarMenuItem(
    href: PagesUris.addressesPage,
    name: 'Shipping Address',
  ),
];

class AccountSidebar extends StatelessWidget {
  const AccountSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10,
        children: [
          Text('Account', style: Theme.of(context).textTheme.titleSmall),
          for (var accountSidebarMenuItem in accountSidebarMenuItems)
            Anchor(
              href: accountSidebarMenuItem.href,
              child: Text(accountSidebarMenuItem.name),
            ),
        ],
      ),
    );
  }
}
