import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:my_street_merchant/presentation/common_components/gradient_background.dart';
import 'package:my_street_merchant/presentation/common_components/progress_indicator_widget.dart';
import 'package:my_street_merchant/utils/extensions/context_extensions.dart';
import 'package:provider/provider.dart';

import '../../../common_components/dialog/error_alert.dart';
import '../../../common_components/notification_icon_widget.dart';
import '../../../stores/main/profile/profile_store.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({super.key});

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  final TextEditingController _searchController = TextEditingController();

  //stores:---------------------------------------------------------------------
  late ProfileStore _store;

  //disposer
  final List<ReactionDisposer> _disposers = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _store = Provider.of<ProfileStore>(context);
    _disposers.add(
      autorun(
        (_) {
          if (_store.isError) {
            showErrorAlert(context,
                actionText: context.strings.tryAgain.toUpperCase(), text: _store.apiError);
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
      child: Scaffold(body: Observer(builder: (context) {
        return GradientBackground(
          child: Stack(
            children: [
              NotificationIconWidget(
                profileStore: _store,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Chat")
                ],
              ),
              // Visibility(
              //   visible: _store.isLoading,
              //   child: const CustomProgressIndicatorWidget(),
              // ),
            ],
          ),
        );
      })),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
