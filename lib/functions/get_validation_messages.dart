import './get_validation_message.dart';

Map<String, String>? getValidationMessages(Map<String, dynamic> formData) {
  final Map<String, String> messages = {};

  formData.forEach((name, value) {
    final message = getValidationMessage(
      name,
      value?.toString() ?? '',
      formData,
    );
    if (message != null) {
      final key = name;
      messages[key] = message;
    }
  });

  return messages.isNotEmpty ? messages : null;
}
