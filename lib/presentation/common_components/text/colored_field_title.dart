import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_street_merchant/utils/extensions/context_extensions.dart';
import 'package:my_street_merchant/utils/extensions/padding_extensions.dart';

import '../../../data/constants/app_colors.dart';

class ColoredFieldTitle extends StatelessWidget {
  final String text;
  final double? fontSize;
  final Color? textColor;
  final double? topPadding;

  const ColoredFieldTitle({Key? key, required this.text, this.textColor, this.topPadding, this.fontSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: AppColors().lightBlue15),
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Text(
        text,
        style: context.textTheme.bodyMedium?.copyWith(
          fontSize: fontSize?? 12.sp,
          color: AppColors().fontBlack2,
        ),
      ).paddingStart(30.w),
    ).paddingSymmetric(vertical: 20.h);
  }
}
