import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/constants/app_colors.dart';

class GradientBackground extends StatelessWidget {
  final Widget child;

  const GradientBackground({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      height: 1.sh,
      decoration: BoxDecoration(
          gradient: LinearGradient(
        begin: const Alignment(0, -1),
        end: const Alignment(0, -0.6),
        colors: <Color>[
          AppColors().mainPageGradient2,
          AppColors().mainPageGradient2,
          AppColors().mainPageGradient1,
          AppColors().backgroundColor,
        ],
      )),
      child: child,
    );
  }
}
