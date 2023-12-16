import 'package:mobx/mobx.dart';

part 'home_store.g.dart';

class HomeStore extends _HomeStore with _$HomeStore {}


abstract class _HomeStore with Store {
  _HomeStore() {
    _setUpValidations();
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


  @action
  void clearStatus() {
    isError = false;
  }


// general methods:-----------------------------------------------------------
  void dispose() {
    for (final d in _disposers) {
      d();
    }
  }
}
