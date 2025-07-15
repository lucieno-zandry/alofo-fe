import 'package:alofo/classes/app_colors.dart';
import 'package:alofo/states/front_office_state.dart';
import 'package:alofo/widgets/avatar_name/avatar_name.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserDropdown extends StatelessWidget {
  const UserDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    Color? color = DefaultTextStyle.of(context).style.color;

    return GetBuilder<FrontOfficeState>(
      builder: (frontOfficeState) {
        if (frontOfficeState.user != null) {
          return PopupMenuButton<String>(
            // color: AppColors.dark(),
            icon: AvatarName(
              name: frontOfficeState.user!.name ?? 'Unknown',
              circleColor: AppColors.secondary(),
              textStyle: Theme.of(
                context,
              ).textTheme.bodySmall!.copyWith(color: color),
            ),
            itemBuilder:
                (context) => [
                  PopupMenuItem(value: 'profile', child: Text('Profile')),
                  PopupMenuItem(value: 'logout', child: Text('Logout')),
                ],
            onSelected: (value) {
              if (value == 'profile') {
                // Handle profile navigation
              } else if (value == 'logout') {
                // Handle logout
              }
            },
          );
        }

        return SizedBox();
      },
    );
  }
}
