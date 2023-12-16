import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_street_merchant/data/constants/app_colors.dart';
import 'package:my_street_merchant/utils/extensions/context_extensions.dart';
import 'package:my_street_merchant/utils/extensions/padding_extensions.dart';

class TextSwitch extends StatelessWidget {
  final String text;
  final bool value;
  final Color? color;
  final EdgeInsets? padding;
  final ValueChanged<bool>? onChanged;

  const TextSwitch(
      {Key? key, required this.text, required this.value, required this.onChanged, this.color, this.padding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color ?? AppColors().white,
      padding: padding ?? EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: context.textTheme.bodyMedium?.copyWith(color: AppColors().black),
          ),
          CupertinoSwitch(value: value, activeColor: AppColors().primaryColor, onChanged: onChanged).paddingStart(10.w)
        ],
      ),
    );
  }
}
