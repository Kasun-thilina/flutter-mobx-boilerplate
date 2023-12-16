import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_street_merchant/data/constants/app_colors.dart';
import 'package:my_street_merchant/presentation/common_components/empty_widget.dart';
import 'package:my_street_merchant/utils/extensions/context_extensions.dart';
import 'package:my_street_merchant/utils/extensions/padding_extensions.dart';

class TabButton extends StatelessWidget {
  final String text;
  final bool isEnabled;
  final VoidCallback onTap;
  final double? horizontalPadding;
  final int? count;

  const TabButton(
      {Key? key,
      required this.text,
      required this.onTap,
      required this.isEnabled,
      this.horizontalPadding,
      this.count,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 40.h,
          decoration: BoxDecoration(
              gradient: isEnabled
                  ? LinearGradient(
                      begin: const Alignment(0, -1),
                      end: const Alignment(0, 0),
                      colors: <Color>[
                        AppColors().primaryColor,
                        AppColors().blue,
                      ],
                    )
                  : null,
              borderRadius: const BorderRadius.all(Radius.circular(30))),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                elevation: 0,
                padding: EdgeInsets.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(30.r),
                  ),
                )),
            onPressed: onTap,
            child: Text(
              text,
              style: context.textTheme.displayMedium?.copyWith(
                  fontSize: 16.sp,
                  color: isEnabled ? AppColors().white : AppColors().lightBlue.withOpacity(0.5),
                  fontWeight: FontWeight.w600),
            ).paddingSymmetric(horizontal: horizontalPadding ?? 16.w),
          ),
        ).paddingTop(7.h),
        count != null
            ? count != 0
                ? Positioned(
                    right: 4.w,
                    child: Container(
                      decoration: BoxDecoration(
                          color: isEnabled ? AppColors().red3 : AppColors().black,
                          borderRadius: BorderRadius.circular(7)),
                      child: Text(
                        "${count! < 10 ? "0" : ""}$count",
                        style: context.textTheme.bodyMedium?.copyWith(fontSize: 10.sp, color: AppColors().white),
                      ).paddingSymmetric(horizontal: 5.w),
                    ),
                  )
                : fetchEmptyWidget()
            : fetchEmptyWidget(),
      ],
    );
  }
}
