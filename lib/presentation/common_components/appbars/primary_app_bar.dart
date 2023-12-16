import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_street_merchant/data/constants/app_colors.dart';
import 'package:my_street_merchant/presentation/common_components/empty_widget.dart';
import 'package:my_street_merchant/utils/extensions/context_extensions.dart';

class PrimaryAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool canGoBack;
  final VoidCallback? onBackPressed;
  final List<Widget>? actions;

  const PrimaryAppBar({Key? key, this.title = "", this.onBackPressed, this.actions, this.canGoBack = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: context.textTheme.displayLarge?.copyWith(color: AppColors().black, fontSize: 16.sp),
      ),
      leading: canGoBack
          ? GestureDetector(
              onTap: onBackPressed ??
                  () {
                    if (ModalRoute.of(context)?.isFirst != null) {
                      if (!ModalRoute.of(context)!.isFirst) {
                        Navigator.of(context).pop();
                      }
                    }
                  },
              child: Icon(
                Icons.arrow_back,
                color: AppColors().black,
                size: 25.h,
              ),
            )
          : fetchEmptyWidget(),
      centerTitle: true,
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.light,
          systemNavigationBarColor: AppColors().white,
          systemNavigationBarIconBrightness: Brightness.dark),
      iconTheme: IconThemeData(color: AppColors().black),
      elevation: 0,
      // backgroundColor: HexColor("#F6F6F6"),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size(double.infinity, AppBar().preferredSize.height);
}
