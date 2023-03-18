abstract class IEnumConverter {
  String fromStringToShortString({required String enumString});
  String fromEnumToShortString({required Object enumObj});
}

class EnumConverter extends IEnumConverter {
  @override
  String fromStringToShortString({required String enumString}) {
    return enumString.split('.').last;
  }

  @override
  String fromEnumToShortString({required Object enumObj}) {
    return enumObj.toString().split('.').last;
  }

  static String convertEnumToShortString(Object enumObj) {
    return EnumConverter().fromEnumToShortString(enumObj: enumObj);
  }

  static String convertStringToShortString(String enumString) {
    return EnumConverter().fromStringToShortString(enumString: enumString);
  }
}
