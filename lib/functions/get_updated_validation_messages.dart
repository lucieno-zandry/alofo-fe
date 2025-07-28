Map<String, String?>? getUpdatedValidationMessages({
  required String name,
  required Map<String, String?>? validationMessages,
  required Map<String, String?> defaultValidationMessages,
  required String? validationMessage,
}) {
  var newValidationMessages = {...defaultValidationMessages};

  if (validationMessages == null) {
    newValidationMessages[name] = validationMessage;
  } else {
    newValidationMessages = {...validationMessages, name: validationMessage};
  }

  bool newValidationMessagesIsEmpty = newValidationMessages.entries.every(
    (validation) => validation.value == null,
  );

  return newValidationMessagesIsEmpty ? null : newValidationMessages;
}
