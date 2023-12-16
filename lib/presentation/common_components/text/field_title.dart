import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_street_merchant/utils/extensions/context_extensions.dart';
import 'package:my_street_merchant/utils/extensions/padding_extensions.dart';

import '../../../data/constants/app_colors.dart';

class FieldTitle extends StatelessWidget {
  final String text;
  final double? fontSize;
  final Color? textColor;
  final double? topPadding;

  const FieldTitle({Key? key, required this.text, this.textColor, this.topPadding, this.fontSize}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text,
            style: context.textTheme.displaySmall
                ?.copyWith(color: textColor ?? AppColors().fontGrey, fontSize: fontSize ?? 13.sp))
        .paddingStart(2.w)
        .paddingTop(topPadding ?? 30.h)
        .paddingBottom(10.h);
  }
}
