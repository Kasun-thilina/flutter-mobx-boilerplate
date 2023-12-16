import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobx/mobx.dart';
import 'package:my_street_merchant/data/constants/constants.dart';
import 'package:my_street_merchant/presentation/common_components/buttons/primary_button.dart';
import 'package:my_street_merchant/presentation/common_components/dialog/error_alert.dart';
import 'package:my_street_merchant/presentation/common_components/empty_widget.dart';
import 'package:my_street_merchant/presentation/common_components/textfields/primary_textfield.dart';
import 'package:my_street_merchant/presentation/stores/auth/signin_store.dart';
import 'package:my_street_merchant/presentation/ui/auth/pin_verification_screen.dart';
import 'package:my_street_merchant/utils/environment_utils.dart';
import 'package:my_street_merchant/utils/extensions/context_extensions.dart';
import 'package:my_street_merchant/utils/extensions/padding_extensions.dart';
import 'package:my_street_merchant/utils/sharedpref_utils.dart';
import 'package:provider/provider.dart';

import '../../../data/constants/app_colors.dart';
import '../../common_components/app_logo_widget.dart';
import '../../common_components/progress_indicator_widget.dart';
import '../../common_components/routes.dart';
import '../../stores/main/bottom_nav_store.dart';
import '../../stores/main/home/home_store.dart';
import '../../stores/main/profile/profile_store.dart';
import '../main/child_navigator.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late BottomNavStore _bottomNavStore;
  late ProfileStore _profileStore;
  late HomeStore _homeStore;

  //stores:---------------------------------------------------------------------
  final _store = SignInStore();

  //disposer
  final List<ReactionDisposer> _disposers = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bottomNavStore = Provider.of<BottomNavStore>(context);
    _profileStore = Provider.of<ProfileStore>(context);
    _homeStore = Provider.of<HomeStore>(context);
    _disposers.add(
      autorun(
        (_) {
          if (_store.isSuccess) {
            _store.clearStatus();
            String currentStep = SharedPrefs().currentStep;
            switch (currentStep) {
              case CurrentStep.home:
                _bottomNavStore.selectedPage = BottomNavPage.home;
                context.pushNamedAndRemoveUntil(AppRouter.home);
                break;
              default:
                _bottomNavStore.selectedPage = BottomNavPage.home;
                context.pushNamedAndRemoveUntil(AppRouter.home);
                break;
            }
          }
          if (_store.isError) {
            showErrorAlert(context,
                actionText: context.strings.tryAgain.toUpperCase(), text: _store.apiError);
            _store.clearStatus();
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const AppLogoWidget().paddingTop(80.h),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        context.strings.welcomeBack,
                        style: context.textTheme.displayLarge,
                      ).paddingTop(40.h),
                      Text(
                        context.strings.greatToSeeYou,
                        style: context.textTheme.headlineMedium,
                      ).paddingOnly(top: 5.h, bottom: 30.h),
                      Observer(builder: (context) {
                        return PrimaryTextFormField(
                          controller: _emailController,
                          title: context.strings.email,
                          hint: context.strings.hintEmail,
                          errorText: _store.emailError ? context.strings.pleaseEnterAValidEmail : null,
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (value) {
                            _store.setEmail(_emailController.text);
                          },
                        );
                      }).paddingBottom(20.h),
                      Observer(builder: (context) {
                        return PrimaryTextFormField(
                          controller: _passwordController,
                          title: context.strings.password,
                          hint: context.strings.hintPassword,
                          isObscure: _store.isVisible,
                          suffixIcon: Material(
                            clipBehavior: Clip.antiAlias,
                            shape: const CircleBorder(),
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () => _store.changeVisibility(),
                              child: Icon(
                                _store.isVisible ? Icons.visibility_off : Icons.visibility_rounded,
                                color: AppColors().lightBlue.withOpacity(_store.password.isEmpty ? 0.5 : 1),
                              ),
                            ),
                          ),
                          onChanged: (value) {
                            _store.setPassword(_passwordController.text);
                          },
                        );
                      }),
                      Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap: () {
                            context.pushNamed(AppRouter.forgotPasswordScreen);
                          },
                          child: Text(
                            context.strings.forgotPassword,
                            style: context.textTheme.bodyLarge?.copyWith(
                                fontSize: 12.sp, fontWeight: FontWeight.w600, color: AppColors().darkBlue),
                          ),
                        ),
                      ).paddingOnly(top: 8.h, bottom: EnvironmentUtils.getEnvName().isNotEmpty
                          ? 0.24.sh : 0.265.sh),
                      Observer(builder: (context) {
                        return PrimaryButton(
                          title: context.strings.signIn,
                          minimumSize: Size(0.85.sw, 0.05.sh),
                          isDisabled: !_store.canLogin,
                          onPressed: () {
                            context.pushNamedAndRemoveUntil(AppRouter.home);
                            SharedPrefs().setCurrentStep(CurrentStep.home);
                            SharedPrefs().setAccessToken("22sss2222");
                          },
                        );
                      }),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            context.strings.dontHaveAccount,
                            style:
                                context.textTheme.headlineSmall?.copyWith(color: AppColors().fontLightGrey),
                          ),
                          GestureDetector(
                            onTap: () {
                              _store.password = "";
                              _store.email = "";
                              _passwordController.text = "";
                              _emailController.text = "";
                              context.pushNamed(AppRouter.signUpScreen);
                            },
                            child: Text(
                              context.strings.signUp.toUpperCase(),
                              style: context.textTheme.bodyMedium
                                  ?.copyWith(decoration: TextDecoration.underline),
                            ).paddingStart(8.w),
                          ),
                        ],
                      ).paddingSymmetric(vertical: 12.h),
                      EnvironmentUtils.getEnvName().isEmpty
                          ? fetchEmptyWidget()
                          : Text(
                              EnvironmentUtils.getEnvName(),
                              style: context.textTheme.bodyLarge,
                            ),
                    ],
                  ).paddingSymmetric(horizontal: 30.w)
                ],
              ),
            ),
            Observer(builder: (context) {
              return Visibility(
                visible: _store.isLoading,
                child: const CustomProgressIndicatorWidget(),
              );
            }),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is removed from the Widget tree
    for (var d in _disposers) {
      d();
    }
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
