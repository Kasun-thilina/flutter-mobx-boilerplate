import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_street_merchant/presentation/common_components/empty_widget.dart';
import 'package:my_street_merchant/utils/extensions/context_extensions.dart';
import 'package:my_street_merchant/utils/extensions/padding_extensions.dart';
import 'package:my_street_merchant/utils/extensions/string_extensions.dart';

import '../../../data/constants/app_colors.dart';

class FieldText extends StatefulWidget {
  final String text;
  final Color? textColor;

  const FieldText({Key? key, required this.text, this.textColor}) : super(key: key);

  @override
  State<FieldText> createState() => _FieldText();
}

class _FieldText extends State<FieldText> {
  bool isViewMore = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors().blueGradient1,
          borderRadius: BorderRadius.circular(7),
          border: Border.all(
            color: AppColors().grey,
          )),
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(isViewMore ? widget.text : widget.text.trimIfLong(80),
              style: context.textTheme.headlineSmall?.copyWith(color: widget.textColor ?? AppColors().fontBlack2)),
          widget.text.length > 80
              ? !isViewMore
                  ? GestureDetector(
                      onTap: () {
                        setState(() {
                          isViewMore = true;
                        });
                      },
                      child: Text(
                        context.strings.viewMore,
                        style: context.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w700,
                            decoration: TextDecoration.underline,
                            color: AppColors().primaryColor),
                      ).paddingTop(5),
                    )
                  : fetchEmptyWidget()
              : fetchEmptyWidget(),
          isViewMore
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      isViewMore = false;
                    });
                  },
                  child: Text(
                    context.strings.viewLess,
                    style: context.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                        decoration: TextDecoration.underline,
                        color: AppColors().primaryColor),
                  ).paddingTop(5),
                )
              : fetchEmptyWidget()
        ],
      ),
    ).paddingStart(2.w).paddingBottom(10.h);
  }
}
