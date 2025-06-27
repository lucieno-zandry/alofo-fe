import 'package:alofo/models/models.dart' as models;

bool variantOptionIsActive(
  models.VariantOption variantOption,
  List<models.VariantOption> activeVariantOptions,
) {
  bool isActive = activeVariantOptions.any(
    (activeVariantOption) => activeVariantOption.id == variantOption.id,
  );

  return isActive;
}