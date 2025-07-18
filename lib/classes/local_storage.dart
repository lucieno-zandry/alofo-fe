import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  /// Saves an item to local storage.
  static Future<void> saveItem(String key, dynamic value) async {
    final prefs = await SharedPreferences.getInstance();

    final typeHandlers = {
      String: () => prefs.setString(key, value as String),
      int: () => prefs.setInt(key, value as int),
      double: () => prefs.setDouble(key, value as double),
      bool: () => prefs.setBool(key, value as bool),
    };

    if (typeHandlers.containsKey(value.runtimeType)) {
      await typeHandlers[value.runtimeType]!();
    } else {
      await prefs.setString(key, value.toString());
    }
  }

  /// Retrieves an item from local storage.
  static Future<T?> getItem<T>(String key) async {
    final prefs = await SharedPreferences.getInstance();

    final typeHandlers = {
      String: () => prefs.getString(key) as T?,
      int: () => prefs.getInt(key) as T?,
      double: () => prefs.getDouble(key) as T?,
      bool: () => prefs.getBool(key) as T?,
    };

    if (typeHandlers.containsKey(T)) {
      return typeHandlers[T]!();
    } else {
      return prefs.getString(key) as T?;
    }
  }

  /// Removes an item from local storage.
  static Future<void> removeItem(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }

  /// Checks if a key exists in local storage.
  static Future<bool> containsKey(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(key);
  }

  /// Clears all items from local storage.
  static Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
