import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_street_merchant/data/constants/app_colors.dart';
import 'package:my_street_merchant/presentation/common_components/empty_widget.dart';
import 'package:my_street_merchant/utils/extensions/context_extensions.dart';
import 'package:my_street_merchant/utils/extensions/padding_extensions.dart';

showSuccessDialog(BuildContext context, {
  required String positiveMsg,
  String? title,
  String? text,
  String? image,
  Widget? customWidget,
  VoidCallback? onPressed,
}) {
  showGeneralDialog(
    context: context,
    barrierLabel: "Barrier",
    barrierDismissible: false,
    barrierColor: Colors.black.withOpacity(0.6),
    transitionDuration: const Duration(milliseconds: 200),
    pageBuilder: (_, __, ___) {
      return Center(
        child: Container(
          // height: 360.h,
          width: 336.w,
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20.r)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
             image!=null?  Image.asset(image).paddingTop(30.h):Container(
                width: 130.h,
                height: 130.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors().lightBlue,
                ),
                alignment: Alignment.center,
                child: Icon(
                  Icons.check,
                  color: AppColors().white,
                  size: 70.h,
                ),
              ).paddingTop(30.h),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title ?? context.strings.goodNews,
                    style: context.textTheme.headlineMedium
                        ?.copyWith(fontWeight: FontWeight.w700, color: AppColors().fontBlack),
                    textAlign: TextAlign.center,
                  ).paddingTop(25.h),
                  Text(
                    text??"",
                    style: context.textTheme.headlineSmall
                        ?.copyWith(fontWeight: FontWeight.w600, color: AppColors().fontBlack),
                    textAlign: TextAlign.center,
                  ).paddingTop(5.h),
                  customWidget ?? fetchEmptyWidget()
                ],
              ).paddingSymmetric(horizontal: 40.w),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors().lightBlue2.withOpacity(0.5),
                    disabledBackgroundColor: AppColors().primaryColor.withOpacity(0.5),
                    elevation: 0,
                    foregroundColor: AppColors().lightBlue2,
                    shadowColor: Colors.transparent,
                    minimumSize: Size(175.w, 40.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(40.r),
                      ),
                    )),
                onPressed: onPressed ??
                        () {
                      Navigator.pop(context);
                    },
                child: Text(
                  positiveMsg,
                  style: context.textTheme.bodyLarge
                      ?.copyWith(fontWeight: FontWeight.w600, fontSize: 16.sp, color: AppColors().lightBlue),
                ),
              ).paddingTop(25.h).paddingBottom(30.h)
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
