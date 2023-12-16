import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_street_merchant/data/constants/app_colors.dart';
import 'package:my_street_merchant/utils/extensions/context_extensions.dart';

class PanelButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final bool isSelected;
  final Color? selectedColor;
  final Color? textColor;

  const PanelButton({Key? key, required this.text, required this.onTap, this.selectedColor,this.textColor, this.isSelected = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          color: isSelected ? selectedColor ?? AppColors().white : AppColors().white,
          child: InkWell(
            onTap: onTap,
            child: Ink(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 17.h),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  text,
                  style: context.textTheme.headlineMedium?.copyWith(color: textColor??Colors.black),
                ),
              ),
            ),
          ),
        ),
        Divider(
          height: 1,
          thickness: 1,
          color: AppColors().grey4,
        ),
      ],
    );
  }
}
