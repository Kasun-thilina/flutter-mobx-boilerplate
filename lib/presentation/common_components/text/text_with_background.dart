import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextWithBackground extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final Color? color;
  final double radius;
  final double? paddingHorizontal;

  const TextWithBackground({Key? key, required this.text, this.style, this.color, this.paddingHorizontal, this.radius = 5}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(radius)), color: color),
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: paddingHorizontal??10.w),
      child: Text(
        text,
        style: style,
      ),
    );
  }
}
