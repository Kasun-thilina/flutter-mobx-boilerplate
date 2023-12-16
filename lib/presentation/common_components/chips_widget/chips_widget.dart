import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_street_merchant/data/constants/app_colors.dart';
import 'package:my_street_merchant/domain/model/local/chip_model.dart';
import 'package:my_street_merchant/presentation/common_components/empty_widget.dart';
import 'package:my_street_merchant/utils/extensions/context_extensions.dart';
import 'package:my_street_merchant/utils/extensions/padding_extensions.dart';

import '../buttons/ripple_button.dart';

/// Displays list of chips with wrapped width
class ChipsWidget extends StatelessWidget {
  final List<ChipModel> chips;
  final Function(ChipModel, int) onTap;
  final BoxDecoration? boxDecoration;
  final double? width;
  final bool clickable;
  final bool isError;

  const ChipsWidget({
    Key? key,
    required this.chips,
    required this.onTap,
    this.boxDecoration,
    this.width,
    this.clickable = true,
    this.isError = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              width: double.infinity,
              decoration: boxDecoration ??
                  BoxDecoration(
                      color: AppColors().white,
                      borderRadius: BorderRadius.circular(7),
                      border: Border.all(color: isError ? AppColors().red3 : AppColors().grey)),
              padding: clickable ? EdgeInsets.all(14.w) : EdgeInsets.zero,
              child: Wrap(
                  direction: Axis.horizontal,
                  spacing: 12.w,
                  runSpacing: 12.h,
                  children: chips
                      .mapIndexed((index, chip) => RippleButton(
                            onTap: () {
                              if (clickable) {
                                onTap(chip, index);
                              }
                            },
                            color: chip.isSelected
                                ? chip.selectedColor ?? chip.color ?? AppColors().backgroundColor3
                                : chip.color ?? AppColors().backgroundColor3,
                            borderRadius: 30,
                            paddingHorizontal: 12.w,
                            paddingVertical: 8.h,
                            child: SizedBox(
                              width: width,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  chip.icon != null
                                      ? Image.asset(chip.icon!).paddingSymmetric(horizontal: 10.w)
                                      : fetchEmptyWidget(),
                                  Text(
                                    chip.name,
                                    style: context.textTheme.titleSmall?.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: chip.textColor ?? AppColors().black),
                                  ),
                                  clickable
                                      ? Container(
                                          width: 12.w,
                                          height: 12.w,
                                          decoration: BoxDecoration(
                                              color:
                                                  chip.isSelected ? AppColors().lightBlue : AppColors().white,
                                              shape: BoxShape.circle,
                                              border: Border.all(color: AppColors().grey7)),
                                        ).paddingStart(10.w)
                                      : fetchEmptyWidget()
                                ],
                              ),
                            ),
                          ))
                      .toList()
                      .cast<Widget>())),
          isError
              ? Text(
                  "context.strings.thisFieldCannotBeEmpty",
                  style: context.textTheme.titleSmall?.copyWith(
                      color: AppColors().errorBorderRed, fontWeight: FontWeight.w400, fontSize: 11.sp),
                ).paddingTop(5.h)
              : fetchEmptyWidget()
        ],
      );
    });
  }
}
