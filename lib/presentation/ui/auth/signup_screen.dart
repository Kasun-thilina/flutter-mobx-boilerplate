import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobx/mobx.dart';
import 'package:my_street_merchant/presentation/common_components/custom_error_widget.dart';
import 'package:my_street_merchant/presentation/stores/auth/signup_store.dart';
import 'package:my_street_merchant/presentation/ui/auth/pin_verification_screen.dart';
import 'package:my_street_merchant/presentation/ui/main/webview_screen.dart';
import 'package:my_street_merchant/utils/extensions/context_extensions.dart';
import 'package:my_street_merchant/utils/extensions/padding_extensions.dart';
import 'package:my_street_merchant/utils/sharedpref_utils.dart';
import 'package:provider/provider.dart';

import '../../../data/constants/app_colors.dart';
import '../../../data/constants/constants.dart';
import '../../common_components/appbars/primary_app_bar.dart';
import '../../common_components/buttons/primary_button.dart';
import '../../common_components/dialog/error_alert.dart';
import '../../common_components/field_validation_widget.dart';
import '../../common_components/progress_indicator_widget.dart';
import '../../common_components/routes.dart';
import '../../common_components/textfields/primary_textfield.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  //stores:---------------------------------------------------------------------
  final _store = SignUpStore();

  //disposer
  final List<ReactionDisposer> _disposers = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _disposers.add(
      autorun(
        (_) {
          if (_store.isSuccess) {
            _store.clearStatus();
            SharedPrefs().setCurrentStep(CurrentStep.verifyEmail);
            Navigator.pushNamed(context, AppRouter.pinVerificationScreen,
                    arguments:
                        PinVerificationArguments(verificationType: VerificationType.confirmEmail, sentTo: _store.email))
                .then((value) {
              _passwordController.text = "";
              _emailController.text = "";
              _store.clearData();
            });
          }
          if (_store.isError) {
            _store.clearStatus();
            showErrorAlert(context, actionText: context.strings.tryAgain.toUpperCase(), text: _store.apiError);
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
        appBar: PrimaryAppBar(
          onBackPressed: () {
            if (ModalRoute.of(context)?.isFirst != null) {
              if (!ModalRoute.of(context)!.isFirst) {
                Navigator.of(context).pop();
              } else {
                context.pushReplacementNamed(AppRouter.signInScreen);
              }
            }
          },
        ),
        body: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.strings.welcome,
                  style: context.textTheme.displayLarge,
                ).paddingSymmetric(horizontal: 30.w),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          context.strings.letsCreateYour,
                          style: context.textTheme.headlineMedium,
                        ).paddingTop(10.h),
                        Observer(builder: (context) {
                          return PrimaryTextFormField(
                            controller: _emailController,
                            title: context.strings.email,
                            hint: context.strings.hintEmail,
                            keyboardType: TextInputType.emailAddress,
                            isError: _store.isEmailError || _store.isInbuiltError,
                            errorText: _store.isEmailError ? context.strings.pleaseEnterAValidEmail : null,
                            onChanged: (value) {
                              _store.setEmail(_emailController.text);
                            },
                          );
                        }).paddingTop(30.h),
                        Observer(builder: (context) {
                          return Text(
                            context.strings.thisEmailAddressWill,
                            style: context.textTheme.bodyLarge
                                ?.copyWith(color: AppColors().fontLightGrey, fontSize: 10.sp),
                          ).paddingOnly(left: _store.isEmailError ? 12.w : 5.w, top: 5.h);
                        }),
                        Observer(builder: (context) {
                          return PrimaryTextFormField(
                            controller: _passwordController,
                            title: context.strings.password,
                            hint: context.strings.hintPassword,
                            isObscure: _store.isVisible,
                            isError: _store.isPasswordError,
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
                        }).paddingTop(30.h),
                        Text(
                          context.strings.passwordMustContain,
                          style: context.textTheme.displayMedium?.copyWith(fontSize: 14.sp, color: AppColors().fontBlack),
                        ).paddingTop(20.h),
                        Observer(builder: (context) {
                          return Column(
                            children: [
                              FieldValidationWidget(
                                text: context.strings.passwordConditionOne,
                                isValid: _store.eightChars,
                                initial: _store.initial,
                              ),
                              FieldValidationWidget(
                                text: context.strings.passwordConditionTwo,
                                isValid: _store.upperLowerChar,
                                initial: _store.initial,
                              ),
                              FieldValidationWidget(
                                text: context.strings.passwordConditionThree,
                                isValid: _store.numericChar,
                                initial: _store.initial,
                              ),
                              FieldValidationWidget(
                                text: context.strings.passwordConditionFour,
                                isValid: _store.specialChar,
                                initial: _store.initial,
                              ),
                            ],
                          ).paddingTop(10.h);
                        }),
                        Observer(builder: (context) {
                          return CustomErrorWidget(
                              isError: _store.isInbuiltError, errorText: context.strings.thisEmailHasRegistered);
                        }),
                        Observer(builder: (context) {
                          return PrimaryButton(
                            title: context.strings.signUp,
                            minimumSize: Size(0.85.sw, 0.05.sh),
                            isDisabled: !_store.canProceed,
                            onPressed: () {
                              _store.signUp();
                            },
                          );
                        }).paddingTop(MediaQuery.of(context).viewInsets.bottom > 0 ? 10.h : 33.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              context.strings.alreadyHaveAnAcc,
                              style: context.textTheme.headlineSmall?.copyWith(color: AppColors().fontLightGrey),
                            ),
                            GestureDetector(
                              onTap: () {
                                if (ModalRoute.of(context)?.isFirst != null) {
                                  if (!ModalRoute.of(context)!.isFirst) {
                                    Navigator.of(context).pop();
                                  } else {
                                    context.pushReplacementNamed(AppRouter.signInScreen);
                                  }
                                }
                              },
                              child: Text(
                                context.strings.signIn.toUpperCase(),
                                style: context.textTheme.bodyMedium?.copyWith(decoration: TextDecoration.underline),
                              ).paddingStart(8.w),
                            ),
                          ],
                        ).paddingSymmetric(vertical: 12.h),
                        Align(
                          alignment: Alignment.center,
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              text: context.strings.byContinuing,
                              style: context.textTheme.headlineSmall
                                  ?.copyWith(color: AppColors().fontLightGrey, fontSize: 10.sp),
                              children: <TextSpan>[
                                TextSpan(
                                    text: context.strings.termsConditions,
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        context.pushNamed(AppRouter.webViewScreen,
                                            arguments: WebViewScreenArgs(
                                                url: CommonConsts.termsURL, name: context.strings.termsNConditions));
                                      },
                                    style: context.textTheme.headlineSmall
                                        ?.copyWith(color: AppColors().lightBlue, fontSize: 10.sp)),
                                TextSpan(
                                    text: context.strings.and,
                                    style: context.textTheme.headlineSmall
                                        ?.copyWith(color: AppColors().fontLightGrey, fontSize: 10.sp)),
                                TextSpan(
                                    text: " ${context.strings.privacyPolicy}",
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        context.pushNamed(AppRouter.webViewScreen,
                                            arguments: WebViewScreenArgs(
                                                url: CommonConsts.ppURL, name: context.strings.privacyPolicy));
                                      },
                                    style: context.textTheme.headlineSmall
                                        ?.copyWith(color: AppColors().lightBlue, fontSize: 10.sp)),
                                TextSpan(
                                    text: ".",
                                    style: context.textTheme.headlineSmall
                                        ?.copyWith(color: AppColors().fontLightGrey, fontSize: 10.sp)),
                              ],
                            ),
                          ),
                        ).paddingBottom(10.h)
                      ],
                    ).paddingSymmetric(horizontal: 30.w),
                  ),
                ),
              ],
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

  // dispose:-------------------------------------------------------------------
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
