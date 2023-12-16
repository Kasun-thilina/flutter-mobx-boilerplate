import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
import 'package:my_street_merchant/data/source/auth_api.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../generated/l10n.dart';
import '../../../utils/api_exception_helper.dart';

part 'pin_verification_store.g.dart';

class PinVerificationStore extends _PinVerificationStore with _$PinVerificationStore {}

abstract class _PinVerificationStore with Store {
  _PinVerificationStore() {
    _setUpValidations();
    errorController = StreamController<ErrorAnimationType>();
  }

  List<ReactionDisposer> _disposers = [];

  void _setUpValidations() {
    _disposers = [];
  }

  Timer? timer;

  // store variables:-----------------------------------------------------------
  @observable
  bool isLoading = false;

  @observable
  String apiError = "";

  @observable
  bool isApiError = false;

  @observable
  bool isError = false;

  @observable
  bool isSuccess = false;

  @observable
  String pin = "";

  @observable
  int counter = 30;

  @observable
  int resentCount = 0;

  @observable
  bool counterRunning = false;

  @observable
  StreamController<ErrorAnimationType>? errorController;

  @observable
  TextEditingController pinController = TextEditingController();

  @computed
  bool get canProceed => pin.length == 6 && pin.isNotEmpty;

  @action
  void clearStatus() {
    isError = false;
    isSuccess = false;
    isApiError = false;
  }

  @action
  void setPin(String value) {
    pin = value.trim();
    isError = false;
  }

  @action
  Future verifyEmail(String email) async {
    isLoading = true;
    AuthApi().verifyEmail(email: email, otpCode: int.parse(pin)).then((status) {
      isLoading = false;
      if (status) {
        isSuccess = true;
      } else {
        apiError = S.current.somethingWentWrong;
        isError = true;
      }
    }).onError((error, stackTrace) {
      isLoading = false;
      clearPin();
      errorController!.add(ErrorAnimationType.shake);
      apiError = ApiExceptionHelper().getErrorMessage(error);
      isError = true;
    });
  }

  @action
  Future verifyPhone(String phone) async {
    isLoading = true;
    isLoading = false;
  }

  @action
  Future verifyResetPw(String email) async {
    isLoading = true;
    AuthApi().verifyResetPasswordOtp(email: email, otpCode: int.parse(pin)).then((status) {
      isLoading = false;
      if (status) {
        isSuccess = true;
      } else {
        apiError = S.current.somethingWentWrong;
        isError = true;
      }
    }).onError((error, stackTrace) {
      isLoading = false;
      clearPin();
      errorController!.add(ErrorAnimationType.shake);
      apiError = ApiExceptionHelper().getErrorMessage(error);
      isError = true;
    });
  }

  @action
  Future resendEmailOtp(String email) async {
    isLoading = true;
    isLoading = false;
  }

  @action
  Future resendResetPWOtp(String email) async {
    isLoading = true;
    AuthApi().sendResetPasswordOtp(email: email).then((status) {
      isLoading = false;
      clearPin();
      runCounter();
    }).onError((error, stackTrace) {
      isLoading = false;
      apiError = ApiExceptionHelper().getErrorMessage(error);
      isApiError = true;
    });
  }

  @action
  Future resendPhoneOtp(String phone) async {
    isLoading = true;
    isLoading = false;
  }

  void runCounter() {
    resentCount++;
    counterRunning = true;
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      debugPrint("Timer $counter");
      if (counter == 0) {
        counterRunning = false;
        timer?.cancel();
        counter = 30;
      }
      counter--;
    });
  }

  void clearPin() {
    pinController.text = "";
    pin = "";
  }

// general methods:-----------------------------------------------------------
  void dispose() {
    for (final d in _disposers) {
      d();
    }
    errorController!.close();
    pinController.dispose();
  }
}
