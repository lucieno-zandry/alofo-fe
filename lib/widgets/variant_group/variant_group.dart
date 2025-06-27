import 'package:alofo/classes/app_colors.dart';
import 'package:alofo/functions/variant_option_is_active.dart';
import 'package:alofo/widgets/variant_option/variant_option.dart';
import 'package:flutter/material.dart';
import 'package:alofo/models/models.dart' as models;

class VariantGroup extends StatelessWidget {
  const VariantGroup({
    super.key,
    required this.variantGroup,
    required this.selectedVariant,
    required this.activeVariantOptions,
    required this.onVariantOptionSelected,
  });

  final models.VariantGroup variantGroup;
  final models.Variant? selectedVariant;
  final List<models.VariantOption> activeVariantOptions;
  final Function(models.VariantOption) onVariantOptionSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (variantGroup.name != null && selectedVariant != null)
          Text(
            "${variantGroup.name!} :",
            style: Theme.of(
              context,
            ).textTheme.bodyLarge!.copyWith(color: AppColors.dark()),
          ),
        if (variantGroup.variantOptions != null &&
            variantGroup.variantOptions!.isNotEmpty)
          Row(
            spacing: 10,
            children: [
              for (var variantOption in variantGroup.variantOptions!)
                if (variantOption.value != null)
                  VariantOption(
                    variantOption: variantOption,
                    isActive:
                        selectedVariant != null &&
                        variantOptionIsActive(
                          variantOption,
                          activeVariantOptions,
                        ),
                    onTap: () {
                      onVariantOptionSelected(variantOption);
                    },
                  ),
            ],
          ),
      ],
    );
  }
}
