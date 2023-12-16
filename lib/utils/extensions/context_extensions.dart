import 'package:flutter/material.dart';

import '../../generated/l10n.dart';

extension ContextExtensions on BuildContext {
  /// Extension to read from generated localized strings
  S get strings => S.of(this);

  /// accepts a double [scale] and returns scaled sized based on the screen Width
  double getScaledWidth(double scale) {
    return scale * MediaQuery.of(this).size.width;
  }

  /// accepts a double [scale] and returns scaled sized based on the screen Height
  double getScaledHeight(double scale) {
    return scale * MediaQuery.of(this).size.height;
  }

  TextTheme get textTheme => Theme.of(this).textTheme;

  /// Returns true if keyboard is open
  bool isKeyboardOpen() {
    return FocusScope.of(this).hasFocus;
  }

  bool isKeyboardOpen2() {
    return MediaQuery.of(this).viewInsets.bottom > 0;
  }

  bool get mounted {
    try {
      widget;
      return true;
    } catch (e) {
      return false;
    }
  }

  pushNamed(
    String routeName, {
    Object? arguments,
  }) {
    FocusScope.of(this).unfocus();
    Navigator.pushNamed(this, routeName, arguments: arguments);
  }

  pushNamedUsingRoot(
    String routeName, {
    Object? arguments,
  }) {
    FocusScope.of(this).unfocus();
    Navigator.of(this,rootNavigator: true).pushNamed(routeName, arguments: arguments);
  }

  pushNamedWithoutRoot(
      String routeName, {
        Object? arguments,
      }) {
    FocusScope.of(this).unfocus();
    Navigator.of(this,rootNavigator: false).pushNamed(routeName, arguments: arguments);
  }

  pushReplacementNamed(
    String routeName, {
    Object? arguments,
  }) {
    FocusScope.of(this).unfocus();
    Navigator.pushReplacementNamed(
      this,
      routeName,
      arguments: arguments,
    );
  }

  pushNamedAndRemoveUntil(
    String routeName, {
    Object? arguments,
  }) {
    FocusScope.of(this).unfocus();
    Navigator.pushNamedAndRemoveUntil(
      this,
      routeName,
      (Route<dynamic> route) => false,
      arguments: arguments,
    );
  }
}
