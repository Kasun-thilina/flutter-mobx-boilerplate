import 'package:mobx/mobx.dart';

part 'template_store.g.dart';

class TemplateStore extends _TemplateStore with _$TemplateStore {}

abstract class _TemplateStore with Store {
  _TemplateStore() {
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
