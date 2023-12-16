import 'package:mobx/mobx.dart';
import 'package:my_street_merchant/data/constants/constants.dart';
import 'package:my_street_merchant/data/source/auth_api.dart';
import 'package:my_street_merchant/utils/sharedpref_utils.dart';

import '../../../generated/l10n.dart';
import '../../../utils/api_exception_helper.dart';
import '../../../utils/form_validation.dart';

part 'signin_store.g.dart';

class SignInStore extends _SignInStore with _$SignInStore {}

abstract class _SignInStore with Store {
  _SignInStore() {
    _setUpValidations();
  }

  List<ReactionDisposer> _disposers = [];

  void _setUpValidations() {
    _disposers = [
      reaction((_) => email, validateEmail),
      reaction((_) => password, validatePassword),
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
  String password = '';

  @observable
  bool shouldVerify = false;

  @observable
  bool isVisible = true;

  @observable
  bool emailError = false;

  @observable
  String? passwordError;

  // Computed variables:-----------------------------------------------------------
  @computed
  bool get canLogin => !hasErrorsInLogin && email.isNotEmpty && password.isNotEmpty;

  @computed
  bool get hasErrorsInLogin => emailError  || passwordError != null;

  // actions:-------------------------------------------------------------------
  @action
  void setEmail(String value) {
    email = value.trim();
  }

  @action
  void setPassword(String value) {
    password = value.trim();
  }

  @action
  void clearStatus() {
    isError = false;
    shouldVerify = false;
    isSuccess = false;
  }

  @action
  void validateEmail(String value) {
    if(value.isEmpty){
      emailError = false;
    }else{
      if (!Validator.isValidEmail(value)) {
        emailError = true;
      } else {
        emailError = false;
      }
    }
  }

  @action
  void validatePassword(String value) {
    if (value.length < 8) {
      passwordError = S.current.errorPassword;
    } else {
      passwordError = null;
    }
  }

  @action
  void validateLoginFields() {
    validateEmail(email);
    validatePassword(password);
  }

  @action
  void changeVisibility() {
    isVisible = !isVisible;
  }

  @action
  Future login() async {
    isLoading = true;
    AuthApi().signIn(email: email, password: password).then((user) {
      isLoading = false;
      if (user != null) {
        SharedPrefs().setAccessToken(user.accessToken ?? "");
        SharedPrefs().setRefreshToken(user.refreshToken ?? "");
        SharedPrefs().setUserEmail(user.email ?? "");
        SharedPrefs().setUserID(user.id ?? "");
        SharedPrefs().setFirstSignUpStatus(true);
        SharedPrefs().setUserName(user.username ?? "");
        SharedPrefs().setUserPhone(user.phone ?? "");
        isSuccess = true;
        // NotificationsApi().saveFirebaseToken();
      } else {
        apiError = S.current.somethingWentWrong;
        isError = true;
      }
    }).onError((error, stackTrace) {
      isLoading = false;
      apiError = ApiExceptionHelper().getErrorMessage(error);
      isError = true;
      return null;
    });
  }

  @action
  Future forgotPassword() async {
    isLoading = true;
  }

  @action
  Future logout() async {
    isLoading = true;
  }

// general methods:-----------------------------------------------------------
  void dispose() {
    for (final d in _disposers) {
      d();
    }
  }
}
