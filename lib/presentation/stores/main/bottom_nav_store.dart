import 'package:mobx/mobx.dart';

import '../../ui/main/child_navigator.dart';

part 'bottom_nav_store.g.dart';

class BottomNavStore extends _BottomNavStore with _$BottomNavStore {}

abstract class _BottomNavStore with Store {
  List<ReactionDisposer> _disposers = [];

  _BottomNavStore() {
    _setUpValidations();
  }

  void _setUpValidations() {
    _disposers = [];
  }

  // store variables:-----------------------------------------------------------
  @observable
  bool isError = false;

  @observable
  String apiError = "";

  @observable
  bool isLoading = false;

  @observable
  bool isSuccess = false;

  @observable
  bool shouldNavigateToProfile = false;

  @observable
  int currentPageIndex = 0;

  @observable
  bool canPopToHome = true;

  @observable
  BottomNavPage selectedPage = BottomNavPage.home;

  @action
  void setCurrentPageIndex(int index) {
    currentPageIndex = index;
  }

  @action
  void setCurrentPage(BottomNavPage page) {
    selectedPage = page;
  }

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
