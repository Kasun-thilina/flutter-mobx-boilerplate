import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_street_merchant/data/constants/app_colors.dart';
import 'package:my_street_merchant/presentation/common_components/textfields/primary_textfield.dart';

class TextFieldWithSuffix extends StatelessWidget {
  final String title;
  final String suffix;
  final ValueChanged<String>? onChanged;

  const TextFieldWithSuffix({Key? key, required this.title, required this.suffix, this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        children: [
          PrimaryTextFormField(
            title: title,
            width: 65.w,
            maxLength: 6,
            keyboardType: TextInputType.number,
            onChanged: onChanged,
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(7), bottomLeft: Radius.circular(7)),
          ),
          PrimaryTextFormField(
            width: 43.w,
            title: "",
            readOnly: true,
            initialValue: suffix,
            fillColor: AppColors().white,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: AppColors().grey10),
            borderRadius: const BorderRadius.only(topRight: Radius.circular(7), bottomRight: Radius.circular(7)),
          ),
        ],
      ),
    );
  }
}
