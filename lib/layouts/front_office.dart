import 'package:alofo/widgets/navbar/navbar.dart';
import 'package:alofo/widgets/navbar_drawer/navbar_drawer.dart';
import 'package:flutter/material.dart';

class FrontOffice extends StatelessWidget {
  const FrontOffice({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: NavbarDrawer(
        topActions: leftActions(context),
        bottomActions: rightActions(context),
      ),
      body: Stack(children: [child, Navbar()]),
    );
  }
}
