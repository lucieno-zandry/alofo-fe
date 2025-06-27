import 'package:alofo/models/models.dart' as models;

models.Variant? findVariant(
  List<models.Variant> variants,
  List<models.VariantOption> activeVariantOption,
) {
  final activeIds = activeVariantOption.map((o) => o.id).toSet();

  for (final variant in variants) {
    final variantIds = variant.variantOptions!.map((o) => o.id).toSet();
    if (variantIds.length == activeIds.length &&
        variantIds.containsAll(activeIds)) {
      return variant;
    }
  }

  return null;
}