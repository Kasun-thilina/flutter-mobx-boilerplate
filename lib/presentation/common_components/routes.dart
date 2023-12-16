import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_street_merchant/presentation/ui/auth/forgot_password_screen.dart';
import 'package:my_street_merchant/presentation/ui/auth/pin_verification_screen.dart';
import 'package:my_street_merchant/presentation/ui/auth/set_new_password_screen.dart';
import 'package:my_street_merchant/presentation/ui/auth/signin_screen.dart';
import 'package:my_street_merchant/presentation/ui/auth/signup_screen.dart';
import 'package:my_street_merchant/presentation/ui/main/bottom_nav_screen.dart';
import 'package:page_transition/page_transition.dart';

import '../ui/main/webview_screen.dart';
import '../ui/onboarding/onboarding_screen.dart';
import '../ui/onboarding/splash_screen.dart';

class AppRouter {
  static const String splashScreen = "/splashScreen",
      onboardingScreen = "/onboardingScreen",
      signInScreen = "/signInScreen",
      signUpScreen = "/signUpScreen",
      forgotPasswordScreen = "/forgotPasswordScreen",
      pinVerificationScreen = "/pinVerificationScreen",
      setNewPasswordScreen = "/setNewPasswordScreen",
      home = "/homeScreen",
      webViewScreen = "/webViewScreen",
      dd = "/dd";

  Route? onGenerateRoute(RouteSettings routeSettings) {
    Duration defaultDuration = const Duration(milliseconds: 400);
    PageTransitionType mainTransition = PageTransitionType.rightToLeft;
    switch (routeSettings.name) {
      case splashScreen:
        return MaterialPageRoute(
          builder: (BuildContext context) => const SplashScreen(),
        );
      case onboardingScreen:
        return MaterialPageRoute(
          builder: (BuildContext context) => const OnboardingScreen(),
        );
      case signInScreen:
        return PageTransition(
          child: const SignInScreen(),
          type: mainTransition,
          settings: routeSettings,
        );
      case signUpScreen:
        return PageTransition(
          child: const SignUpScreen(),
          type: mainTransition,
          settings: routeSettings,
        );
      case forgotPasswordScreen:
        return CupertinoPageRoute(
          builder: (BuildContext context) => const ForgotPasswordScreen(),
          settings: routeSettings,
        );
      case home:
        return PageTransition(
          child: const BottomNavScreen(),
          duration: defaultDuration,
          type: mainTransition,
          settings: routeSettings,
        );
      case webViewScreen:
        WebViewScreenArgs args;
        if (routeSettings.arguments != null) {
          args = routeSettings.arguments as WebViewScreenArgs;
        } else {
          args = WebViewScreenArgs(url: "", name: "");
        }
        return CupertinoPageRoute(
          builder: (BuildContext context) => WebViewScreen(
            args: args,
          ),
          settings: routeSettings,
        );
    }
    return null;
  }

  ///For navigating preserving bottom nav bar
  static Route onGenerateNestedRoute(RouteSettings routeSettings) {
    Duration defaultDuration = const Duration(milliseconds: 300);
    PageTransitionType mainTransition = PageTransitionType.rightToLeft;
    switch (routeSettings.name) {
      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('Something went wrong'),
        ),
      ),
    );
  }
}
