import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_street_merchant/presentation/common_components/empty_widget.dart';
import 'package:my_street_merchant/utils/extensions/context_extensions.dart';
import 'package:my_street_merchant/utils/extensions/padding_extensions.dart';

import '../../data/constants/app_colors.dart';

///Notification icon to be placed with gradiant background
class NotificationIcon extends StatelessWidget {
  final int count;

  const NotificationIcon({
    Key? key,
    required this.count,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Icon(
          Icons.notifications,
          color: Colors.black,
        ).paddingEnd(3.w),
        count != 0
            ? Positioned(
                right: 0,
                top: 2.w,
                child: Container(
                  decoration: BoxDecoration(color: AppColors().red3, borderRadius: BorderRadius.circular(20)),
                  padding: EdgeInsets.only(left: 5.w, right: 5.w, bottom: 1.h),
                  alignment: Alignment.center,
                  child: Text(
                    "$count",
                    style: context.textTheme.displayMedium?.copyWith(
                      fontSize: 8.sp,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            : fetchEmptyWidget(),
      ],
    ).paddingTop(15.h);
  }
}
