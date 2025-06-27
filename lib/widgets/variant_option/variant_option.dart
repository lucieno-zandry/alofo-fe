import 'package:alofo/classes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:alofo/models/models.dart' as models;

class VariantOption extends StatelessWidget {
  const VariantOption({
    super.key,
    required this.variantOption,
    this.isActive = false,
    this.onTap,
  });
  final models.VariantOption variantOption;
  final bool isActive;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration:
            !isActive
                ? BoxDecoration(
                  border: Border.all(color: AppColors.dark(alpha: 100)),
                )
                : null,
        color: isActive ? AppColors.dark() : null,
        child: Text(
          variantOption.value!,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: isActive ? AppColors.light() : AppColors.dark(),
          ),
        ),
      ),
    );
  }
}
