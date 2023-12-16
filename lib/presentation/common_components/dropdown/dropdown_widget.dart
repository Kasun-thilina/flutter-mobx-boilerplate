import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_street_merchant/data/constants/app_colors.dart';
import 'package:my_street_merchant/presentation/common_components/empty_widget.dart';
import 'package:my_street_merchant/utils/extensions/context_extensions.dart';
import 'package:my_street_merchant/utils/extensions/padding_extensions.dart';

import 'custom_dropdown.dart';

class DropDownWidget extends StatelessWidget {
  final String? title;
  final String? hint;
  final String selected;
  final double? dropdownWidth;
  final List<String> displayList;
  final List<String>? crossCheckList;
  final ValueChanged<int> onChanged;
  final IconData? icon;

  const DropDownWidget(
      {Key? key,
      this.title,
      this.hint,
      this.crossCheckList,
      required this.displayList,
      required this.onChanged,
      required this.selected,
      this.icon,
      this.dropdownWidth})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        title == null
            ? fetchEmptyWidget()
            : Text(
                title!,
                style: context.textTheme.displaySmall,
              ).paddingStart(10.w).paddingBottom(10.h),
        Container(
            decoration: BoxDecoration(
              color: AppColors().white,
              borderRadius: BorderRadius.circular(7),
              border: Border.all(color: AppColors().grey),
            ),
            child: Row(
              children: [
                CustomDropdown<String>(
                  onChange: (int index) {
                    onChanged(index);
                  },
                  dropdownButtonStyle: DropdownButtonStyle(
                    height: 49.h,
                    elevation: 2,
                    backgroundColor: Colors.white,
                    primaryColor: Colors.black87,
                  ),
                  dropdownStyle: DropdownStyle(
                    elevation: 0,
                    width: dropdownWidth,
                    color: AppColors().white,
                    scrollbarColor: AppColors().hintGrey,
                    padding: EdgeInsets.only(bottom: 8),
                    constraints: BoxConstraints(
                      maxHeight: 200.h,
                    ),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: AppColors().grey, width: 1),
                    ),
                  ),
                  items: displayList
                      .asMap()
                      .entries
                      .mapIndexed(
                        (index, item) => DropdownItem<String>(
                          value: item.value,
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(item.value,
                                    style: context.textTheme.bodyLarge?.copyWith(
                                        fontSize: 14.sp,
                                        color: crossCheckList != null
                                            ? crossCheckList![index] == selected
                                                ? AppColors().primaryColor
                                                : AppColors().hintGrey
                                            : item.value == selected
                                                ? AppColors().primaryColor
                                                : AppColors().hintGrey))
                                .paddingTop(8),
                          ),
                        ),
                      )
                      .toList(),
                  child: Row(
                    children: [
                      icon != null
                          ? Icon(
                              icon,
                              size: 18,
                              color: AppColors().grey,
                            ).paddingStart(8.w)
                          : fetchEmptyWidget().paddingStart(10.w),
                      SizedBox(
                        width: 5.w,
                      ),
                      Text(
                        selected.isEmpty ? hint ?? "" : selected,
                        style: context.textTheme.bodyLarge?.copyWith(
                            fontSize: 14.sp, color: selected.isEmpty ? AppColors().hintGrey : AppColors().fontBlack2),
                      ),
                    ],
                  ),
                ),
              ],
            )),
      ],
    );
  }

  List<DropdownMenuItem> buildDropdownListItems(List<String> list) {
    List<DropdownMenuItem> items = [];
    for (var item in list) {
      items.add(
        DropdownMenuItem(
          value: item,
          child: Text(item),
        ),
      );
    }
    return items;
  }
}
