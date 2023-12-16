import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_street_merchant/data/constants/app_colors.dart';
import 'package:my_street_merchant/utils/extensions/context_extensions.dart';
import 'package:my_street_merchant/utils/extensions/padding_extensions.dart';

class BulletText extends StatelessWidget {
  final String text;

  const BulletText({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "\u2022 ",
          style: context.textTheme.displayMedium?.copyWith(color: AppColors().lightBlue),
        ),
        Expanded(
          child: Text(
            text,
            style: context.textTheme.headlineSmall,
          ).paddingTop(5.h).paddingStart(5.w),
        )
      ],
    );
  }
}
