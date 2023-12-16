import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_street_merchant/presentation/common_components/buttons/picker_button.dart';
import 'package:my_street_merchant/utils/extensions/context_extensions.dart';
import 'package:my_street_merchant/utils/extensions/padding_extensions.dart';

showImagePickerDialog(
  BuildContext context, {
  required VoidCallback onCameraPressed,
  required VoidCallback onUploadPressed,
}) {
  showGeneralDialog(
    context: context,
    barrierLabel: "Barrier",
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.6),
    transitionDuration: const Duration(milliseconds: 200),
    pageBuilder: (_, __, ___) {
      return Center(
        child: Container(
          height: 318.h,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  PickerButton(
                    onPressed: onCameraPressed,
                    text: context.strings.camera,
                    icon: Icons.camera_alt_rounded,
                  ),
                  PickerButton(
                    onPressed: onUploadPressed,
                    text: context.strings.upload,
                    icon: Icons.upload,
                  )
                ],
              ).paddingTop(30.h)
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
