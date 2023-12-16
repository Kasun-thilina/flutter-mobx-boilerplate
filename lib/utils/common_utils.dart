import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:my_street_merchant/utils/extensions/string_extensions.dart';

class CommonUtils {

  double getPriceForNonDecimal({required double currentPrice, required String changedValue}) {
    String currentDecimal = currentPrice.toString().getDecimals();
    String currentNonDecimal = currentPrice.toString().getPrice();
    return double.parse("$changedValue.$currentDecimal");
  }

  double getPriceForDecimal({required double currentPrice, required String changedValue}) {
    String currentNonDecimal = currentPrice.toString().getPrice();
    return double.parse("$currentNonDecimal.$changedValue");
  }

  String addLeadingZero(int number) {
    if (number <= 9) {
      return "0$number";
    } else {
      return number.toString();
    }
  }

  ///Format Date in string format
  String formatStringDate(String date, String format) {
    try {
      DateTime parsed = DateTime.parse(date);
      final DateFormat formatter = DateFormat(format);
      final String formatted = formatter.format(parsed);
      return formatted;
    } catch (e) {
      return "";
    }
  }

  ///Format date in DateTime format
  String formatDate(DateTime date, {String? format}) {
    try {
      final DateFormat formatter = DateFormat(format ?? 'yyyy-MM-dd');
      final String formatted = formatter.format(date);
      return formatted;
    } catch (e) {
      return "";
    }
  }

  ///Returns only the value without decimal places from double with decimal places
  String getPrice(String text) {
    try {
      return text.split(".")[0];
    } catch (e) {
      debugPrint(e.toString());
      return "0";
    }
  }

  double getPriceInDouble(double? price) {
    if (price == null) {
      return 0;
    }
    String value = price.toString();
    try {
      return double.parse(value.split(".")[0]);
    } catch (e) {
      debugPrint(e.toString());
      return 0;
    }
  }

  String getPriceDecimal(double? price) {
    if (price == null) {
      return "0";
    }
    String value = price.toString();
    try {
      if (value.split(".").length == 1) {
        return price.toString();
      }
      return value.split(".")[1];
    } catch (e) {
      debugPrint(e.toString());
      return "0";
    }
  }

  ///Remove zero from double if decimals are 0/00
  String removeZero(double val) {
    var result = val.toString();

    if (val.toString().split(".").isNotEmpty) {
      var decimalPoint = val.toString().split(".")[1];
      if (decimalPoint == "0") {
        result = result.split(".0").join("");
      }
      if (decimalPoint == "00") {
        result = result.split(".00").join("");
      }
    }
    return result;
  }

  ///Calculate price after the discount
  double calculateDiscountedPrice(double? price, String discount) {
    if (price != null) {
      return price - ((price * double.parse(discount)) / 100);
    }
    return 0;
  }

  double calculatePriceBeforeDiscount(double? price, String discount) {
    if (price != null) {
      return price + ((price * double.parse(discount)) / 100);
    }
    return 0;
  }
}
