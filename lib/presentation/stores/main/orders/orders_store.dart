import 'package:mobx/mobx.dart';

part 'orders_store.g.dart';

class OrdersStore extends _OrdersStore with _$OrdersStore {}

abstract class _OrdersStore with Store {
  _OrdersStore() {
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

  @observable
  bool canProceed = false;


  // actions:-----------------------------------------------------------

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
