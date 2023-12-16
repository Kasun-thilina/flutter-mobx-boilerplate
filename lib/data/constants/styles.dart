import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_street_merchant/data/constants/app_colors.dart';

class Styles {
  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    return ThemeData(
      primarySwatch: Colors.blue,
      primaryColor: isDarkTheme ? Colors.black : Colors.white,
      indicatorColor: isDarkTheme ? const Color(0xff0E1D36) : const Color(0xffCBDCF8),
      hintColor: isDarkTheme ? const Color(0xff280C0B) : const Color(0xffEECED3),
      highlightColor: isDarkTheme ? const Color(0xff372901) : AppColors().primaryColor.withOpacity(0.2),
      hoverColor: Colors.transparent,
      focusColor: AppColors().primaryColor,
      disabledColor: Colors.grey,
      cardColor: isDarkTheme ? const Color(0xFF151515) : Colors.white,
      canvasColor: AppColors().backgroundColor,
      brightness: isDarkTheme ? Brightness.dark : Brightness.light,
      buttonTheme: Theme.of(context)
          .buttonTheme
          .copyWith(colorScheme: isDarkTheme ? const ColorScheme.dark() : const ColorScheme.light()),
      fontFamily: "OpenSans",
      textTheme: TextTheme(
        displayLarge:
            TextStyle(fontSize: 30.sp, color: AppColors().black, fontWeight: FontWeight.w600, fontFamily: "OpenSans",letterSpacing: -0.32),
        displayMedium:
            TextStyle(fontSize: 22.sp, color: AppColors().white, fontWeight: FontWeight.w700, fontFamily: "OpenSans",letterSpacing: -0.32),
        displaySmall: TextStyle(
            fontSize: 13.sp, color: AppColors().fontGrey, fontWeight: FontWeight.w700, fontFamily: "OpenSans",letterSpacing: -0.32),
        headlineMedium: TextStyle(
            fontSize: 20.sp, color: AppColors().fontGreySubtitle, fontWeight: FontWeight.w400, fontFamily: "OpenSans",letterSpacing: -0.32),
        headlineSmall: TextStyle(
            fontSize: 14.sp, color: AppColors().black, fontWeight: FontWeight.w400, fontFamily: "OpenSans",letterSpacing: -0.32),
        bodyLarge: TextStyle(
            fontSize: 16.sp, color: AppColors().fontBlack, fontWeight: FontWeight.w400, fontFamily: "OpenSans",letterSpacing: -0.32),
        bodyMedium: TextStyle(
            fontSize: 14.sp, color: AppColors().fontBlack, fontWeight: FontWeight.w600, fontFamily: "OpenSans",letterSpacing: -0.32),
        titleMedium: TextStyle(
            fontSize: 13.sp, color: AppColors().fontBlack, fontWeight: FontWeight.w100, fontFamily: "OpenSans",letterSpacing: -0.32),
        titleSmall: TextStyle(
            fontSize: 12.sp, color: AppColors().fontBlack, fontWeight: FontWeight.w100, fontFamily: "OpenSans",letterSpacing: -0.32),
      ),
      appBarTheme: AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        backgroundColor: AppColors().backgroundColor
      ),
    );
  }
}
