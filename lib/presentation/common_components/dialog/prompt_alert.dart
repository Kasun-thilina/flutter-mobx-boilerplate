import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_street_merchant/data/constants/app_colors.dart';
import 'package:my_street_merchant/data/constants/icons.dart';
import 'package:my_street_merchant/presentation/common_components/empty_widget.dart';
import 'package:my_street_merchant/utils/extensions/context_extensions.dart';
import 'package:my_street_merchant/utils/extensions/padding_extensions.dart';
import 'package:my_street_merchant/utils/hex_color.dart';

showPromptAlert(
  BuildContext context, {
  required String positiveMsg,
  required String negativeMsg,
  bool showTopIcon = true,
  bool barrierDismissible = false,
  Widget? topIcon,
  Widget? child,
  String? title,
  String? text,
  Color? positiveButtonColor,
  VoidCallback? onPositivePressed,
  VoidCallback? onNegativePressed,
}) {
  showGeneralDialog(
    context: context,
    barrierLabel: "Barrier",
    barrierDismissible: barrierDismissible,
    barrierColor: Colors.black.withOpacity(0.6),
    transitionDuration: const Duration(milliseconds: 200),
    pageBuilder: (_, __, ___) {
      return Center(
        child: Container(
          // height: 258.h,
          width: 330.w,
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20.r)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              showTopIcon
                  ? topIcon ?? Image.asset(AssetIcons.warningIcon2).paddingTop(20.h)
                  : SizedBox(
                      height: 20.h,
                    ),
              Text(
                title ?? context.strings.error,
                style: context.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w600, color: AppColors().grey14),
                textAlign: TextAlign.center,
              ).paddingTop(17.h).paddingSymmetric(horizontal: 20.w),
              text != null
                  ? Text(
                      text,
                      textAlign: TextAlign.center,
                      style: context.textTheme.headlineMedium?.copyWith(
                        fontSize: 12.sp,
                      ),
                    ).paddingSymmetric(horizontal: 20.w).paddingTop(15.h).paddingBottom(10.h)
                  : fetchEmptyWidget().paddingTop(12.h),
              child ?? fetchEmptyWidget(),
              Divider(
                height: 1,
                thickness: 1,
                color: AppColors().grey.withOpacity(0.7),
              ).paddingSymmetric(vertical: 15.h, horizontal: 20.w),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: positiveButtonColor ?? AppColors().red3,
                          disabledBackgroundColor: AppColors().primaryColor.withOpacity(0.5),
                          elevation: 0,
                          foregroundColor: AppColors().lightBlue2,
                          shadowColor: Colors.transparent,
                          minimumSize: Size(130.w, 40.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(40.r),
                            ),
                          )),
                      onPressed: onPositivePressed ??
                          () {
                            Navigator.pop(context);
                          },
                      child: Text(
                        positiveMsg,
                        style: context.textTheme.bodyLarge
                            ?.copyWith(fontWeight: FontWeight.w600, fontSize: 16.sp, color: AppColors().white),
                      ),
                    ),
                  ),
                  Flexible(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors().backgroundColor,
                          disabledBackgroundColor: AppColors().primaryColor.withOpacity(0.5),
                          elevation: 0,
                          foregroundColor: AppColors().lightBlue2,
                          shadowColor: Colors.transparent,
                          minimumSize: Size(130.w, 40.h),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                                width: 1, // thickness
                                color: AppColors().grey3),
                            borderRadius: BorderRadius.all(
                              Radius.circular(40.r),
                            ),
                          )),
                      onPressed: onNegativePressed ??
                          () {
                            Navigator.pop(context);
                          },
                      child: Text(
                        negativeMsg,
                        style: context.textTheme.bodyLarge
                            ?.copyWith(fontWeight: FontWeight.w600, fontSize: 16.sp, color: HexColor("#787878")),
                      ),
                    ),
                  )
                ],
              ).paddingBottom(15.h)
            ],
          ),
        ),
      );
    },
    transitionBuilder: (context, a1, a2, widget) {
      return Transform.scale(
        scale: a1.value,
        child: Opacity(
          opacity: a1.value,
          child: widget,
        ),
      );
    },
  );
}
