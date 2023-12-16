import 'package:mobx/mobx.dart';
import 'package:my_street_merchant/utils/form_validation.dart';

import '../../../data/constants/constants.dart';
import '../../../data/source/auth_api.dart';
import '../../../generated/l10n.dart';
import '../../../utils/api_exception_helper.dart';
import '../../../utils/sharedpref_utils.dart';

part 'signup_store.g.dart';

class SignUpStore extends _SignUpStore with _$SignUpStore {}

abstract class _SignUpStore with Store {
  _SignUpStore() {
    _setUpValidations();
  }

  List<ReactionDisposer> _disposers = [];

  void _setUpValidations() {
    _disposers = [
      reaction((_) => password, validateFields),
      // reaction((_) => confirmPassword, validateFields),
      reaction((_) => email, validateEmail),
    ];
  }

  // store variables:-----------------------------------------------------------
  @observable
  bool isError = false;

  @observable
  bool isInbuiltError = false;

  @observable
  bool isLoading = false;

  @observable
  bool isSuccess = false;

  @observable
  String apiError = "";

  @observable
  bool isEmailError = false;

  @observable
  bool isPasswordError = false;

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
  bool isValidEmail = true;

  @observable
  String email = '';

  @observable
  String password = '';

  @observable
  String confirmPassword = '';

  @observable
  bool isVisible = true;

  @observable
  bool canProceed = false;

  @action
  void clearStatus() {
    isEmailError = false;
    isError = false;
    isSuccess = false;
  }

  @action
  void setEmail(String value) {
    email = value.trim();
    isInbuiltError = false;
  }

  @action
  void setPassword(String value) {
    initial = false;
    password = value.trim();
  }

  @action
  void setConfirmPassword(String value) {
    confirmPassword = value.trim();
  }

  @action
  void validateFields(String value) {
    if (!initial) {
      eightChars = Validator.has8Chars(password);
      upperLowerChar = Validator.hasUpperLowerCase(password);
      numericChar = Validator.hasNumber(password);
      specialChar = Validator.hasSpecialChar(password);
      // passwordsMatch = password == confirmPassword;
      canProceed = eightChars && upperLowerChar && numericChar && specialChar && isValidEmail;
      isPasswordError = !(eightChars && upperLowerChar && numericChar && specialChar) && !initial;
    }
  }

  @action
  void validateEmail(String value) {
    if (value.isEmpty) {
      isEmailError = false;
    } else {
      isEmailError=!Validator.isValidEmail(value);
    }
    isValidEmail = Validator.isValidEmail(email);
    canProceed = eightChars && upperLowerChar && numericChar && specialChar && isValidEmail;
  }

  @action
  void changeVisibility() {
    isVisible = !isVisible;
  }

  @action
  Future signUp() async {
    isLoading = true;
    AuthApi().signUp(email: email, password: password).then((user) {
      isLoading = false;
      if (user != null) {
        SharedPrefs().setAccessToken(user.accessToken ?? "");
        SharedPrefs().setRefreshToken(user.refreshToken ?? "");
        SharedPrefs().setUserEmail(user.email ?? "");
        SharedPrefs().setUserID(user.id ?? "");
        SharedPrefs().setUserName(user.username ?? "");
        SharedPrefs().setFirstSignUpStatus(true);
        // NotificationsApi().saveFirebaseToken();
        isSuccess = true;
      } else {
        apiError = S.current.somethingWentWrong;
        isError = true;
      }
    }).onError((error, stackTrace) {
      isLoading = false;
      apiError = ApiExceptionHelper().getErrorMessage(error);
      if (apiError == CurrentStep.verifyEmail) {
        isSuccess = true;
      } else if (apiError == S.current.emailAlreadyExist) {
        isInbuiltError = true;
      } else {
        isError = true;
      }
      return null;
    });
  }

  @action
  void clearData() {
    password = "";
    email = "";
    initial = true;
    eightChars = false;
    upperLowerChar = false;
    numericChar = false;
    specialChar = false;
    isPasswordError = false;
    passwordsMatch = true;
    isValidEmail = true;
  }

  // general methods:-----------------------------------------------------------
  void dispose() {
    for (final d in _disposers) {
      d();
    }
  }
}
