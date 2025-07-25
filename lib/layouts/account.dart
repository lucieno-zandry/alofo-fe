import 'package:alofo/widgets/account_sidebar/account_sidebar.dart';
import 'package:alofo/widgets/app_container.dart';
import 'package:flutter/material.dart';

class Account extends StatelessWidget {
  const Account({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AppContainer(child: Row(children: [AccountSidebar(), child]));
  }
}
