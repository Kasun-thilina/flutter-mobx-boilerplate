import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_street_merchant/data/constants/app_colors.dart';
import 'package:my_street_merchant/presentation/common_components/buttons/primary_button.dart';
import 'package:my_street_merchant/presentation/common_components/empty_widget.dart';
import 'package:my_street_merchant/utils/extensions/context_extensions.dart';
import 'package:my_street_merchant/utils/extensions/padding_extensions.dart';

import '../../../data/constants/images.dart';

///Popup with image
showCustomPopup(
  BuildContext context, {
  String? positiveMsg,
  String? title,
  String? text,
  VoidCallback? onPressed,
}) {
  showGeneralDialog(
    context: context,
    barrierLabel: "Barrier",
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.6),
    transitionDuration: const Duration(milliseconds: 200),
    pageBuilder: (_, __, ___) {
      return Center(
        child: Container(
          height: 340.h,
          width: 330.w,
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20.r)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              title != null
                  ? Text(
                      title,
                      style: context.textTheme.headlineMedium
                          ?.copyWith(fontWeight: FontWeight.w600, color: AppColors().fontBlack),
                    ).paddingTop(25.h)
                  : fetchEmptyWidget(),
              // Image.asset(
              //   AssetImages.successTick,
              //   height: 85.h,
              // ),
              text != null
                  ? Text(
                      text,
                      style: context.textTheme.headlineMedium?.copyWith(color: AppColors().fontBlack, fontSize: 12.sp),
                      textAlign: TextAlign.center,
                    ).paddingTop(5.h).paddingSymmetric(horizontal: 40.w)
                  : fetchEmptyWidget(),
              positiveMsg != null
                  ? PrimaryButton(
                      title: positiveMsg,
                      paddingVertical: 10.h,
                      onPressed: () {
                        Navigator.of(context, rootNavigator: true).pop();
                      },
                    ).paddingBottom(20.h)
                  : fetchEmptyWidget(),
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
