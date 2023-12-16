import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_street_merchant/data/constants/app_colors.dart';

class CircleButton extends StatelessWidget {
 final Widget child;
 final VoidCallback onPressed;

  const CircleButton({Key? key,required this.child,required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 30.w, bottom: 20.h),
      child: Material(
        elevation: 2,
        clipBehavior: Clip.antiAlias,
        shape: const CircleBorder(),
        color: Colors.transparent,
        child: Ink(
          width: 26.w,
          height: 26.w,
          decoration: BoxDecoration(
            color: AppColors().white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                offset: const Offset(1, 1),
                blurRadius: 5,
                color: Colors.black.withOpacity(0.3),
              ),
            ],
          ),
          child: InkWell(
            onTap: onPressed,
            child: child,
          ),
        ),
      ),
    );
  }
}
