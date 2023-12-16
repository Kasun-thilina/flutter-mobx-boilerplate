import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:my_street_merchant/utils/extensions/padding_extensions.dart';

class CustomProgressIndicatorWidget extends StatelessWidget {
  final double? paddingTop;

  const CustomProgressIndicatorWidget({
    Key? key,this.paddingTop
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(color: Color.fromRGBO(250, 250, 250, 0.9)),
        child:
        FittedBox(
          fit: BoxFit.none,
          child: Lottie.asset(
            'assets/animations/loading.json',
            width: 180.w,
            height: 180.w,
            fit: BoxFit.contain,
          ).paddingTop(paddingTop??1),
        ),
      ),
    );
  }
}
