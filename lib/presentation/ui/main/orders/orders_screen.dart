import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobx/mobx.dart';
import 'package:my_street_merchant/presentation/common_components/dialog/error_alert.dart';
import 'package:my_street_merchant/presentation/common_components/gradient_background.dart';
import 'package:my_street_merchant/presentation/common_components/progress_indicator_widget.dart';
import 'package:my_street_merchant/utils/extensions/context_extensions.dart';
import 'package:my_street_merchant/utils/extensions/padding_extensions.dart';
import 'package:provider/provider.dart';

import '../../../common_components/notification_icon_widget.dart';
import '../../../stores/main/orders/orders_store.dart';
import '../../../stores/main/profile/profile_store.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  //stores:---------------------------------------------------------------------
  late OrdersStore _store;
  late ProfileStore _profileStore;
  final TextEditingController _searchController = TextEditingController();

  //disposer
  final List<ReactionDisposer> _disposers = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _store = Provider.of<OrdersStore>(context);
    _profileStore = Provider.of<ProfileStore>(context);
    _disposers.add(
      autorun(
        (_) {
          if (_store.isError) {
            _store.clearStatus();
            showErrorAlert(context,
                actionText: context.strings.tryAgain.toUpperCase(), text: _store.apiError);
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: Stack(
          children: [
            SingleChildScrollView(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.strings.orders,
                  style: context.textTheme.displayLarge,
                ).paddingTop(MediaQuery.of(context).viewPadding.top + 30.h).paddingSymmetric(
                  horizontal: 27.w,
                ),

              ],
            ).paddingSymmetric(vertical: 20.h)),
            NotificationIconWidget(
              profileStore: _profileStore,
            ),
            // Observer(builder: (context) {
            //   return Visibility(
            //     visible: _store.isLoading,
            //     child: const CustomProgressIndicatorWidget(),
            //   );
            // }),
          ],
        ),
      ),
    );
  }

  // dispose:-------------------------------------------------------------------
  @override
  void dispose() {
    // Clean up the controller when the Widget is removed from the Widget tree
    _searchController.dispose();
    for (var d in _disposers) {
      d();
    }
    super.dispose();
  }
}
