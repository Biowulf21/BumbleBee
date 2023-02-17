class InputValidator {
  static String? validatePassword(String? value) {
    final passwordRegexPattern =
        RegExp(r"^(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{11,}$");

    if (value == null || value.isEmpty) return "Please enter a password.";

    if (!passwordRegexPattern.hasMatch(value)) {
      return """Password must contain at least:
       * one uppercase character;
       * one number, one special character;
       * and must be at least 11 characters long""";
    }
    return null;
  }

  static String? validateEmail(String? value) {
    final emailRegexPattern = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$");

    if (value == null || value.isEmpty) return "Please enter an email address.";

    if (!emailRegexPattern.hasMatch(value)) {
      return 'Please enter a valid email address.';
    }
    return null;
  }

  static String? validateName(String? value, String nametype) {
    Map nameRegexPatterns = {
      'first': '^[A-Z][a-z]{1,30}\$',
      'middle': '^[A-Z][a-z]+([- ][A-Z][a-z]+)*\$',
      'last':
          "^[A-Z][a-z]+(['- ][A-Z][a-z]+)*(( [Dd]e [Ll]a|[Dd]el|[Dd]e|[Dd]a) [A-Z][a-z]+)*\$",
    };

    if (nametype == "middle") {
      if (value == null || value.isEmpty) return null;
      if (RegExp(nameRegexPatterns['middle']).hasMatch(value)) return null;
    }

    if (value != null &&
        nametype == "first" &&
        RegExp(nameRegexPatterns['first']).hasMatch(value)) return null;

    if (nametype == '') if (nametype == "middle" &&
        value != null &&
        RegExp(nameRegexPatterns['middle']).hasMatch(value)) {
      return null;
    }

    if (value != null &&
        nametype == "last" &&
        RegExp(nameRegexPatterns['last']).hasMatch(value)) {
      return null;
    }

    return 'Please enter a valid $nametype name';
  }

  static String? validatePhilippinePhoneNumber(String? value) {
    final phoneNumberRegex = RegExp(r'^(09|\+639)\d{9}$');

    if (value == null || value.isEmpty) {
      return 'Please enter a valid Philippine phone number.';
    }

    if (phoneNumberRegex.hasMatch(value)) {
      return null;
    }

    return 'Please enter a valid Philippine phone number.';
  }
}
