import 'package:mobx/mobx.dart';
import 'package:my_street_merchant/utils/form_validation.dart';

import '../../../data/source/auth_api.dart';
import '../../../utils/api_exception_helper.dart';

part 'set_new_password_store.g.dart';

class SetNewPasswordStore extends _SetNewPasswordStore with _$SetNewPasswordStore {}

abstract class _SetNewPasswordStore with Store {
  _SetNewPasswordStore() {
    _setUpValidations();
  }

  List<ReactionDisposer> _disposers = [];

  void _setUpValidations() {
    _disposers = [
      reaction((_) => password, validatePassword),
      reaction((_) => confirmPassword, validatePassword),
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
  bool initial = true;

  @observable
  bool eightChars = false;

  @observable
  bool upperLowerChar = false;

  @observable
  bool numericChar = false;

  @observable
  bool specialChar = false;

  @observable
  bool passwordsMatch = true;

  @observable
  String password = '';

  @observable
  String confirmPassword = '';

  @observable
  bool isNewPwVisible = true;

  @observable
  bool isConfirmPWVisible = true;

  @observable
  bool canProceed = false;

  @action
  void clearStatus() {
    isError = false;
    isSuccess = false;
  }

  @action
  void setPassword(String value) {
    password = value.trim();
  }

  @action
  void setConfirmPassword(String value) {
    confirmPassword = value.trim();
  }

  @action
  void validatePassword(String value) {
    eightChars = Validator.has8Chars(value);
    initial = false;
    upperLowerChar = Validator.hasUpperLowerCase(value);
    numericChar = Validator.hasNumber(value);
    specialChar = Validator.hasSpecialChar(value);
    passwordsMatch = password == confirmPassword;

    canProceed = eightChars && upperLowerChar && numericChar && specialChar && passwordsMatch;
  }

  @action
  Future resetPassword(String email) async {
    isLoading = true;
    AuthApi()
        .resetPassword(
      email: email,
      password: password,
    )
        .then((status) {
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
