import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_street_merchant/data/constants/app_colors.dart';
import 'package:my_street_merchant/presentation/common_components/buttons/ripple_button.dart';
import 'package:my_street_merchant/utils/extensions/context_extensions.dart';
import 'package:my_street_merchant/utils/extensions/padding_extensions.dart';

class CopyButton extends StatelessWidget {
  final String text;
  final Color? color;
  final Color? iconColor;

  const CopyButton({Key? key, required this.text, this.color, this.iconColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RippleButton(
      color: color ?? Colors.white,
      isCustomRadius: true,
      bottomRightRadius: 7,
      topRightRadius: 7,
      onTap: () async {
        Fluttertoast.showToast(
            msg: "copied \"$text\"",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: AppColors().grey2,
            textColor: Colors.white,
            fontSize: 12.sp
        );
        await Clipboard.setData(ClipboardData(text: text));
      },
      child: Icon(
        Icons.file_copy_rounded,
        color: iconColor ?? AppColors().primaryColor,
      ),
    ).paddingEnd(1);
  }
}
