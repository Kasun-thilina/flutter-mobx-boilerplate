import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_street_merchant/data/constants/app_colors.dart';
import 'package:my_street_merchant/presentation/common_components/appbars/primary_app_bar.dart';
import 'package:my_street_merchant/presentation/common_components/empty_widget.dart';
import 'package:my_street_merchant/utils/extensions/context_extensions.dart';

class CupertinoAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool canGoBack;
  final VoidCallback? onBackPressed;
  final List<Widget>? actions;
  final Widget body;

  const CupertinoAppBar(
      {Key? key, required this.body, this.title = "", this.onBackPressed, this.actions, this.canGoBack = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mySystemTheme = SystemUiOverlayStyle.dark.copyWith(
        systemNavigationBarColor: AppColors().white, systemNavigationBarIconBrightness: Brightness.dark);
    SystemChrome.setSystemUIOverlayStyle(mySystemTheme);
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize:Size.fromHeight(0),
        child: PrimaryAppBar(
          canGoBack: false,
        ),
      ),
      body:  CupertinoTheme(
          data: CupertinoThemeData(
            textTheme: CupertinoTextThemeData(
              navLargeTitleTextStyle: context.textTheme.displayLarge,
              navTitleTextStyle: context.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            barBackgroundColor: AppColors().backgroundColor,
            scaffoldBackgroundColor: AppColors().backgroundColor,
            brightness: Brightness.dark
          ),
          child: CupertinoPageScaffold(
              child: NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return [
                CupertinoSliverNavigationBar(
                  padding: EdgeInsetsDirectional.zero,
                  border: Border.all(color: AppColors().backgroundColor),
                  leading: canGoBack
                      ? Material(
                        child: IconButton(
                            icon: Icon(
                              Icons.arrow_back,
                              color: AppColors().black,
                              size: 25.h,
                            ),
                            onPressed: onBackPressed ??
                                () {
                                  if (ModalRoute.of(context)?.isFirst != null) {
                                    if (!ModalRoute.of(context)!.isFirst) {
                                      Navigator.of(context).pop();
                                    }
                                  }
                                }),
                      )
                      : fetchEmptyWidget(),
                  trailing: actions != null
                      ? Row(
                          children: actions!,
                        )
                      : fetchEmptyWidget(),
                  largeTitle: Text(
                    title,
                  ),
                )
              ];
            },
            body: body,
          ))),
    );
  }

  @override
  Size get preferredSize => Size(double.infinity, AppBar().preferredSize.height);
}
