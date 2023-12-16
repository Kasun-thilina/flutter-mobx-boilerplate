import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_street_merchant/data/constants/app_colors.dart';

class WhiteBackground extends StatelessWidget {
  final Widget child;

  const WhiteBackground({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        decoration: BoxDecoration(
            color: AppColors().white,
            borderRadius: BorderRadius.circular(7),
            border: Border.all(color: AppColors().grey)),
        padding: EdgeInsets.all(14.w),
        child: child);
  }
}
