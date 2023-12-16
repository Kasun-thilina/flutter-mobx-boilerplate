import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_street_merchant/data/constants/app_colors.dart';
import 'package:my_street_merchant/utils/extensions/context_extensions.dart';
import 'package:my_street_merchant/utils/extensions/padding_extensions.dart';

class PrimaryButton extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  final double? fontSize;
  final Size? minimumSize;
  final bool isDisabled;
  final Color? color;
  final Color? textColor;
  final Color? borderColor;
  final double? borderRadius;
  final double paddingVertical;
  final double paddingHorizontal;

  const PrimaryButton(
      {Key? key,
      required this.title,
      this.onPressed,
      this.minimumSize,
      this.fontSize,
      this.isDisabled = false,
      this.color,
      this.textColor,
      this.borderColor,
      this.borderRadius,
      this.paddingVertical = 15,
      this.paddingHorizontal = 40})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: color ?? AppColors().primaryColor,
          minimumSize: minimumSize,
          disabledBackgroundColor: AppColors().primaryColor.withOpacity(0.5),
          elevation: 0,
          shape: RoundedRectangleBorder(
            side: borderColor == null ? BorderSide.none : BorderSide(width: 2, color: borderColor!),
            borderRadius: BorderRadius.all(
              Radius.circular(borderRadius??40.r),
            ),
          )),
      onPressed: isDisabled ? null : onPressed,
      child: Text(
        title.toUpperCase(),
        style:
            context.textTheme.displayMedium?.copyWith(color: textColor ?? AppColors().white, fontSize: fontSize ?? 20.sp),
      ).paddingSymmetric(horizontal: paddingHorizontal.w, vertical: paddingVertical.h),
    );
  }
}
