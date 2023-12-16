import 'package:flutter/material.dart';

class Validator {
  factory Validator() => Validator._internal();

  Validator._internal();

  static bool isValidEmail(String value) {
    return RegExp(r"^[\w-\.+]+@([\w-]+\.)+[\w-]{2,4}$").hasMatch(value);
  }

  static bool has8Chars(String value) {
    return value.characters.length >= 8;
  }

  static bool hasUpperLowerCase(String value) {
    bool upperCase = RegExp(r'[A-Z]').hasMatch(value);
    bool lowerCase = RegExp(r'[a-z]').hasMatch(value);
    return upperCase;
  }

  static bool hasNumber(String value) {
    return RegExp(r'[0-9]').hasMatch(value);
  }

  static bool hasSpecialChar(String value) {
    return RegExp(r"[-@#€£¥₩!$%^&*()_+|~=`{}\[\]:;'<>?,.\/"
            '"'
            "]")
        .hasMatch(value);
  }
}
