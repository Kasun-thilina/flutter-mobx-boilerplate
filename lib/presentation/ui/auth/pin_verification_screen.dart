import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobx/mobx.dart';
import 'package:my_street_merchant/data/constants/app_colors.dart';
import 'package:my_street_merchant/presentation/common_components/custom_error_widget.dart';
import 'package:my_street_merchant/presentation/common_components/empty_widget.dart';
import 'package:my_street_merchant/presentation/ui/auth/set_new_password_screen.dart';
import 'package:my_street_merchant/utils/extensions/context_extensions.dart';
import 'package:my_street_merchant/utils/extensions/padding_extensions.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

import '../../../data/constants/constants.dart';
import '../../../utils/sharedpref_utils.dart';
import '../../common_components/appbars/primary_app_bar.dart';
import '../../common_components/buttons/primary_button.dart';
import '../../common_components/dialog/error_alert.dart';
import '../../common_components/dialog/success_popup.dart';
import '../../common_components/info_message.dart';
import '../../common_components/progress_indicator_widget.dart';
import '../../common_components/routes.dart';
import '../../stores/auth/pin_verification_store.dart';

enum VerificationType { confirmEmail, forgotPassword, confirmPhone }

class PinVerificationArguments {
  final VerificationType verificationType;
  final String sentTo;
  final bool isEdit;

  PinVerificationArguments({required this.verificationType, required this.sentTo, this.isEdit = false});
}

class PinVerificationScreen extends StatefulWidget {
  final PinVerificationArguments args;

  const PinVerificationScreen({super.key, required this.args});

  @override
  State<PinVerificationScreen> createState() => _PinVerificationScreenState();
}

class _PinVerificationScreenState extends State<PinVerificationScreen> {
  //stores:---------------------------------------------------------------------
  final _store = PinVerificationStore();

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
            if(widget.args.verificationType==VerificationType.forgotPassword){
              Navigator.of(context).popAndPushNamed(AppRouter.setNewPasswordScreen,
                  arguments: SetNewPasswordArguments(email: widget.args.sentTo));
            }else{
              showSuccessDialog(context, onPressed: () {
                Navigator.pop(context);
                if (widget.args.isEdit) {
                  Navigator.of(context).pop();
                } else {
                  switch (widget.args.verificationType) {
                    case VerificationType.confirmEmail:
                      break;
                    case VerificationType.forgotPassword:
                      Navigator.of(context).pushNamed(AppRouter.setNewPasswordScreen,
                          arguments: SetNewPasswordArguments(email: widget.args.sentTo));
                      break;
                    case VerificationType.confirmPhone:
                      break;
                  }
                }
              }, positiveMsg: context.strings.done, text: context.strings.successfullyVerified);
            }
          }
          if (_store.isApiError) {
            _store.clearStatus();
            showErrorAlert(context, actionText: context.strings.tryAgain.toUpperCase(), text: _store.apiError);
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    VerificationType type = widget.args.verificationType;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: PrimaryAppBar(
          title: "",
          onBackPressed: () {
            if (ModalRoute.of(context)?.isFirst != null) {
              if (!ModalRoute.of(context)!.isFirst) {
                Navigator.of(context).pop();
              } else {
                if (widget.args.verificationType == VerificationType.confirmEmail) {
                  context.pushReplacementNamed(AppRouter.signUpScreen);
                  SharedPrefs().clearAll();
                }
              }
            }
          },
          actions: [

          ],
        ),
        body: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  getTitle(type),
                  style: context.textTheme.displayLarge,
                ).paddingStart(30.w),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          type != VerificationType.forgotPassword
                              ? context.strings.addTheOtp
                              : context.strings.addTheVerificationCode,
                          style: context.textTheme.headlineMedium,
                        ).paddingTop(10.h),
                        RichText(
                          text: TextSpan(
                            text: type != VerificationType.forgotPassword
                                ? context.strings.toConfirmYourAccount
                                : context.strings.weHaveSentACode,
                            style: context.textTheme.headlineSmall?.copyWith(color: AppColors().black),
                            children: <TextSpan>[
                              TextSpan(
                                  text: getEmailOrPhoneValue(type),
                                  style: context.textTheme.headlineSmall
                                      ?.copyWith(fontWeight: FontWeight.w700, color: AppColors().black)),
                              TextSpan(
                                  text: type != VerificationType.forgotPassword ? "" : context.strings.checkYourEmail,
                                  style: context.textTheme.headlineSmall?.copyWith(color: AppColors().black))
                            ],
                          ),
                        ).paddingTop(30.h),
                        Observer(builder: (context) {
                          return PinCodeTextField(
                              appContext: context,
                              controller: _store.pinController,
                              length: 6,
                              keyboardType: TextInputType.number,
                              enableActiveFill: true,
                              animationType: AnimationType.fade,
                              errorAnimationController: _store.errorController,
                              pinTheme: PinTheme(
                                  shape: PinCodeFieldShape.box,
                                  selectedColor: AppColors().primaryColor,
                                  inactiveColor: AppColors().grey,
                                  activeColor: AppColors().white,
                                  activeFillColor: AppColors().white,
                                  selectedFillColor: AppColors().white,
                                  inactiveFillColor: AppColors().white,
                                  errorBorderColor: AppColors().errorBorderRed,
                                  borderRadius: BorderRadius.circular(10.r),
                                  fieldHeight: 50.h,
                                  fieldWidth: 50.w,
                                  borderWidth: 1),
                              onChanged: (value) {
                                _store.setPin(value);
                              }).paddingTop(40.h);
                        }),
                        Observer(builder: (context) {
                          return Align(
                            alignment: Alignment.centerRight,
                            child: InkWell(
                              onTap: () {
                                if (_store.resentCount >= 5) {
                                  showErrorAlert(context,
                                      actionText: context.strings.ok, text: context.strings.exceededOTPLimit);
                                } else {
                                  if (!_store.counterRunning) {
                                    if (type == VerificationType.confirmPhone) {
                                      _store.resendPhoneOtp(getEmailOrPhoneValue(type));
                                    } else if (type == VerificationType.forgotPassword) {
                                      _store.resendResetPWOtp(getEmailOrPhoneValue(type));
                                    } else if (type == VerificationType.confirmEmail) {
                                      _store.resendEmailOtp(getEmailOrPhoneValue(type));
                                    }
                                  }
                                }
                              },
                              child: Text(
                                !_store.counterRunning
                                    ? context.strings.resendCode
                                    : "${context.strings.tryAgainIn} ${_store.counter} seconds",
                                style: context.textTheme.bodyLarge?.copyWith(
                                    fontSize: 12.sp, fontWeight: FontWeight.w600, color: AppColors().darkBlue),
                              ),
                            ),
                          );
                        }),
                        Observer(builder: (context) {
                          return Visibility(
                                  visible: _store.resentCount >= 1,
                                  child: InfoMessage(
                                       content: context.strings.exceededOTPLimitNote))
                              .paddingTop(20.h);
                        }).paddingSymmetric(vertical: 20.h),
                        Observer(builder: (context) {
                          return CustomErrorWidget(isError: _store.isError, errorText: context.strings.incorrectCode);
                        }),
                        context.isKeyboardOpen2() ? buildButton(context).paddingTop(0.2.sh) : fetchEmptyWidget(),
                      ],
                    ).paddingSymmetric(horizontal: 30.w),
                  ),
                ),
                context.isKeyboardOpen2() ? fetchEmptyWidget() : buildButton(context),
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
    VerificationType type = widget.args.verificationType;
    return Observer(builder: (context) {
      return Align(
        alignment: Alignment.center,
        child: PrimaryButton(
          title: context.strings.verify,
          minimumSize: Size(0.85.sw, 0.05.sh),
          isDisabled: !_store.canProceed,
          onPressed: () {
            if (type == VerificationType.confirmPhone) {
              _store.verifyPhone(getEmailOrPhoneValue(type));
            } else if (type == VerificationType.forgotPassword) {
              _store.verifyResetPw(getEmailOrPhoneValue(type));
            } else if (type == VerificationType.confirmEmail) {
              _store.verifyEmail(getEmailOrPhoneValue(type));
            }
          },
        ),
      );
    }).bottomButtonPadding();
  }

  String getTitle(VerificationType type) {
    switch (type) {
      case VerificationType.confirmEmail:
        return context.strings.confirmEmailAddress;
      case VerificationType.forgotPassword:
        return context.strings.resetPassword;
      case VerificationType.confirmPhone:
        return "Confirm Your Phone Number";
    }
  }

  String getEmailOrPhoneValue(VerificationType type) {
    switch (type) {
      case VerificationType.confirmEmail:
        return widget.args.sentTo;
      case VerificationType.forgotPassword:
        return widget.args.sentTo;
      case VerificationType.confirmPhone:
        return "+${widget.args.sentTo}";
    }
  }

  // dispose:-------------------------------------------------------------------
  @override
  void dispose() {
    // Clean up the controller when the Widget is removed from the Widget tree
    // _pinController.dispose();
    for (var d in _disposers) {
      d();
    }
    super.dispose();
  }
}
