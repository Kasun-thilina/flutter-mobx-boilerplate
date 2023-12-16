import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobx/mobx.dart';
import 'package:my_street_merchant/presentation/stores/auth/forgot_password_store.dart';
import 'package:my_street_merchant/presentation/ui/auth/pin_verification_screen.dart';
import 'package:my_street_merchant/utils/extensions/context_extensions.dart';
import 'package:my_street_merchant/utils/extensions/padding_extensions.dart';

import '../../common_components/appbars/primary_app_bar.dart';
import '../../common_components/buttons/primary_button.dart';
import '../../common_components/dialog/error_alert.dart';
import '../../common_components/empty_widget.dart';
import '../../common_components/progress_indicator_widget.dart';
import '../../common_components/routes.dart';
import '../../common_components/textfields/primary_textfield.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();

  //stores:---------------------------------------------------------------------
  final _store = ForgotPasswordStore();

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
            Navigator.pushNamed(context, AppRouter.pinVerificationScreen,
                    arguments: PinVerificationArguments(
                        verificationType: VerificationType.forgotPassword, sentTo: _store.email))
                .then((value) {
              _emailController.text = "";
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
        appBar: const PrimaryAppBar(
          title: "",
        ),
        body: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.strings.forgotPassword,
                  style: context.textTheme.displayLarge,
                ).paddingStart(30.w),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          context.strings.dontWorry,
                          style: context.textTheme.headlineMedium,
                        ).paddingTop(10.h),
                        RichText(
                          text: TextSpan(
                            text: context.strings.pleaseProvide,
                            style: context.textTheme.headlineSmall,
                            children: <TextSpan>[
                              TextSpan(
                                  text: context.strings.email,
                                  style: context.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700)),
                            ],
                          ),
                        ).paddingTop(30.h),
                        Observer(builder: (context) {
                          return PrimaryTextFormField(
                            controller: _emailController,
                            title: context.strings.email,
                            hint: context.strings.hintEmail,
                            keyboardType: TextInputType.emailAddress,
                            onChanged: (value) {
                              _store.setEmail(_emailController.text);
                            },
                          );
                        }).paddingTop(40.h),
                        context.isKeyboardOpen() ? buildButton(context).paddingTop(0.45.sh) : fetchEmptyWidget(),
                      ],
                    ).paddingSymmetric(horizontal: 30.w),
                  ),
                ),
                context.isKeyboardOpen() ? fetchEmptyWidget() : buildButton(context),
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
          title: context.strings.submit,
          minimumSize: Size(0.85.sw, 0.05.sh),
          isDisabled: !_store.canProceed,
          onPressed: () {
            _store.sendForgotPWOtp();
          },
        ),
      );
    }).bottomButtonPadding();
  }

  // dispose:-------------------------------------------------------------------
  @override
  void dispose() {
    // Clean up the controller when the Widget is removed from the Widget tree
    for (var d in _disposers) {
      d();
    }
    super.dispose();
  }
}
