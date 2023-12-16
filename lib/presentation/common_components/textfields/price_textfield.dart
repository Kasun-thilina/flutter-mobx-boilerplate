import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_street_merchant/data/constants/app_colors.dart';
import 'package:my_street_merchant/presentation/common_components/empty_widget.dart';
import 'package:my_street_merchant/presentation/common_components/textfields/primary_textfield.dart';
import 'package:my_street_merchant/utils/extensions/common_extensions.dart';
import 'package:my_street_merchant/utils/extensions/context_extensions.dart';
import 'package:my_street_merchant/utils/extensions/padding_extensions.dart';
import 'package:my_street_merchant/utils/extensions/string_extensions.dart';

import '../../../utils/sharedpref_utils.dart';

class PriceField extends StatelessWidget {
  final String? initialPrice;
  final bool readonly;
  final bool isError;
  final String? errorText;
  final ValueChanged<String>? onPriceChanged;
  final ValueChanged<String>? onDecimalChanged;
  final double? priceFieldWidth;
  final int? maxLength;
  final Color? fillColor;
  final TextEditingController? priceController;
  final TextEditingController? decimalController;
  final GestureTapCallback? onTap;

  const PriceField({
    Key? key,
    this.initialPrice,
    this.readonly = false,
    this.isError = false,
    this.errorText,
    this.priceFieldWidth,
    this.maxLength,
    this.fillColor,
    this.priceController,
    this.decimalController,
    required this.onPriceChanged,
    required this.onDecimalChanged,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          children: [
            Container(
              width: 104.w,
              height: 53.h,
              decoration: BoxDecoration(
                  color: AppColors().textFieldDisabledBackground,
                  borderRadius: const BorderRadius.all(Radius.circular(7)),
                  border: Border.all(color: AppColors().grey)),
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CountryFlag.fromCountryCode(
                    "AE",
                    height: 18.w,
                    width: 23.w,
                  ),
                  Text(
                    SharedPrefs().currency,
                    style: context.textTheme.headlineSmall?.copyWith(color: AppColors().black),
                  ).paddingStart(20.w)
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: isError ? AppColors().red3 : AppColors().grey),
                  borderRadius: BorderRadius.circular(7),
                  color:
                      fillColor ?? (readonly ? AppColors().textFieldDisabledBackground : AppColors().white)),
              height: 52.h,
              child: Row(
                children: [
                  SizedBox(
                    width: priceFieldWidth ?? 140.w,
                    child: PrimaryTextFormField(
                      // controller: priceController ??
                      //     (initialPrice != null ? TextEditingController(text: initialPrice?.getPrice()) : null),
                      initialValue: initialPrice?.getPrice(),
                      readOnly: readonly,
                      maxLength: maxLength ?? 10,
                      showCounter: false,
                      fillColor: fillColor,
                      textAlign: TextAlign.right,
                      noBorder: true,
                      onTap: () {
                        if (onTap != null) {
                          onTap!();
                        }
                        if (priceController != null) {
                          priceController!.selectAll();
                        }
                      },
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      onChanged: onPriceChanged,
                    ).paddingTop(4.h),
                  ).paddingStart(7.w),
                  Container(
                    decoration: BoxDecoration(
                        border:
                            Border(left: BorderSide(color: isError ? AppColors().red3 : AppColors().grey))),
                    width: 52.w,
                    child: PrimaryTextFormField(
                      // controller:
                      //     decimalController ?? (initialPrice != null  ? TextEditingController(text: initialPrice?.getDecimals()) : null),
                      readOnly: readonly,
                      fillColor: fillColor,
                      noBorder: true,
                      initialValue: initialPrice?.getDecimals() == "00" ? null : initialPrice?.getDecimals(),
                      keyboardType: TextInputType.number,
                      onTap: () {
                        if (onTap != null) {
                          onTap!();
                        }
                        if (decimalController != null) {
                          decimalController!.selectAll();
                        }
                      },
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      hint: ".00",
                      maxLength: 2,
                      showCounter: false,
                      onChanged: onDecimalChanged,
                    ).paddingTop(4.h),
                  ),
                ],
              ),
            ).paddingStart(10.w),
          ],
        ),
        isError
            ? Text(
                errorText ?? "",
                style: context.textTheme.bodyLarge?.copyWith(fontSize: 10.sp, color: AppColors().red3),
              ).paddingTop(10.h)
            : fetchEmptyWidget()
      ],
    );
  }
}
