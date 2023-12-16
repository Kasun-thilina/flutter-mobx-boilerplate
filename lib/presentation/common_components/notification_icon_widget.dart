import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_street_merchant/utils/extensions/context_extensions.dart';
import 'package:my_street_merchant/utils/extensions/padding_extensions.dart';

import '../../data/constants/app_colors.dart';
import '../stores/main/profile/profile_store.dart';

///Only the notification icon
class NotificationIconWidget extends StatelessWidget {
  final ProfileStore profileStore;

  const NotificationIconWidget({
    Key? key,
    required this.profileStore,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
        right: 16.w,
        top: MediaQuery.of(context).viewPadding.top + 20.h,
        child: InkWell(
          onTap: () {
          },
          child: Observer(builder: (context) {
            return Stack(
              children: [
                const Icon(
                  Icons.notifications,
                  color: Colors.black,
                ).paddingEnd(3.w),
                Positioned(
                        right: 0,
                        top: 2.w,
                        child: Container(
                          decoration:
                              BoxDecoration(color: AppColors().red3, borderRadius: BorderRadius.circular(20)),
                          padding: EdgeInsets.only(left: 5.w, right: 5.w, bottom: 1.h),
                          alignment: Alignment.center,
                          child: Text(
                            "3",
                            style: context.textTheme.displayMedium?.copyWith(
                              fontSize: 8.sp,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
              ],
            );
          }),
        ));
  }
}
