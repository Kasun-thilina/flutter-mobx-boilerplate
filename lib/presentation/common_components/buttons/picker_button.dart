import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_street_merchant/data/constants/app_colors.dart';
import 'package:my_street_merchant/utils/extensions/context_extensions.dart';
import 'package:my_street_merchant/utils/extensions/padding_extensions.dart';

class PickerButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onPressed;

  const PickerButton({Key? key, required this.onPressed,required this.text,required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onPressed,
        customBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Ink(
          height: 183.h,
          width: 134.w,
          decoration:
              BoxDecoration(color: AppColors().lightBlue3, borderRadius: BorderRadius.all(Radius.circular(10.r))),
          child: Column(
            children: [
              Icon(
                icon,
                size: 54.w,
                color: AppColors().lightBlue,
              ).paddingTop(30.h),
              Text(
                text,
                style: context.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w700, color: AppColors().lightBlue),
              ).paddingTop(43.h)
            ],
          ),
        ),
      ),
    );
  }
}
