// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Flutter Mobx Boilerplate`
  String get appName {
    return Intl.message(
      'Flutter Mobx Boilerplate',
      name: 'appName',
      desc: '',
      args: [],
    );
  }

  /// `Error`
  String get error {
    return Intl.message(
      'Error',
      name: 'error',
      desc: '',
      args: [],
    );
  }

  /// `Done`
  String get done {
    return Intl.message(
      'Done',
      name: 'done',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get yes {
    return Intl.message(
      'Yes',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get no {
    return Intl.message(
      'No',
      name: 'no',
      desc: '',
      args: [],
    );
  }

  /// `OK`
  String get ok {
    return Intl.message(
      'OK',
      name: 'ok',
      desc: '',
      args: [],
    );
  }

  /// `Submit`
  String get submit {
    return Intl.message(
      'Submit',
      name: 'submit',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get continueText {
    return Intl.message(
      'Continue',
      name: 'continueText',
      desc: '',
      args: [],
    );
  }

  /// `Start`
  String get start {
    return Intl.message(
      'Start',
      name: 'start',
      desc: '',
      args: [],
    );
  }

  /// `Select`
  String get select {
    return Intl.message(
      'Select',
      name: 'select',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message(
      'Search',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Send`
  String get send {
    return Intl.message(
      'Send',
      name: 'send',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get next {
    return Intl.message(
      'Next',
      name: 'next',
      desc: '',
      args: [],
    );
  }

  /// `Add`
  String get add {
    return Intl.message(
      'Add',
      name: 'add',
      desc: '',
      args: [],
    );
  }

  /// `Fetch`
  String get fetch {
    return Intl.message(
      'Fetch',
      name: 'fetch',
      desc: '',
      args: [],
    );
  }

  /// `Connect`
  String get connect {
    return Intl.message(
      'Connect',
      name: 'connect',
      desc: '',
      args: [],
    );
  }

  /// `Change`
  String get change {
    return Intl.message(
      'Change',
      name: 'change',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `Create`
  String get create {
    return Intl.message(
      'Create',
      name: 'create',
      desc: '',
      args: [],
    );
  }

  /// `Publish`
  String get publish {
    return Intl.message(
      'Publish',
      name: 'publish',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirm {
    return Intl.message(
      'Confirm',
      name: 'confirm',
      desc: '',
      args: [],
    );
  }

  /// `Decline`
  String get decline {
    return Intl.message(
      'Decline',
      name: 'decline',
      desc: '',
      args: [],
    );
  }

  /// `Finish`
  String get finish {
    return Intl.message(
      'Finish',
      name: 'finish',
      desc: '',
      args: [],
    );
  }

  /// `Following`
  String get following {
    return Intl.message(
      'Following',
      name: 'following',
      desc: '',
      args: [],
    );
  }

  /// `Follow`
  String get follow {
    return Intl.message(
      'Follow',
      name: 'follow',
      desc: '',
      args: [],
    );
  }

  /// `Try Again`
  String get tryAgain {
    return Intl.message(
      'Try Again',
      name: 'tryAgain',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong. Please try again!`
  String get somethingWentWrong {
    return Intl.message(
      'Something went wrong. Please try again!',
      name: 'somethingWentWrong',
      desc: '',
      args: [],
    );
  }

  /// `Something Went Wrong`
  String get somethingWentWrongText {
    return Intl.message(
      'Something Went Wrong',
      name: 'somethingWentWrongText',
      desc: '',
      args: [],
    );
  }

  /// `Server Error. Please try again!`
  String get serverError {
    return Intl.message(
      'Server Error. Please try again!',
      name: 'serverError',
      desc: '',
      args: [],
    );
  }

  /// `Session expired. Please sign in again`
  String get authorizationError {
    return Intl.message(
      'Session expired. Please sign in again',
      name: 'authorizationError',
      desc: '',
      args: [],
    );
  }

  /// `No Internet Connection!`
  String get noInternet {
    return Intl.message(
      'No Internet Connection!',
      name: 'noInternet',
      desc: '',
      args: [],
    );
  }

  /// `No internet connection found! Please check your connection and try again`
  String get noNetwork {
    return Intl.message(
      'No internet connection found! Please check your connection and try again',
      name: 'noNetwork',
      desc: '',
      args: [],
    );
  }

  /// `Are You Sure You\n Want To Log Out ?`
  String get areYouSureToLogOut {
    return Intl.message(
      'Are You Sure You\n Want To Log Out ?',
      name: 'areYouSureToLogOut',
      desc: '',
      args: [],
    );
  }

  /// `onboardingPageOneTitle`
  String get onboardingPageOneTitle {
    return Intl.message(
      'onboardingPageOneTitle',
      name: 'onboardingPageOneTitle',
      desc: '',
      args: [],
    );
  }

  /// `onboardingPageOneSubTitle`
  String get onboardingPageOneSubTitle {
    return Intl.message(
      'onboardingPageOneSubTitle',
      name: 'onboardingPageOneSubTitle',
      desc: '',
      args: [],
    );
  }

  /// `onboardingPageTwoTitle`
  String get onboardingPageTwoTitle {
    return Intl.message(
      'onboardingPageTwoTitle',
      name: 'onboardingPageTwoTitle',
      desc: '',
      args: [],
    );
  }

  /// `onboardingPageTwoSubTitle`
  String get onboardingPageTwoSubTitle {
    return Intl.message(
      'onboardingPageTwoSubTitle',
      name: 'onboardingPageTwoSubTitle',
      desc: '',
      args: [],
    );
  }

  /// `onboardingPageThreeTitle`
  String get onboardingPageThreeTitle {
    return Intl.message(
      'onboardingPageThreeTitle',
      name: 'onboardingPageThreeTitle',
      desc: '',
      args: [],
    );
  }

  /// `onboardingPageThreeSubTitle`
  String get onboardingPageThreeSubTitle {
    return Intl.message(
      'onboardingPageThreeSubTitle',
      name: 'onboardingPageThreeSubTitle',
      desc: '',
      args: [],
    );
  }

  /// `Get Started`
  String get getStarted {
    return Intl.message(
      'Get Started',
      name: 'getStarted',
      desc: '',
      args: [],
    );
  }

  /// `Sign In`
  String get signIn {
    return Intl.message(
      'Sign In',
      name: 'signIn',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get signUp {
    return Intl.message(
      'Sign Up',
      name: 'signUp',
      desc: '',
      args: [],
    );
  }

  /// `Welcome Back`
  String get welcomeBack {
    return Intl.message(
      'Welcome Back',
      name: 'welcomeBack',
      desc: '',
      args: [],
    );
  }

  /// `Good News !`
  String get goodNews {
    return Intl.message(
      'Good News !',
      name: 'goodNews',
      desc: '',
      args: [],
    );
  }

  /// `It Is Great To See You Back!!`
  String get greatToSeeYou {
    return Intl.message(
      'It Is Great To See You Back!!',
      name: 'greatToSeeYou',
      desc: '',
      args: [],
    );
  }

  /// `Email Address`
  String get email {
    return Intl.message(
      'Email Address',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Enter your password`
  String get hintPassword {
    return Intl.message(
      'Enter your password',
      name: 'hintPassword',
      desc: '',
      args: [],
    );
  }

  /// `Enter your email address`
  String get hintEmail {
    return Intl.message(
      'Enter your email address',
      name: 'hintEmail',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password?`
  String get forgotPassword {
    return Intl.message(
      'Forgot Password?',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Don’t have an account ?`
  String get dontHaveAccount {
    return Intl.message(
      'Don’t have an account ?',
      name: 'dontHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the email address`
  String get errorEmptyEmail {
    return Intl.message(
      'Please enter the email address',
      name: 'errorEmptyEmail',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid email`
  String get errorEmail {
    return Intl.message(
      'Please enter a valid email',
      name: 'errorEmail',
      desc: '',
      args: [],
    );
  }

  /// `Please enter password`
  String get errorPassword {
    return Intl.message(
      'Please enter password',
      name: 'errorPassword',
      desc: '',
      args: [],
    );
  }

  /// `Please enter confirm password`
  String get errorConfirmPassword {
    return Intl.message(
      'Please enter confirm password',
      name: 'errorConfirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Passwords doesn't match!`
  String get errorPasswordMismatch {
    return Intl.message(
      'Passwords doesn\'t match!',
      name: 'errorPasswordMismatch',
      desc: '',
      args: [],
    );
  }

  /// `Password should be at least 8 characters long`
  String get errorPasswordLength {
    return Intl.message(
      'Password should be at least 8 characters long',
      name: 'errorPasswordLength',
      desc: '',
      args: [],
    );
  }

  /// `Don’t Worry It Happens`
  String get dontWorry {
    return Intl.message(
      'Don’t Worry It Happens',
      name: 'dontWorry',
      desc: '',
      args: [],
    );
  }

  /// `Please provide the `
  String get pleaseProvide {
    return Intl.message(
      'Please provide the ',
      name: 'pleaseProvide',
      desc: '',
      args: [],
    );
  }

  /// `Add The Verification Code `
  String get addTheVerificationCode {
    return Intl.message(
      'Add The Verification Code ',
      name: 'addTheVerificationCode',
      desc: '',
      args: [],
    );
  }

  /// `We have sent a reset code to \n`
  String get weHaveSentACode {
    return Intl.message(
      'We have sent a reset code to \n',
      name: 'weHaveSentACode',
      desc: '',
      args: [],
    );
  }

  /// `\nCheck your email and type the code below.`
  String get checkYourEmail {
    return Intl.message(
      '\nCheck your email and type the code below.',
      name: 'checkYourEmail',
      desc: '',
      args: [],
    );
  }

  /// `Resend Code`
  String get resendCode {
    return Intl.message(
      'Resend Code',
      name: 'resendCode',
      desc: '',
      args: [],
    );
  }

  /// `Code sent. Try again in:`
  String get tryAgainIn {
    return Intl.message(
      'Code sent. Try again in:',
      name: 'tryAgainIn',
      desc: '',
      args: [],
    );
  }

  /// `Incorrect code. Please try again.`
  String get incorrectCode {
    return Intl.message(
      'Incorrect code. Please try again.',
      name: 'incorrectCode',
      desc: '',
      args: [],
    );
  }

  /// `You have exceeded your limit for attempts. Please try again after 15 minutes.`
  String get exceededOTPLimit {
    return Intl.message(
      'You have exceeded your limit for attempts. Please try again after 15 minutes.',
      name: 'exceededOTPLimit',
      desc: '',
      args: [],
    );
  }

  /// `If you have not received the verification email, please check your "Spam" folder within the five attempts we provide.`
  String get exceededOTPLimitNote {
    return Intl.message(
      'If you have not received the verification email, please check your "Spam" folder within the five attempts we provide.',
      name: 'exceededOTPLimitNote',
      desc: '',
      args: [],
    );
  }

  /// `Reset Password`
  String get resetPassword {
    return Intl.message(
      'Reset Password',
      name: 'resetPassword',
      desc: '',
      args: [],
    );
  }

  /// `Set A New Password`
  String get setANewPassword {
    return Intl.message(
      'Set A New Password',
      name: 'setANewPassword',
      desc: '',
      args: [],
    );
  }

  /// `New Password`
  String get newPassword {
    return Intl.message(
      'New Password',
      name: 'newPassword',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get confirmPassword {
    return Intl.message(
      'Confirm Password',
      name: 'confirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Password Must Contain At Least:`
  String get passwordMustContain {
    return Intl.message(
      'Password Must Contain At Least:',
      name: 'passwordMustContain',
      desc: '',
      args: [],
    );
  }

  /// `Eight characters`
  String get passwordConditionOne {
    return Intl.message(
      'Eight characters',
      name: 'passwordConditionOne',
      desc: '',
      args: [],
    );
  }

  /// `One upper case letter`
  String get passwordConditionTwo {
    return Intl.message(
      'One upper case letter',
      name: 'passwordConditionTwo',
      desc: '',
      args: [],
    );
  }

  /// `One numeric character`
  String get passwordConditionThree {
    return Intl.message(
      'One numeric character',
      name: 'passwordConditionThree',
      desc: '',
      args: [],
    );
  }

  /// `One special character`
  String get passwordConditionFour {
    return Intl.message(
      'One special character',
      name: 'passwordConditionFour',
      desc: '',
      args: [],
    );
  }

  /// `Passwords doesn’t match.`
  String get passwordsNotMatching {
    return Intl.message(
      'Passwords doesn’t match.',
      name: 'passwordsNotMatching',
      desc: '',
      args: [],
    );
  }

  /// `Your password has been reset successfully.`
  String get passwordResetSuccess {
    return Intl.message(
      'Your password has been reset successfully.',
      name: 'passwordResetSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid email address.`
  String get pleaseEnterAValidEmail {
    return Intl.message(
      'Please enter a valid email address.',
      name: 'pleaseEnterAValidEmail',
      desc: '',
      args: [],
    );
  }

  /// `Welcome!!`
  String get welcome {
    return Intl.message(
      'Welcome!!',
      name: 'welcome',
      desc: '',
      args: [],
    );
  }

  /// `Let’s Create Your Account`
  String get letsCreateYour {
    return Intl.message(
      'Let’s Create Your Account',
      name: 'letsCreateYour',
      desc: '',
      args: [],
    );
  }

  /// `This email address will be used to send the confirmation code.`
  String get thisEmailAddressWill {
    return Intl.message(
      'This email address will be used to send the confirmation code.',
      name: 'thisEmailAddressWill',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account?`
  String get alreadyHaveAnAcc {
    return Intl.message(
      'Already have an account?',
      name: 'alreadyHaveAnAcc',
      desc: '',
      args: [],
    );
  }

  /// `By continuing forward, you agree to Apps’s\n`
  String get byContinuing {
    return Intl.message(
      'By continuing forward, you agree to Apps’s\n',
      name: 'byContinuing',
      desc: '',
      args: [],
    );
  }

  /// `Terms & Conditions `
  String get termsNConditions {
    return Intl.message(
      'Terms & Conditions ',
      name: 'termsNConditions',
      desc: '',
      args: [],
    );
  }

  /// ` Terms and Conditions`
  String get termsConditions {
    return Intl.message(
      ' Terms and Conditions',
      name: 'termsConditions',
      desc: '',
      args: [],
    );
  }

  /// ` Privacy Policy`
  String get privacyPolicy {
    return Intl.message(
      ' Privacy Policy',
      name: 'privacyPolicy',
      desc: '',
      args: [],
    );
  }

  /// ` and `
  String get and {
    return Intl.message(
      ' and ',
      name: 'and',
      desc: '',
      args: [],
    );
  }

  /// `To confirm your account enter 6 digit code that has been sent to `
  String get toConfirmYourAccount {
    return Intl.message(
      'To confirm your account enter 6 digit code that has been sent to ',
      name: 'toConfirmYourAccount',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Email Address`
  String get confirmEmailAddress {
    return Intl.message(
      'Confirm Email Address',
      name: 'confirmEmailAddress',
      desc: '',
      args: [],
    );
  }

  /// `Add The OTP`
  String get addTheOtp {
    return Intl.message(
      'Add The OTP',
      name: 'addTheOtp',
      desc: '',
      args: [],
    );
  }

  /// `Your verification code has been successfully verified.`
  String get successfullyVerified {
    return Intl.message(
      'Your verification code has been successfully verified.',
      name: 'successfullyVerified',
      desc: '',
      args: [],
    );
  }

  /// `Your email has been successfully verified.`
  String get emailSuccessfullyVerified {
    return Intl.message(
      'Your email has been successfully verified.',
      name: 'emailSuccessfullyVerified',
      desc: '',
      args: [],
    );
  }

  /// `Your number has been successfully verified.`
  String get phoneSuccessfullyVerified {
    return Intl.message(
      'Your number has been successfully verified.',
      name: 'phoneSuccessfullyVerified',
      desc: '',
      args: [],
    );
  }

  /// `verify`
  String get verify {
    return Intl.message(
      'verify',
      name: 'verify',
      desc: '',
      args: [],
    );
  }

  /// `This email has been already registered.Try to <bold>Log In</bold> instead.`
  String get thisEmailHasRegistered {
    return Intl.message(
      'This email has been already registered.Try to <bold>Log In</bold> instead.',
      name: 'thisEmailHasRegistered',
      desc: '',
      args: [],
    );
  }

  /// `Log In `
  String get logIn {
    return Intl.message(
      'Log In ',
      name: 'logIn',
      desc: '',
      args: [],
    );
  }

  /// `instead.`
  String get instead {
    return Intl.message(
      'instead.',
      name: 'instead',
      desc: '',
      args: [],
    );
  }

  /// `The email address or password provided do not corresponded to any account at <bold>host</bold>.`
  String get emailPasswordNotMatching {
    return Intl.message(
      'The email address or password provided do not corresponded to any account at <bold>host</bold>.',
      name: 'emailPasswordNotMatching',
      desc: '',
      args: [],
    );
  }

  /// `The email address you entered already has an account`
  String get emailAlreadyExist {
    return Intl.message(
      'The email address you entered already has an account',
      name: 'emailAlreadyExist',
      desc: '',
      args: [],
    );
  }

  /// `The email address you entered does not have an account on <bold>APP</bold>.`
  String get emailNotExist {
    return Intl.message(
      'The email address you entered does not have an account on <bold>APP</bold>.',
      name: 'emailNotExist',
      desc: '',
      args: [],
    );
  }

  /// `Invalid email address. Please check again`
  String get invalidEmail {
    return Intl.message(
      'Invalid email address. Please check again',
      name: 'invalidEmail',
      desc: '',
      args: [],
    );
  }

  /// `Personal Data`
  String get personalData {
    return Intl.message(
      'Personal Data',
      name: 'personalData',
      desc: '',
      args: [],
    );
  }

  /// `Complete your account with personal data by providing your name and gender.`
  String get personalDataNote {
    return Intl.message(
      'Complete your account with personal data by providing your name and gender.',
      name: 'personalDataNote',
      desc: '',
      args: [],
    );
  }

  /// `First Name`
  String get firstName {
    return Intl.message(
      'First Name',
      name: 'firstName',
      desc: '',
      args: [],
    );
  }

  /// `Last Name`
  String get lastName {
    return Intl.message(
      'Last Name',
      name: 'lastName',
      desc: '',
      args: [],
    );
  }

  /// `Skip For Now`
  String get skipForNow {
    return Intl.message(
      'Skip For Now',
      name: 'skipForNow',
      desc: '',
      args: [],
    );
  }

  /// `Search For Country`
  String get searchForCountry {
    return Intl.message(
      'Search For Country',
      name: 'searchForCountry',
      desc: '',
      args: [],
    );
  }

  /// `Search For Code`
  String get searchForCode {
    return Intl.message(
      'Search For Code',
      name: 'searchForCode',
      desc: '',
      args: [],
    );
  }

  /// `Camera`
  String get camera {
    return Intl.message(
      'Camera',
      name: 'camera',
      desc: '',
      args: [],
    );
  }

  /// `Upload`
  String get upload {
    return Intl.message(
      'Upload',
      name: 'upload',
      desc: '',
      args: [],
    );
  }

  /// `View More`
  String get viewMore {
    return Intl.message(
      'View More',
      name: 'viewMore',
      desc: '',
      args: [],
    );
  }

  /// `View Less`
  String get viewLess {
    return Intl.message(
      'View Less',
      name: 'viewLess',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Chats`
  String get chats {
    return Intl.message(
      'Chats',
      name: 'chats',
      desc: '',
      args: [],
    );
  }

  /// `Cart`
  String get cart {
    return Intl.message(
      'Cart',
      name: 'cart',
      desc: '',
      args: [],
    );
  }

  /// `Orders`
  String get orders {
    return Intl.message(
      'Orders',
      name: 'orders',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message(
      'Profile',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `No Messages`
  String get noMessages {
    return Intl.message(
      'No Messages',
      name: 'noMessages',
      desc: '',
      args: [],
    );
  }

  /// `Enable Dark Mode`
  String get enableDarkMode {
    return Intl.message(
      'Enable Dark Mode',
      name: 'enableDarkMode',
      desc: '',
      args: [],
    );
  }

  /// `All messages`
  String get allMessages {
    return Intl.message(
      'All messages',
      name: 'allMessages',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
