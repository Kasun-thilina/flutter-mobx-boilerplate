import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_street_merchant/data/constants/app_colors.dart';
import 'package:my_street_merchant/data/constants/icons.dart';
import 'package:my_street_merchant/presentation/common_components/empty_widget.dart';
import 'package:my_street_merchant/utils/extensions/context_extensions.dart';
import 'package:my_street_merchant/utils/extensions/padding_extensions.dart';
import 'package:my_street_merchant/utils/sharedpref_utils.dart';

import '../../../common_components/buttons/primary_button.dart';
import '../../../common_components/routes.dart';

class OnboardingWidget extends StatelessWidget {
  final String image;
  final String titleText;
  final String subTitleText;
  final bool isCenterButton;
  final VoidCallback? onPressed;

  const OnboardingWidget(
      {super.key,
      required this.image,
      required this.titleText,
      required this.subTitleText,
      this.onPressed,
      this.isCenterButton = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
        begin: const Alignment(0, 0),
        end: const Alignment(0, -0.7),
        colors: <Color>[
          AppColors().blueGradient3,
          AppColors().blueGradient2,
          AppColors().blueGradient1,
        ],
      )),
      child: Stack(
        children: [
          SizedBox(
            width: 1.sw,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  image,
                  height: 0.5.sh,
                ),
                Text(
                  titleText,
                  textAlign: TextAlign.center,
                  style: context.textTheme.displayLarge,
                ).paddingTop(25.h),
                Text(subTitleText, textAlign: TextAlign.center, style: context.textTheme.bodyLarge).paddingTop(15.h),
                isCenterButton
                    ? PrimaryButton(
                        title: context.strings.getStarted,
                        paddingVertical: 24,
                        onPressed: () {
                          SharedPrefs().setOnboardingStatus(true);
                          Navigator.of(context).pushReplacementNamed(AppRouter.signUpScreen);
                        },
                      ).paddingTop(30.h)
                    : fetchEmptyWidget()
              ],
            ).paddingOnly(top: 65.h, left: 14.w, right: 14.w),
          ),
          !isCenterButton
              ? Align(
                  alignment: Alignment.bottomRight,
                  child: InkWell(onTap: onPressed, child: Image.asset(AssetIcons.onboardingButton)))
              : fetchEmptyWidget(),
        ],
      ),
    );
  }
}
