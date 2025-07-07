import 'package:alofo/classes/app_colors.dart';
import 'package:alofo/functions/get_responsive_padding.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button({
    super.key,
    required this.onPressed,
    required this.child,
    this.variant = 'primary',
    this.isLoading = false,
  });

  final VoidCallback? onPressed;
  final Widget child;
  final String variant;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final padding = getResponsivePadding(MediaQuery.of(context).size.width);
    final style = _getStyleFromVariant(variant);
    final bool isDisabled = onPressed == null || isLoading;

    return Opacity(
      opacity: isDisabled ? 0.5 : 1.0, // Dim opacity if disabled or loading
      child: TextButton(
        onPressed: isDisabled ? null : onPressed,
        style: ButtonStyle(
          padding: WidgetStateProperty.all<EdgeInsets>(padding),
          backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
            if (isDisabled) {
              return style.backgroundColor;
            }
            return states.contains(WidgetState.hovered)
                ? style.hoverBackgroundColor
                : style.backgroundColor;
          }),
          foregroundColor: WidgetStateProperty.resolveWith<Color>((states) {
            if (isDisabled) {
              return style.foregroundColor.withAlpha(150);
            }
            return states.contains(WidgetState.hovered)
                ? style.hoverForegroundColor
                : style.foregroundColor;
          }),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          ),
        ),
        child: isLoading
            ? SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(style.foregroundColor),
                  strokeWidth: 2,
                ),
              )
            : child,
      ),
    );
  }

  _ButtonStyleData _getStyleFromVariant(String variant) {
    switch (variant) {
      case 'secondary':
        return _ButtonStyleData(
          backgroundColor: AppColors.secondary(),
          foregroundColor: AppColors.dark(),
          hoverBackgroundColor: AppColors.dark(),
          hoverForegroundColor: AppColors.light(),
        );
      case 'light':
        return _ButtonStyleData(
          backgroundColor: AppColors.light(),
          foregroundColor: AppColors.dark(),
          hoverBackgroundColor: AppColors.dark(),
          hoverForegroundColor: AppColors.light(),
        );
      case 'dark':
        return _ButtonStyleData(
          backgroundColor: AppColors.dark(),
          foregroundColor: AppColors.light(),
          hoverBackgroundColor: AppColors.light(),
          hoverForegroundColor: AppColors.dark(),
        );
      case 'primary':
      default:
        return _ButtonStyleData(
          backgroundColor: AppColors.primary(),
          foregroundColor: AppColors.light(),
          hoverBackgroundColor: AppColors.light(),
          hoverForegroundColor: AppColors.primary(),
        );
    }
  }
}

class _ButtonStyleData {
  final Color backgroundColor;
  final Color foregroundColor;
  final Color hoverBackgroundColor;
  final Color hoverForegroundColor;

  _ButtonStyleData({
    required this.backgroundColor,
    required this.foregroundColor,
    required this.hoverBackgroundColor,
    required this.hoverForegroundColor,
  });
}
