import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static SharedPreferences? _sharedPrefs;

  factory SharedPrefs() => SharedPrefs._internal();

  SharedPrefs._internal();

  final String _darkModeKey = "is_dark";
  final String _onboardingStatus = "onboarding_status";
  final String _accessToken = "access_token";
  final String _refreshToken = "refresh_token";
  final String _currentStep = "current_step";
  final String _userEmail = "user_email";
  final String _userPhone = "user_phone";
  final String _userName = "user_name";
  final String _userID = "user_id";
  final String _firstSignUp = "first_sign_up";
  final String _currency = "currency";

  Future<void> init() async {
    _sharedPrefs ??= await SharedPreferences.getInstance();
  }

  void setDarkMode(bool value) {
    _sharedPrefs?.setBool(_darkModeKey, value);
  }

  bool get isDarkMode => _sharedPrefs?.getBool(_darkModeKey) ?? false;

  void setAccessToken(String value) {
    _sharedPrefs?.setString(_accessToken, value);
  }

  String get accessToken => _sharedPrefs?.getString(_accessToken) ?? "";

  void setRefreshToken(String value) {
    _sharedPrefs?.setString(_refreshToken, value);
  }

  String get refreshToken => _sharedPrefs?.getString(_refreshToken) ?? "";

  void setUserID(String value) {
    _sharedPrefs?.setString(_userID, value);
  }

  String get userID => _sharedPrefs?.getString(_userID) ?? "";

  void setUserName(String value) {
    _sharedPrefs?.setString(_userName, value);
  }

  String get userName => _sharedPrefs?.getString(_userName) ?? "";

  /// Saves if user has gone through the onboarding screens
  void setOnboardingStatus(bool value) {
    _sharedPrefs?.setBool(_onboardingStatus, value);
  }

  bool get isOnboardingCompleted => _sharedPrefs?.getBool(_onboardingStatus) ?? false;


  ///Saves user email
  void setUserEmail(String value) {
    _sharedPrefs?.setString(_userEmail, value);
  }

  String get userEmail => _sharedPrefs?.getString(_userEmail) ?? "";

  ///Saves user phone No
  void setUserPhone(String value) {
    _sharedPrefs?.setString(_userPhone, value);
  }

  String get getUserPhone => _sharedPrefs?.getString(_userPhone) ?? "";


  /// Saves if user has done the first sign up for the installation
  void setFirstSignUpStatus(bool value) {
    _sharedPrefs?.setBool(_firstSignUp, value);
  }

  bool get isFirstSignUpDone => _sharedPrefs?.getBool(_firstSignUp) ?? false;

  /// Saves the app currency
  void setCurrency(String value) {
    _sharedPrefs?.setString(_currency, value);
  }
  String get currency => _sharedPrefs?.getString(_currency) ?? "AED";

  ///Sets current signup step of the user
  void setCurrentStep(String value) {
    _sharedPrefs?.setString(_currentStep, value);
  }

  String get currentStep => _sharedPrefs?.getString(_currentStep) ?? "";


  Future<void> clearAll() async {
    setCurrentStep("none");
    setUserEmail("");
    setUserName("");
    setAccessToken("");
    setRefreshToken("");
    debugPrint("Data Cleared");
  }
}
