import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_fgbg/flutter_fgbg.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobx/mobx.dart';
import 'package:my_street_merchant/presentation/common_components/dialog/error_alert.dart';
import 'package:my_street_merchant/presentation/common_components/progress_indicator_widget.dart';
import 'package:my_street_merchant/presentation/stores/main/home/home_store.dart';
import 'package:my_street_merchant/utils/extensions/context_extensions.dart';
import 'package:my_street_merchant/utils/extensions/padding_extensions.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../common_components/gradient_background.dart';
import '../../../common_components/notification_icon_widget.dart';
import '../../../stores/main/profile/profile_store.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  //stores:---------------------------------------------------------------------
  late HomeStore _store;
  late ProfileStore _profileStore;

  late StreamSubscription<FGBGType> subscription;
  final ScrollController _gridScrollController = ScrollController();
  final ScrollController _listScrollController = ScrollController();
  final RefreshController _refreshController = RefreshController(initialRefresh: false);
  final RefreshController _noProductsRefreshController = RefreshController(initialRefresh: false);

  //disposer
  final List<ReactionDisposer> _disposers = [];

  @override
  void initState() {
    super.initState();
    subscription = FGBGEvents.stream.listen((event) {
      if (event == FGBGType.foreground) {
        debugPrint("RUN when foreground");

      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _store = Provider.of<HomeStore>(context);
    _profileStore = Provider.of<ProfileStore>(context);
    _disposers.add(
      autorun(
        (_) {
          if (_store.isError) {
            _store.clearStatus();
              showErrorAlert(context,
                  actionText: context.strings.tryAgain.toUpperCase(), text: _store.apiError, onPressed: () {

                Navigator.of(context, rootNavigator: true).pop();
              });
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: GradientBackground(
            child: Stack(
              children: [
                SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      Center(child: Text("HOME"))
                    ],
                  ).paddingTop(130.h),
                ),
                NotificationIconWidget(
                  profileStore: _profileStore,
                ),
                // Observer(builder: (context) {
                //   return Visibility(
                //     visible: _store.isLoading || _profileStore.isLoading,
                //     child: CustomProgressIndicatorWidget(
                //       paddingTop: 210.h,
                //     ),
                //   );
                // }),
              ],
            ),
          )),
    );
  }

  // dispose:-------------------------------------------------------------------
  @override
  void dispose() {
    // Clean up the controller when the Widget is removed from the Widget tree
    _searchController.dispose();
    subscription.cancel();
    for (var d in _disposers) {
      d();
    }
    super.dispose();
  }
}
