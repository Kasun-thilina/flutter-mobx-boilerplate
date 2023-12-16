import 'package:flutter/material.dart';

import '../../data/constants/app_colors.dart';
import '../../data/constants/icons.dart';

class AppLogoWidget extends StatelessWidget {

  const AppLogoWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors().primaryColor,
          borderRadius: BorderRadius.circular(10)
      ),
      child: Image.asset(
        AssetIcons.appLogo,
      ),
    );
  }
}
