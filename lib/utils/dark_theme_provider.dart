import 'package:flutter/cupertino.dart';
import 'package:my_street_merchant/utils/sharedpref_utils.dart';

class DarkThemeProvider with ChangeNotifier {
  bool _darkTheme = false;

  bool get darkTheme => _darkTheme;

  void setDarkTheme(bool value) {
    _darkTheme = value;
    SharedPrefs().setDarkMode(value);
    notifyListeners();
  }
}
