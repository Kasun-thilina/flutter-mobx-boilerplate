import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_street_merchant/data/constants/app_colors.dart';
import 'package:my_street_merchant/presentation/common_components/empty_widget.dart';
import 'package:my_street_merchant/utils/extensions/context_extensions.dart';
import 'package:my_street_merchant/utils/extensions/padding_extensions.dart';

import '../custom_error_widget.dart';

class PrimaryTextFormField extends StatelessWidget {
  final String? title;
  final String? hint;
  final String? errorText;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextAlign textAlign;
  final int? maxLength;
  final int? maxLines;
  final String? initialValue;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final GestureTapCallback? onTap;
  final TextInputAction? textInputAction;
  final double? height;
  final double? width;
  final Color? fillColor;
  final EdgeInsets? contentPadding;
  final bool isObscure;
  final bool readOnly;
  final bool isError;
  final bool showCustomError;
  final bool showCounter;
  final bool noBorder;
  final BorderRadius? borderRadius;
  final TextStyle? style;

  const PrimaryTextFormField(
      {Key? key,
      this.title,
      this.hint,
      this.errorText,
      this.keyboardType = TextInputType.text,
      this.inputFormatters,
      this.suffixIcon,
      this.prefixIcon,
      this.isObscure = false,
      this.readOnly = false,
      this.isError = false,
      this.noBorder = false,
      this.showCustomError = false,
      this.textAlign = TextAlign.start,
      this.maxLength,
      this.maxLines = 1,
      this.initialValue,
      this.fillColor,
      this.height,
      this.width,
      this.contentPadding,
      this.controller,
      this.textInputAction,
      this.showCounter = false,
      this.onTap,
      this.borderRadius,
      this.style,
      this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // if (controller != null) {
    //   controller!.selection = TextSelection.collapsed(offset: controller!.text.length);
    // }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title != null
            ? Container(
                padding: EdgeInsets.only(bottom: 8.h, left: 1.w),
                child: Text(
                  title!,
                  style: context.textTheme.displaySmall,
                ),
              )
            : fetchEmptyWidget(),
        SizedBox(
          width: width ?? double.infinity,
          child: TextFormField(
            controller: controller,
            cursorColor: AppColors().black,
            initialValue: initialValue,
            // textCapitalization: TextCapitalization.words,
            readOnly: readOnly,
            onTap: onTap,
            obscureText: isObscure,
            keyboardType: keyboardType,
            inputFormatters: inputFormatters,
            onChanged: onChanged,
            textInputAction: textInputAction,
            maxLength: maxLength,
            maxLines: maxLines,
            textAlign: textAlign,
            style: style ?? Theme.of(context).textTheme.headlineSmall,
            decoration: InputDecoration(
                hintText: hint,
                hintStyle: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColors().hintGrey),
                // errorText: showCustomError ? null : errorText,
                errorStyle: context.textTheme.titleSmall?.copyWith(
                    color: AppColors().errorBorderRed, fontWeight: FontWeight.w400, fontSize: 11.sp),
                fillColor:
                    fillColor ?? (readOnly ? AppColors().textFieldDisabledBackground : AppColors().white),
                filled: true,
                isDense: true,
                contentPadding: contentPadding,
                counterText: isError?"": !showCounter ? "" : null,
                counterStyle: context.textTheme.headlineSmall?.copyWith(color: AppColors().fontLightGrey),
                border: noBorder? InputBorder.none: OutlineInputBorder(
                    borderRadius: borderRadius ?? BorderRadius.circular(7),
                    borderSide: BorderSide(color: !isError ? AppColors().grey : AppColors().red)),
                focusedBorder: noBorder? InputBorder.none:  OutlineInputBorder(
                  borderRadius: borderRadius ?? BorderRadius.circular(7),
                  borderSide: BorderSide(
                    color: !isError
                        ? readOnly
                            ? AppColors().grey
                            : AppColors().primaryColor
                        : AppColors().red,
                  ),
                ),
                enabledBorder: noBorder? InputBorder.none:  OutlineInputBorder(
                  borderRadius: borderRadius ?? BorderRadius.circular(7),
                  borderSide: BorderSide(
                    color: !isError ? AppColors().grey : AppColors().red,
                  ),
                ),
                prefixIcon: prefixIcon,
                suffixIcon: suffixIcon),
          ),
        ),
        showCustomError
            ? CustomErrorWidget(
                hiddenHeight: 0,
                isError: showCustomError && isError,
                paddingTop: 10.h,
                errorText: errorText,
              )
            : errorText != null && isError
                ? Text(
                    errorText!,
                    style: context.textTheme.titleSmall?.copyWith(
                        color: AppColors().errorBorderRed, fontWeight: FontWeight.w400, fontSize: 11.sp),
                  ).paddingTop(5.h)
                : fetchEmptyWidget(),
      ],
    );
  }
}
