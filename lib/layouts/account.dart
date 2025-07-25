import 'package:alofo/classes/app_colors.dart';
import 'package:alofo/classes/screen.dart';
import 'package:alofo/widgets/account_sidebar/account_sidebar.dart';
import 'package:alofo/widgets/app_container.dart';
import 'package:flutter/material.dart';

class Account extends StatelessWidget {
  const Account({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      margin: EdgeInsets.only(top: 150),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(15),
                color: AppColors.light(),
                width: Screen.percentageOf(constraints.maxWidth, 20),
                child: AccountSidebar(),
              ),
              Container(
                color: AppColors.light(),
                padding: EdgeInsets.all(15),
                width: Screen.percentageOf(constraints.maxWidth, 75),
                child: child,
              ),
            ],
          );
        },
      ),
    );
  }
}
