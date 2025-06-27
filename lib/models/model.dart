abstract class Model {
  Map<String, dynamic> toJson();

  static List<Map<String, dynamic>>? toJsonList<T extends Model>(
    List<T>? instances,
  ) {
    if (instances == null || instances.isEmpty) return null;

    return instances.map((instance) => instance.toJson()).toList();
  }

  static List<T>? fromJsonList<T>(
    List<Map<String, dynamic>>? jsonList,
    T Function(Map<String, dynamic>) fromJson,
  ) {
    if (jsonList == null || jsonList.isEmpty) return null;

    return jsonList.map((childJson) => fromJson(childJson)).toList();
  }
}
