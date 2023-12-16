import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_street_merchant/data/constants/app_colors.dart';
import 'package:my_street_merchant/presentation/common_components/empty_widget.dart';
import 'package:my_street_merchant/utils/extensions/context_extensions.dart';

import 'buttons/ripple_button.dart';

class ButtonRow extends StatelessWidget {
  final String selected;
  final Function(String, int) onSelected;
  final List<String> itemList;

  const ButtonRow({
    Key? key,
    required this.selected,
    required this.onSelected,
    required this.itemList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(7), border: Border.all(color: AppColors().grey)),
      child: Row(
        children: itemList.mapIndexed((index, item) {
          return Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: RippleButton(
                    onTap: () {
                      onSelected(item, index);
                    },
                    color: selected == item ? AppColors().lightBlue8 : AppColors().white,
                    paddingVertical: 15.h,
                    isCustomRadius: index == 0 || index == itemList.length - 1 ? true : false,
                    topLeftRadius: index == 0 ? 7 : 0,
                    bottomLeftRadius: index == 0 ? 7 : 0,
                    topRightRadius: index == itemList.length - 1 ? 7 : 0,
                    bottomRightRadius: index == itemList.length - 1 ? 7 : 0,
                    child: Text(
                      itemList[index],
                      style: context.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: selected == item ? AppColors().black : AppColors().lightGrey),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                index != itemList.length - 1 ? VerticalDivider(
                  width: 1.5.w,
                  color: AppColors().grey,
                ):fetchEmptyWidget(),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
