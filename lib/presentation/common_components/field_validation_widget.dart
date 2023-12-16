import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_street_merchant/utils/extensions/context_extensions.dart';
import 'package:my_street_merchant/utils/extensions/padding_extensions.dart';

import '../../data/constants/app_colors.dart';

class FieldValidationWidget extends StatelessWidget {
  final bool isValid;
  final bool initial;
  final String text;

  const FieldValidationWidget({
    Key? key,
    required this.isValid,
    required this.initial,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AnimatedContainer(
            height: 16.h,
            width: 16.h,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInCirc,
            // decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: AppColors().red)),
            child: initial
                ? Icon(
                    Icons.circle_outlined,
                    size: 16.h,
                    color: AppColors().fontLightGrey,
                  )
                : !isValid
                    ? Icon(
              Icons.cancel,
                        color: AppColors().red2,
                        size: 16.h,
                      )
                    : Icon(
                        Icons.check_circle,
                        color: AppColors().green,
                        size: 16.h,
                      )),
        Text(
          text,
          style: context.textTheme.headlineSmall?.copyWith(
              color: initial
                  ? AppColors().fontBlack2
                  : !isValid
                      ? AppColors().red2
                      : AppColors().fontBlack2),
        ).paddingStart(6.w),
      ],
    ).paddingTop(7.h);
  }
}
