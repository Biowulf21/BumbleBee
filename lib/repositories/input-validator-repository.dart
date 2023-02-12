class InputValidator {
  static String? validatePassword(String? value) {
    final regexPattern =
        RegExp(r"^(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{11,}$");

    if (value != null && value.isEmpty) return "Password must not be empty";

    if (value != null && !regexPattern.hasMatch(value)) {
      return "Password must contain at least one uppercase character, one number, one special character, and must be at least 11 characters long";
    }
    return null;
  }

  static String? validateEmail(String value) {
    return null;
  }
}
