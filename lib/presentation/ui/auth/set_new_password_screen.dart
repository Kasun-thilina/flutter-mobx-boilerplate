import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobx/mobx.dart';
import 'package:my_street_merchant/data/constants/app_colors.dart';
import 'package:my_street_merchant/presentation/common_components/field_validation_widget.dart';
import 'package:my_street_merchant/presentation/common_components/routes.dart';
import 'package:my_street_merchant/utils/extensions/context_extensions.dart';
import 'package:my_street_merchant/utils/extensions/padding_extensions.dart';

import '../../common_components/appbars/primary_app_bar.dart';
import '../../common_components/buttons/primary_button.dart';
import '../../common_components/custom_error_widget.dart';
import '../../common_components/dialog/error_alert.dart';
import '../../common_components/dialog/success_popup.dart';
import '../../common_components/empty_widget.dart';
import '../../common_components/progress_indicator_widget.dart';
import '../../common_components/textfields/primary_textfield.dart';
import '../../stores/auth/set_new_password_store.dart';

class SetNewPasswordArguments {
  final String email;

  SetNewPasswordArguments({required this.email});
}

class SetNewPasswordScreen extends StatefulWidget {
  final SetNewPasswordArguments args;

  const SetNewPasswordScreen({super.key, required this.args});

  @override
  State<SetNewPasswordScreen> createState() => _SetNewPasswordScreenState();
}

class _SetNewPasswordScreenState extends State<SetNewPasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _cPasswordController = TextEditingController();

  //stores:---------------------------------------------------------------------
  final _store = SetNewPasswordStore();

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
          if (_store.isError) {
            _store.clearStatus();
            showErrorAlert(context, actionText: context.strings.tryAgain.toUpperCase(), text: _store.apiError);
          }
          if (_store.isSuccess) {
            _store.clearStatus();
            showSuccessDialog(context, onPressed: () {
              Navigator.pop(context);
              context.pushReplacementNamed(AppRouter.signInScreen);
            }, positiveMsg: context.strings.done, text: context.strings.passwordResetSuccess);
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
        appBar: const PrimaryAppBar(
          title: "",
        ),
        body: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.strings.resetPassword,
                  style: context.textTheme.displayLarge,
                ).paddingSymmetric(horizontal: 30.w),
                Expanded(
                    child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        context.strings.setANewPassword,
                        style: context.textTheme.headlineMedium,
                      ).paddingTop(10.h),
                      Observer(builder: (context) {
                        return PrimaryTextFormField(
                          controller: _passwordController,
                          title: context.strings.newPassword,
                          hint: context.strings.hintPassword,
                          isError: !_store.initial && !_store.canProceed,
                          isObscure: _store.isNewPwVisible,
                          suffixIcon: Material(
                            clipBehavior: Clip.antiAlias,
                            shape: const CircleBorder(),
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                _store.isNewPwVisible = !_store.isNewPwVisible;
                              },
                              child: Icon(
                                _store.isNewPwVisible ? Icons.visibility_off : Icons.visibility_rounded,
                                color: AppColors().primaryColor,
                              ),
                            ),
                          ),
                          onChanged: (value) {
                            _store.setPassword(_passwordController.text);
                          },
                        ).paddingTop(40.h);
                      }),
                      Observer(builder: (context) {
                        return PrimaryTextFormField(
                          controller: _cPasswordController,
                          title: context.strings.confirmPassword,
                          hint: context.strings.hintPassword,
                          isError:!_store.initial &&  !_store.canProceed,
                          isObscure: _store.isConfirmPWVisible,
                          suffixIcon: Material(
                            clipBehavior: Clip.antiAlias,
                            shape: const CircleBorder(),
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                _store.isConfirmPWVisible = !_store.isConfirmPWVisible;
                              },
                              child: Icon(
                                _store.isConfirmPWVisible ? Icons.visibility_off : Icons.visibility_rounded,
                                color: AppColors().primaryColor,
                              ),
                            ),
                          ),
                          onChanged: (value) {
                            _store.setConfirmPassword(_cPasswordController.text);
                          },
                        ).paddingTop(20.h);
                      }),
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
                            isError: !_store.passwordsMatch, errorText: context.strings.passwordsNotMatching);
                      }),
                      context.isKeyboardOpen2() ? buildButton(context).paddingTop(20.h) : fetchEmptyWidget(),
                    ],
                  ).paddingSymmetric(horizontal: 30.w),
                )),
                context.isKeyboardOpen2() ? fetchEmptyWidget() : buildButton(context).paddingTop(20.h),
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

  Widget buildButton(BuildContext context) {
    return Observer(builder: (context) {
      return Align(
        alignment: Alignment.center,
        child: PrimaryButton(
            title: context.strings.resetPassword,
            isDisabled: !_store.canProceed,
            minimumSize: Size(0.85.sw, 0.05.sh),
            onPressed: () {
              _store.resetPassword(widget.args.email);
            }),
      ).bottomButtonPadding();
    });
  }

  // dispose:-------------------------------------------------------------------
  @override
  void dispose() {
    // Clean up the controller when the Widget is removed from the Widget tree
    for (var d in _disposers) {
      d();
    }
    _passwordController.dispose();
    _cPasswordController.dispose();
    super.dispose();
  }
}
