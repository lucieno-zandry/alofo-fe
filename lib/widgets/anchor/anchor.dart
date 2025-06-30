import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Anchor extends StatelessWidget {
  const Anchor({
    super.key,
    required this.child,
    this.onPressed,
    required this.href,
  });

  final Widget child;
  final void Function()? onPressed;
  final String href;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        onPressed?.call();
        context.go(href);
      },
      child: child,
    );
  }
}
