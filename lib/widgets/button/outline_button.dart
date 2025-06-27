import 'package:alofo/classes/app_colors.dart';
import 'package:alofo/functions/get_responsive_padding.dart';
import 'package:flutter/material.dart';

class OutlineButton extends StatelessWidget {
  const OutlineButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.variant = 'light',
  });

  final VoidCallback? onPressed;
  final Widget child;
  final String variant;

  @override
  Widget build(BuildContext context) {
    final style = _getStyleFromVariant(variant);
    final padding = getResponsivePadding(MediaQuery.of(context).size.width);

    return OutlinedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        padding: WidgetStateProperty.all(padding),
        side: WidgetStateProperty.all(
          BorderSide(color: style.borderColor, width: 1),
        ),
        backgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.hovered)) {
            return style.hoverBackgroundColor;
          }
          return Colors.transparent;
        }),
        foregroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.hovered)) {
            return style.hoverForegroundColor;
          }
          return style.foregroundColor;
        }),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        ),
        elevation: WidgetStateProperty.all(0),
      ),
      child: child,
    );
  }

  /// Define color styles based on the variant
  _OutlineButtonStyle _getStyleFromVariant(String variant) {
    switch (variant) {
      case 'dark':
        return _OutlineButtonStyle(
          borderColor: AppColors.dark(),
          foregroundColor: AppColors.dark(),
          hoverBackgroundColor: AppColors.dark(),
          hoverForegroundColor: AppColors.light(),
        );
      case 'primary':
        return _OutlineButtonStyle(
          borderColor: AppColors.primary(),
          foregroundColor: AppColors.primary(),
          hoverBackgroundColor: AppColors.primary(),
          hoverForegroundColor: AppColors.light(),
        );
      case 'light':
      default:
        return _OutlineButtonStyle(
          borderColor: AppColors.light(),
          foregroundColor: AppColors.light(),
          hoverBackgroundColor: AppColors.light(),
          hoverForegroundColor: AppColors.dark(),
        );
    }
  }
}

class _OutlineButtonStyle {
  final Color borderColor;
  final Color foregroundColor;
  final Color hoverBackgroundColor;
  final Color hoverForegroundColor;

  _OutlineButtonStyle({
    required this.borderColor,
    required this.foregroundColor,
    required this.hoverBackgroundColor,
    required this.hoverForegroundColor,
  });
}
