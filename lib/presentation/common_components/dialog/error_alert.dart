import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_street_merchant/data/constants/app_colors.dart';
import 'package:my_street_merchant/data/constants/icons.dart';
import 'package:my_street_merchant/presentation/common_components/empty_widget.dart';
import 'package:my_street_merchant/utils/extensions/context_extensions.dart';
import 'package:my_street_merchant/utils/extensions/padding_extensions.dart';
import 'package:styled_text/styled_text.dart';

import '../../../generated/l10n.dart';
import '../../../utils/navigator_service.dart';
import '../routes.dart';

bool _isDialogShowing = false;
showErrorAlert(
  BuildContext context, {
  required String actionText,
  String? title,
  Widget? topIcon,
  String? text,
  VoidCallback? onPressed,
}) {
  _isDialogShowing=true;
  _isDialogShowing
      ? showGeneralDialog(
          context: context,
          barrierLabel: "Barrier",
          barrierDismissible: true,
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
                    topIcon ?? Image.asset(AssetIcons.warningIcon2).paddingTop(20.h),
                    Text(
                      title ?? context.strings.error,
                      style: context.textTheme.headlineMedium
                          ?.copyWith(fontWeight: FontWeight.w600, color: AppColors().fontBlack),
                    ).paddingTop(18.h),
                    text != null
                        ? StyledText(
                            text: text,
                            textAlign: TextAlign.center,
                            style: context.textTheme.titleSmall
                                ?.copyWith(color: AppColors().grey2, fontWeight: FontWeight.w400),
                            tags: {
                              'bold': StyledTextTag(
                                  style: context.textTheme.titleSmall
                                      ?.copyWith(color: AppColors().grey2, fontWeight: FontWeight.w600)),
                            },
                          ).paddingOnly(top: 15.h, left: 22.w, right: 22.w)
                        : fetchEmptyWidget(),
                    Divider(
                      height: 1,
                      thickness: 1,
                      color: AppColors().grey.withOpacity(0.7),
                    ).paddingSymmetric(vertical: 18.h, horizontal: 20.w),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors().red3,
                          disabledBackgroundColor: AppColors().primaryColor.withOpacity(0.5),
                          elevation: 0,
                          foregroundColor: AppColors().lightBlue2,
                          shadowColor: Colors.transparent,
                          minimumSize: Size(175.w, 42.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(40.r),
                            ),
                          )),
                      onPressed: () {
                        if (text == S.current.authorizationError) {
                          NavigationService().navigationKey?.currentState?.pop(context);
                          NavigationService().navigationKey?.currentState?.pushReplacementNamed(AppRouter.signInScreen);
                        } else {
                          if (onPressed != null) {
                            _isDialogShowing = false;
                            onPressed();
                          } else {
                            _isDialogShowing = false;
                            Navigator.of(context).pop();
                          }
                        }
                      },
                      child: Text(
                        text == S.current.authorizationError || text == S.current.noNetwork ? S.current.ok : actionText,
                        style: context.textTheme.bodyLarge
                            ?.copyWith(fontWeight: FontWeight.w600, fontSize: 16.sp, color: AppColors().white),
                      ),
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
        )
      : null;
}
