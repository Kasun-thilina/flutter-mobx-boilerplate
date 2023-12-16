import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_street_merchant/data/constants/app_colors.dart';
import 'package:my_street_merchant/utils/extensions/context_extensions.dart';
import 'package:my_street_merchant/utils/extensions/padding_extensions.dart';

class CustomBackButton extends StatelessWidget {
  final String text;
  final double? paddingVertical;
  final double? paddingHorizontal;
  final VoidCallback? onTap;

  const CustomBackButton({Key? key, required this.text, this.onTap, this.paddingVertical, this.paddingHorizontal})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IconButton(
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
          icon: Icon(
            Icons.arrow_back,
            color: AppColors().black,
            size: 25.h,
          ),
          onPressed: onTap ??
              () {
                Navigator.pop(context);
              },
        ).paddingTop(15.h),
        Text(
          text,
          style: context.textTheme.displayLarge,
        ).paddingStart(5.w)
      ],
    ).paddingSymmetric(vertical: paddingVertical ?? 35.h, horizontal: paddingHorizontal ?? 22.w);
  }
}
