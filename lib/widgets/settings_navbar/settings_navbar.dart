import 'package:alofo/classes/app_colors.dart';
import 'package:alofo/states/settings_navbar_state.dart';
import 'package:alofo/widgets/nav_link.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsNavbar extends StatelessWidget {
  final List<NavLink> navLinks;
  const SettingsNavbar({super.key, required this.navLinks});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingsNavbarState>(
      builder: (state) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(navLinks.length, (index) {
              bool isActive = index == state.activeIndex;
              NavLink navLink = navLinks[index];

              return Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: BoxDecoration(
                  border:
                      isActive
                          ? Border(
                            bottom: BorderSide(
                              color: AppColors.dark(),
                              width: 2,
                            ),
                          )
                          : null,
                ),
                child: Opacity(
                  opacity: isActive ? 1.0 : 0.6,
                  child: NavLink(
                    href: navLink.href,
                    onTap: () {
                      state.setActiveIndex(index);
                    },
                    child: navLink.child,
                  ),
                ),
              );
            }),
          ),
        );
      },
    );
  }
}
