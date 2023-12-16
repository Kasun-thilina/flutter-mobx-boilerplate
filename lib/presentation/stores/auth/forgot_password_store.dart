import 'package:mobx/mobx.dart';

import '../../../data/source/auth_api.dart';
import '../../../utils/api_exception_helper.dart';
import '../../../utils/form_validation.dart';

part 'forgot_password_store.g.dart';

class ForgotPasswordStore extends _ForgotPasswordStore with _$ForgotPasswordStore {}

abstract class _ForgotPasswordStore with Store {
  _ForgotPasswordStore() {
    _setUpValidations();
  }

  List<ReactionDisposer> _disposers = [];

  void _setUpValidations() {
    _disposers = [
      reaction((_) => email, validateEmail),
    ];
  }

  // store variables:-----------------------------------------------------------
  @observable
  bool isLoading = false;

  @observable
  bool isSuccess = false;

  @observable
  String apiError = "";

  @observable
  bool isError = false;

  @observable
  String email = '';

  @observable
  bool emailError=false;

  @computed
  bool get canProceed => !emailError && email.isNotEmpty ;

  @action
  void clearStatus() {
    isError = false;
    isSuccess = false;
  }

  @action
  void setEmail(String value) {
    email = value.trim();
  }

  @action
  void validateEmail(String value) {
    if (value.isEmpty) {
      emailError = true;
    } else if (!Validator.isValidEmail(value)) {
      emailError = true;
    } else {
      emailError = false;
    }
  }

  @action
  Future sendForgotPWOtp() async {
    isLoading = true;
    AuthApi().sendResetPasswordOtp(email: email,).then((status) {
      isLoading = false;
      isSuccess = true;
    }).onError((error, stackTrace) {
      isLoading = false;
      apiError = ApiExceptionHelper().getErrorMessage(error);
      isError = true;
    });
  }

// general methods:-----------------------------------------------------------
  void dispose() {
    for (final d in _disposers) {
      d();
    }
  }
}
