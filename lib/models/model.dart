abstract class Model {
  Map<String, dynamic> toJson();

  static List<Map<String, dynamic>>? toJsonList<T extends Model>(
    List<T>? instances,
  ) {
    if (instances == null || instances.isEmpty) return [];

    return instances.map((instance) => instance.toJson()).toList();
  }

  static List<T>? fromJsonList<T>(
    dynamic rawList,
    T Function(Map<String, dynamic>) fromJson,
  ) {
    if (rawList == null) return null;

    try {
      final safeList =
          (rawList as List)
              .map((item) => Map<String, dynamic>.from(item))
              .map((map) => fromJson(map))
              .toList();

      return safeList;
    } catch (e) {
      return null;
    }
  }
}
