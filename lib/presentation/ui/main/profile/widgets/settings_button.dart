import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_street_merchant/data/constants/app_colors.dart';
import 'package:my_street_merchant/presentation/common_components/buttons/ripple_button.dart';
import 'package:my_street_merchant/presentation/common_components/empty_widget.dart';
import 'package:my_street_merchant/utils/extensions/context_extensions.dart';
import 'package:my_street_merchant/utils/extensions/padding_extensions.dart';

class SettingsButton extends StatelessWidget {
  final String title;
  final String? assetIcon;
  final IconData? icon;
  final VoidCallback onTap;
  final bool isTop;
  final bool isBottom;

  const SettingsButton({
    Key? key,
    required this.title,
    required this.onTap,
    this.assetIcon,
    this.icon,
    this.isTop = false,
    this.isBottom = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RippleButton(
        onTap: onTap,
        color: AppColors().white,
        isCustomRadius: true,
        topRightRadius: isTop ? 30 : 0,
        topLeftRadius: isTop ? 30 : 0,
        bottomRightRadius: isBottom ? 30 : 0,
        bottomLeftRadius: isBottom ? 30 : 0,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                        decoration:
                            BoxDecoration(color: AppColors().backgroundColor2, borderRadius: BorderRadius.circular(10)),
                        height: 40.w,
                        width: 40.w,
                        child: icon != null
                            ? Icon(
                                icon,
                                color: AppColors().lightBlue,
                              )
                            : assetIcon != null
                                ? Image.asset(assetIcon!)
                                : fetchEmptyWidget()),
                    Text(
                      title,
                      style: context.textTheme.bodyMedium?.copyWith(fontSize: 15.sp, color: AppColors().grey10),
                    ).paddingStart(20.w),
                  ],
                ),
                Icon(
                  Icons.arrow_forward_ios_outlined,
                  color: AppColors().grey17,
                  size: 12,
                )
              ],
            )
                .paddingSymmetric(
                  horizontal: 30.w,
                )
                .paddingTop(13.h),
            Divider(
              height: 1,
              thickness: 1,
              color: AppColors().grey4,
            ).paddingTop(13.h)
          ],
        ));
  }
}
