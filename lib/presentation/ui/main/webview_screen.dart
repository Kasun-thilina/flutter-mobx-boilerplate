import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:my_street_merchant/presentation/common_components/appbars/primary_app_bar.dart';
import 'package:my_street_merchant/presentation/common_components/dialog/error_alert.dart';
import 'package:my_street_merchant/presentation/common_components/progress_indicator_widget.dart';
import 'package:my_street_merchant/presentation/stores/auth/signin_store.dart';
import 'package:my_street_merchant/utils/extensions/context_extensions.dart';

class WebViewScreenArgs {
  final String name;
  final String url;

  WebViewScreenArgs({required this.url,required this.name});
}

class WebViewScreen extends StatefulWidget {
  final WebViewScreenArgs args;

  const WebViewScreen({super.key,required this.args});

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  //stores:---------------------------------------------------------------------
  final _store = SignInStore();

  //disposer
  final List<ReactionDisposer> _disposers = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _store.isLoading = true;
    _disposers.add(
      autorun(
        (_) {
          if (_store.isError) {
            _store.clearStatus();
            showErrorAlert(context, actionText: context.strings.tryAgain.toUpperCase(), text: _store.apiError);
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PrimaryAppBar(
        title: widget.args.name,
      ),
      body: Stack(
        children: [
          InAppWebView(
            initialUrlRequest: URLRequest(url: Uri.parse(widget.args.url)),
            onLoadStop: (InAppWebViewController controller, Uri? url) {
              _store.isLoading = false;
            },
          ),
          Observer(builder: (context) {
            return Visibility(
              visible: _store.isLoading,
              child: const CustomProgressIndicatorWidget(),
            );
          }),
        ],
      ),
    );
  }

  // dispose:-------------------------------------------------------------------
  @override
  void dispose() {
    // Clean up the controller when the Widget is removed from the Widget tree
    for (var d in _disposers) {
      d();
    }
    super.dispose();
  }
}
