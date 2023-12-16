import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_street_merchant/data/constants/app_colors.dart';
import 'package:my_street_merchant/presentation/common_components/empty_widget.dart';
import 'package:my_street_merchant/utils/extensions/padding_extensions.dart';

class NavIcon extends StatelessWidget {
  final String icon;
  final int? notificationCount;
  final bool isUnselected;
  final EdgeInsetsGeometry? padding;

  const NavIcon({Key? key, required this.icon, this.notificationCount, this.padding, this.isUnselected = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(padding: EdgeInsets.only(top: 8.h,right: isUnselected? 4.w:0), child: Image.asset(icon)),
        notificationCount != null
            ? Positioned(
                right:  0,
                top:  5.h,
                child: Container(
                  decoration:
                      BoxDecoration(color: AppColors().red3, borderRadius: const BorderRadius.all(Radius.circular(20))),
                  child: Text(
                    "$notificationCount",
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(fontSize: 7.sp, color: Colors.white),
                  ).paddingSymmetric(horizontal: 7.w, vertical: 2.h),
                ).paddingOnly(left: 15.w),
              )
            : fetchEmptyWidget()
      ],
    );
  }
}
