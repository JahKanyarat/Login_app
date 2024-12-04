class Validator {
  static String? validateEmail(String Value) {
    Pattern pattern = r'[a-zA-Z0-9.]+@[a-zA-Z0-9.]+\.[a-zA-Z]+';
    RegExp regExp = RegExp(pattern as String);
    return !regExp.hasMatch(Value) ? "Pleasr enter a valid email" : null;
  }

  static String? validatePassword(String Value) {
    return Value.length < 6 ? "Password at least 6 Characters" : null;
  }
}
