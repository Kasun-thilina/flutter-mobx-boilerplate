import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_street_merchant/utils/extensions/context_extensions.dart';
import 'package:my_street_merchant/utils/extensions/padding_extensions.dart';
import 'package:styled_text/styled_text.dart';

import '../../data/constants/app_colors.dart';
import '../../data/constants/icons.dart';

class CustomErrorWidget extends StatelessWidget {
  final bool isError;
  final String? errorText;
  final double? hiddenHeight;
  final double? paddingTop;
  final Widget? customWidget;

  const CustomErrorWidget(
      {Key? key, required this.isError, this.errorText, this.customWidget, this.hiddenHeight, this.paddingTop})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: isError
          ? Container(
              key: const Key("errormsg"),
              decoration:
                  BoxDecoration(color: AppColors().warningRed, borderRadius: BorderRadius.all(Radius.circular(10.r))),
              padding: EdgeInsets.only(left: 20.w),
              child: IntrinsicHeight(
                child: Row(
                  children: [
                    Image.asset(AssetIcons.warningIcon),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            context.strings.error,
                            style: context.textTheme.headlineSmall
                                ?.copyWith(fontWeight: FontWeight.w600, color: AppColors().red),
                          ),
                          Expanded(
                              child: customWidget != null
                                  ? customWidget!
                                  : StyledText(
                                      text: errorText ?? "",
                                      style: context.textTheme.titleSmall
                                          ?.copyWith(color: AppColors().grey2, fontWeight: FontWeight.w400),
                                      tags: {
                                        'bold': StyledTextTag(
                                            style: context.textTheme.titleSmall
                                                ?.copyWith(color: AppColors().grey2, fontWeight: FontWeight.w700)),
                                      },
                                    )),
                        ],
                      ).paddingStart(15.w),
                    )
                  ],
                ).paddingSymmetric(vertical: 15.h),
              ),
            ).paddingTop(paddingTop ?? 35.h)
          : SizedBox(
              key: const Key("sizedbox"),
              height: hiddenHeight ?? 90.h,
            ),
    );
  }
}
