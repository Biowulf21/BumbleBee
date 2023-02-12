class InputValidator {
  static String? validatePassword(String? value) {
    final passwordRegexPattern =
        RegExp(r"^(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{11,}$");

    if (value != null && !passwordRegexPattern.hasMatch(value)) {
      return "Password must contain at least one uppercase character, one number, one special character, and must be at least 11 characters long";
    }
    return null;
  }

  static String? validateEmail(String? value) {
    final emailRegexPattern = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$");

    if (value != null && emailRegexPattern.hasMatch(value)) {
      return 'Please enter a valid email address.';
    }
    return null;
  }
}
