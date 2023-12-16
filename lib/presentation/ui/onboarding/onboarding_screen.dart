import 'package:flutter/material.dart';
import 'package:my_street_merchant/presentation/ui/onboarding/widgets/onboarding_widget.dart';
import 'package:my_street_merchant/utils/extensions/context_extensions.dart';

import '../../../data/constants/images.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController(
    initialPage: 0,
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller,
        children: [
          OnboardingWidget(
            image: AssetImages.onboardingImage1,
            titleText: context.strings.onboardingPageOneTitle,
            subTitleText: context.strings.onboardingPageOneSubTitle,
            onPressed: () {
              _controller.nextPage(duration: const Duration(milliseconds: 600), curve: Curves.ease);
            },
          ),
          OnboardingWidget(
            image: AssetImages.onboardingImage2,
            titleText: context.strings.onboardingPageTwoTitle,
            subTitleText: context.strings.onboardingPageTwoSubTitle,
            onPressed: () {
              _controller.nextPage(duration: const Duration(milliseconds: 600), curve: Curves.ease);
            },
          ),
          OnboardingWidget(
            image: AssetImages.onboardingImage3,
            titleText: context.strings.onboardingPageThreeTitle,
            subTitleText: context.strings.onboardingPageThreeSubTitle,
            isCenterButton: true,
          ),
        ],
      ),
    );
  }

  // dispose:-------------------------------------------------------------------
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
