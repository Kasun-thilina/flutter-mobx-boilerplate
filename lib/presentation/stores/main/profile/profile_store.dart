import 'package:mobx/mobx.dart';

part 'profile_store.g.dart';

class ProfileStore extends _ProfileStore with _$ProfileStore {}

abstract class _ProfileStore with Store {
  _ProfileStore() {
    _setUpValidations();
    // FirebaseMessaging.onMessage.listen((event) async {
    //   // fetchNotifications();
    // });
  }

  List<ReactionDisposer> _disposers = [];

  void _setUpValidations() {
    _disposers = [];
  }

  // store variables:-----------------------------------------------------------
  @observable
  bool isLoading = false;

  @observable
  String apiError = "";

  @observable
  bool isError = false;


// general methods:-----------------------------------------------------------


  @action
  void clearStatus() {
    isError = false;
  }

  void dispose() {
    for (final d in _disposers) {
      d();
    }
  }
}
