import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_street_merchant/data/constants/app_colors.dart';
import 'package:my_street_merchant/presentation/common_components/buttons/ripple_button.dart';
import 'package:my_street_merchant/utils/extensions/padding_extensions.dart';

class PasteButton extends StatelessWidget {
  final Function(String) onTap;

  const PasteButton({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RippleButton(
      color: Colors.white,
      isCustomRadius: true,
      bottomRightRadius: 7,
      topRightRadius: 7,
      onTap: () async {
        ClipboardData? cdata = await Clipboard.getData(Clipboard.kTextPlain);
        if(cdata!=null){
          debugPrint("Clipboard val:${cdata.text}");
          onTap(cdata.text??"");
        }
      },
      child: Icon(
        Icons.paste_outlined,
        color: AppColors().primaryColor,
      ),
    ).paddingEnd(1);
  }
}
