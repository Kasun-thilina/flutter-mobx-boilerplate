import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_street_merchant/data/constants/app_colors.dart';
import 'package:my_street_merchant/data/constants/icons.dart';
import 'package:my_street_merchant/presentation/common_components/routes.dart';
import 'package:my_street_merchant/utils/extensions/context_extensions.dart';
import 'package:my_street_merchant/utils/sharedpref_utils.dart';

import '../../../data/constants/constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors().primaryColor,
      padding: EdgeInsets.symmetric(horizontal: 100.w),
      child: Image.asset(
        AssetIcons.appLogo,
        fit: BoxFit.contain,
      ),
    );
  }

  startTimer() async {
    var duration = const Duration(milliseconds: 2000);
    // SharedPrefs().setCurrentStep(CurrentStep.home);
    return Timer(duration, navigate);
  }

  navigate() async {
    if (SharedPrefs().accessToken != "") {
      String currentStep = SharedPrefs().currentStep;
      switch (currentStep) {
        case CurrentStep.home:
          context.pushNamedAndRemoveUntil(AppRouter.home);
          break;
        case CurrentStep.verifyEmail:
          if (SharedPrefs().isFirstSignUpDone) {
            Navigator.of(context).pushReplacementNamed(AppRouter.signInScreen);
          } else {
            Navigator.of(context).pushReplacementNamed(AppRouter.signUpScreen);
          }
          SharedPrefs().clearAll();
          break;

        default:
          context.pushNamedAndRemoveUntil(AppRouter.home);
          break;
      }
    } else {
      if (SharedPrefs().isOnboardingCompleted) {
        if (SharedPrefs().isFirstSignUpDone) {
          Navigator.of(context).pushReplacementNamed(AppRouter.signInScreen);
        } else {
          Navigator.of(context).pushReplacementNamed(AppRouter.signUpScreen);
        }
      } else {
        Navigator.of(context).pushReplacementNamed(AppRouter.onboardingScreen);
      }
    }
  }
}
