import 'package:flutter/cupertino.dart';

import '../environment_utils.dart';

extension StringExtension on String {
  /// Capitalize each word inside string
  /// Example: your name => Your Name, your name => Your name
  String capitalizeSentence() {
    if (isEmpty) return this;
    return split(' ').map((e) => e.capitalizeSentence()).join(' ');
  }

  /// Uppercase first letter inside string and let the others lowercase
  /// Example: your name => Your name
  String capitalizeWord() {
    if (isEmpty) return this;
    return this[0].toUpperCase() + substring(1).toLowerCase();
  }

  /// Remove all whitespace inside string
  /// Example: your name => yourname
  String removeAllWhitespace() {
    return replaceAll(' ', '');
  }

  bool hasMatch(String pattern) {
    return RegExp(pattern).hasMatch(this);
  }

  /// Checks if string consist only numeric.
  /// Numeric only doesn't accepting "." which double data type have
  bool isNumericOnly() => hasMatch(r'^\d+$');

  /// Checks if string consist only Alphabet. (No Whitespace)
  bool isAlphabetOnly() => hasMatch(r'^[a-zA-Z]+$');

  /// Checks if string contains at least one Capital Letter
  bool hasCapitalLetter() => hasMatch(r'[A-Z]');

  /// Checks if string is boolean.
  bool isBool() {
    return (this == 'true' || this == 'false');
  }

  /// Checks if string is a valid email
  bool isValidEmail() {
    return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(this);
  }

  ///Capitalize first letter
  String toCapitalized() => length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';

  String trimIfLong(int max) {
    if (length == max + 2) {
      return this;
    }
    if (length > max) {
      return "${substring(0, max)}...";
    } else {
      return this;
    }
  }

  String getPrice() {
    try {
      return split(".")[0];
    } catch (e) {
      debugPrint(e.toString());
      return "0";
    }
  }

  String getDecimals() {
    try {
      return split(".")[1];
    } catch (e) {
      debugPrint(e.toString());
      return "00";
    }
  }

  String concatPrice(String price) {
    if (this == "") {
      return "$this.${price.getDecimals()}";
    } else {
      return "${getPrice()}.${price.getDecimals()}";
    }
  }

  String getImageUrl() {
    return "http://${EnvironmentUtils.apiBaseURL}/api/v1/users/store/image/$this";
  }
}
