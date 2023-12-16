import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_street_merchant/utils/extensions/context_extensions.dart';
import 'package:my_street_merchant/utils/extensions/padding_extensions.dart';

import '../../data/constants/app_colors.dart';

/// Info / important message
class InfoMessage extends StatelessWidget {
  final String? title;
  final String content;
  final Widget? child;

  const InfoMessage({Key? key, this.title, required this.content, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(color: AppColors().backgroundYellow, borderRadius: const BorderRadius.all(Radius.circular(10))),
      alignment: Alignment.center,
      child: Row(
        children: [
          Icon(
            Icons.info_rounded,
            color: AppColors().grey14,
            size: 37.h,
          ).paddingOnly(left: 20.w, right: 17.w),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title ?? "Important",
                  style: context.textTheme.bodyMedium?.copyWith(color: AppColors().grey14),
                ).paddingTop(14.h),
                child != null
                    ? child!
                    : Text(
                        content,
                        style: context.textTheme.headlineSmall?.copyWith(fontSize: 12.sp, color: AppColors().grey2),
                      ).paddingTop(5.h).paddingEnd(10.w).paddingBottom(14.h),
              ],
            ),
          )
        ],
      ),
    );
  }
}
