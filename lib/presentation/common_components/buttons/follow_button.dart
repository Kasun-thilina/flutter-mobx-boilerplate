import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_street_merchant/data/constants/app_colors.dart';
import 'package:my_street_merchant/presentation/common_components/buttons/ripple_button.dart';
import 'package:my_street_merchant/utils/extensions/context_extensions.dart';
import 'package:my_street_merchant/utils/extensions/padding_extensions.dart';

class FollowButton extends StatelessWidget {
  final bool isFollowing;
  final VoidCallback onTap;

  const FollowButton({Key? key, required this.isFollowing, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RippleButton(
        onTap: onTap,
        color: AppColors().lightGreen4,
        borderRadius: 30,
        paddingVertical: 4.w,
        paddingHorizontal: 8.h,
        child: Row(
          children: [
            Icon(
              Icons.check,
              color: AppColors().green3,
              size: 13,
            ),
            Text(
              isFollowing ? context.strings.following : context.strings.follow,
              style: context.textTheme.bodyMedium?.copyWith(color: AppColors().green3, fontSize: 12.sp),
            ).paddingStart(5.w).paddingEnd(3.w)
          ],
        ));
  }
}
