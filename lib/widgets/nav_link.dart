import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NavLink extends StatelessWidget {
  final String href;
  final Widget child;
  final Function()? onTap;

  const NavLink({
    super.key,
    required this.href,
    required this.child,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        if (onTap != null) onTap!();
        
        context.go(href);
      },
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.all(
          DefaultTextStyle.of(context).style.color, // Use inherited color
        ),
      ),
      child: child,
    );
  }
}
