import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../data/constants/app_colors.dart';
import '../../data/constants/icons.dart';

class PullToRefreshWidget extends StatelessWidget {
  final RefreshController refreshController;
  final Widget child;
  final VoidCallback? onRefresh;

  const PullToRefreshWidget(
      {Key? key, required this.refreshController, required this.child, required this.onRefresh})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: refreshController,
      enablePullDown: true,
      onRefresh: onRefresh,
      header: WaterDropHeader(
        waterDropColor: AppColors().primaryColor,
        idleIcon: Image.asset(
          AssetIcons.appLogo,
          width: 22.w,
          height: 22.h,
        ),
        complete: const Text(""),
      ),
      child: child,
    );
  }
}
