import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_street_merchant/data/constants/app_colors.dart';
import 'package:my_street_merchant/presentation/common_components/empty_widget.dart';

class CircleIcon extends StatelessWidget {
  final Color? backgroundColor;
  final Color? iconColor;
  final IconData? iconData;
  final String? assetIcon;

  const CircleIcon({
    Key? key,
    this.iconData,
    this.backgroundColor,
    this.iconColor,
    this.assetIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(shape: BoxShape.circle, color: backgroundColor ?? AppColors().lightBlue17),
        width: 50.w,
        height: 50.w,
        child: iconData != null
            ? Icon(iconData, color: iconColor ?? AppColors().primaryColor)
            : assetIcon != null
                ? Image.asset(assetIcon!)
                : fetchEmptyWidget());
  }
}
