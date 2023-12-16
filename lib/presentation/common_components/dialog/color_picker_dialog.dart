import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_street_merchant/presentation/common_components/buttons/primary_button.dart';
import 'package:my_street_merchant/utils/extensions/context_extensions.dart';
import 'package:my_street_merchant/utils/extensions/padding_extensions.dart';

showColorPickerDialog(BuildContext context,
    {required ValueChanged<Color> onColorChanged, required VoidCallback onSave, Color? pickerColor}) {
  showGeneralDialog(
    context: context,
    barrierLabel: "Barrier",
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.6),
    transitionDuration: const Duration(milliseconds: 200),
    pageBuilder: (_, __, ___) {
      return Center(
        child: Container(
          height: 470.h,
          width: 336.w,
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20.r)),
          padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context, rootNavigator: true).pop();
                },
                child: Align(
                  alignment: Alignment.topRight,
                  child: Icon(
                    Icons.close,
                    size: 25.w,
                  ),
                ),
              ),
              ColorPicker(
                pickerColor: pickerColor ?? const Color(0xff443a49),
                onColorChanged: onColorChanged,
                colorPickerWidth: 300.0,
                pickerAreaHeightPercent: 0.7,
                enableAlpha: false,
                displayThumbColor: true,
                paletteType: PaletteType.hsv,
                labelTypes: [],
                pickerAreaBorderRadius: const BorderRadius.all(Radius.circular(10)),
              ).paddingTop(10.h),
              SizedBox(
                height: 54.h,
                width: 0.5.sw,
                child: PrimaryButton(
                  title: context.strings.save,
                  paddingVertical: 0,
                  fontSize: 16.sp,
                  onPressed: onSave,
                ).paddingTop(10.h),
              )
            ],
          ),
        ),
      );
    },
    transitionBuilder: (context, a1, a2, widget) {
      return Transform.scale(
        scale: a1.value,
        child: Opacity(
          opacity: a1.value,
          child: widget,
        ),
      );
    },
  );
}
