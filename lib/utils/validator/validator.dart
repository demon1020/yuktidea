class Validator {
  String message = "";
  static bool validateMobile(String value) {
    String pattern = r'([6789][0-9]{9})';
    RegExp regExp = RegExp(pattern);

    return regExp.hasMatch(value);
  }

  static bool validatePassword(String value) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(value);
  }
}
