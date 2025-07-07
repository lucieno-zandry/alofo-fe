String? getValidationMessage(
  String name,
  String value, [
  Map<String, dynamic> data = const {},
]) {
  String? message;
  RegExp? regexPattern;

  switch (name) {
    case "user.name":
      regexPattern = RegExp(r'^[a-zéèâàäöïîôòìëêûüùç]{2,20}$', caseSensitive: false);
      if (value.isEmpty) {
        message = "The name field is required";
      } else if (value.length < 2) {
        message = "The name should contain at least 2 characters";
      } else if (!regexPattern.hasMatch(value)) {
        message = "The name should contain only alphabetic characters";
      }
      break;

    case "user.email":
      regexPattern = RegExp(r'^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
      if (value.isEmpty) {
        message = "The email adress is required";
      } else if (!regexPattern.hasMatch(value)) {
        message = "This email format is invalid";
      }
      break;

    case "user.password":
      if (value.isEmpty) {
        message = "The password is required";
      } else if (value.length < 6) {
        message = "The password length should be at least 6 caracters";
      }
      break;

    case "user.password_confirmation":
      if (data["user.password"] != value) {
        message = "The passwords don't match";
      }
      break;

    default:
      break;
  }

  return message;
}