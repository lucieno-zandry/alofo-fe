import 'package:alofo/models/models.dart' as models;
import 'package:alofo/widgets/navbar/navbar.dart';
import 'package:alofo/widgets/navbar_drawer/navbar_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FrontOfficeState with ChangeNotifier {
  models.User? _user;
  bool userStateIsKnown = false;

  models.User? get user {
    return _user;
  }

  void setUser(models.User? user) {
    _user = user;
    userStateIsKnown = true;
    notifyListeners();
  }
}

class FrontOffice extends StatelessWidget {
  const FrontOffice({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => FrontOfficeState(),
      child: Scaffold(
        endDrawer: NavbarDrawer(
          topActions: leftActions(context),
          bottomActions: rightActions(context),
        ),
        body: Stack(children: [child, Navbar()]),
      ),
    );
  }
}
