import 'package:flutter/material.dart';

class NavigationService {
  static NavigationService? _instance;
  GlobalKey<NavigatorState>? navigationKey;

  NavigationService._() {
    navigationKey= GlobalKey<NavigatorState>();
  }

  factory NavigationService() {
    _instance ??= NavigationService._();
    return _instance!;
  }
}
