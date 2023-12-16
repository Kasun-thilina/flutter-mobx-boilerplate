import 'dart:async';
import 'dart:io';

import 'package:connectivity_widget/connectivity_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobx/mobx.dart';
import 'package:my_street_merchant/data/constants/icons.dart';
import 'package:my_street_merchant/presentation/ui/main/chats/chats_screen.dart';
import 'package:my_street_merchant/presentation/ui/main/orders/orders_screen.dart';
import 'package:my_street_merchant/presentation/ui/main/profile/profile_screen.dart';
import 'package:my_street_merchant/presentation/ui/main/widgets/selected_nav_icon.dart';
import 'package:my_street_merchant/utils/extensions/context_extensions.dart';
import 'package:my_street_merchant/utils/extensions/padding_extensions.dart';
import 'package:provider/provider.dart';

import '../../../data/constants/app_colors.dart';
import '../../stores/main/bottom_nav_store.dart';
import 'child_navigator.dart';
import 'home/home_screen.dart';

class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({super.key});

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  late BottomNavStore _store;

  final Map<BottomNavPage, GlobalKey<NavigatorState>> navigatorKeys = {
    BottomNavPage.home: GlobalKey<NavigatorState>(),
    BottomNavPage.chats: GlobalKey<NavigatorState>(),
    BottomNavPage.orders: GlobalKey<NavigatorState>(),
    BottomNavPage.profile: GlobalKey<NavigatorState>(),
  };

  //disposer
  final List<ReactionDisposer> _disposers = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _store = Provider.of<BottomNavStore>(context);
    _disposers.add(
      autorun(
        (_) {
          if (_store.isError) {
            _store.clearStatus();
            // showErrorAlert(context, actionText: context.strings.tryAgain.toUpperCase(), text: _store.apiError);
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return Scaffold(
        primary: true,
        body: ConnectivityWidget(
          onlineCallback: () {
            debugPrint("--> Online");

          },
          offlineCallback: () {
            debugPrint("--> Offline");
          },
          offlineBanner: Container(
            width: 1.sw,
            alignment: Alignment.topCenter,
            child: Container(
              decoration: BoxDecoration(color: AppColors().red),
              width: 1.sw,
              child: Text(
                context.strings.noInternet,
                style: context.textTheme.bodyLarge?.copyWith(color: AppColors().white, fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ).paddingTop(Platform.isIOS ? 35.h : 0),
            ),
          ),
          builder: (context, isOnline) => WillPopScope(
            onWillPop: () async {
              return false;
            },
            child: Stack(children: [
              _buildPreservingBottomNav(BottomNavPage.home),
              _buildWithoutPreservingBottomNav(BottomNavPage.chats),
              _buildPreservingBottomNav(BottomNavPage.orders),
              _buildPreservingBottomNav(BottomNavPage.profile),
            ]),
          ),
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                  color: Colors.black38.withOpacity(0.05),
                  spreadRadius: 0.1,
                  blurRadius: 9,
                  offset: const Offset(0, 1)),
            ],
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            child: Theme(
              data: ThemeData(
                splashFactory:NoSplash.splashFactory
              ),
              child: BottomNavigationBar(
                currentIndex: BottomNavPage.values.indexOf(_store.selectedPage),
                type: BottomNavigationBarType.fixed,
                selectedItemColor: AppColors().primaryColor,
                backgroundColor: AppColors().white,
                selectedFontSize: 9.sp,
                unselectedFontSize: 9.sp,
                selectedLabelStyle: Theme.of(context)
                    .textTheme
                    .displaySmall
                    ?.copyWith(color: AppColors().primaryColor, fontSize: 10.sp, fontWeight: FontWeight.w700),
                unselectedLabelStyle: Theme.of(context).textTheme.displaySmall?.copyWith(fontSize: 10.sp),
                onTap: (index) {
                  final currentSelectedItem = BottomNavPage.values[index];
                  _store.setCurrentPage(currentSelectedItem);

                },
                items: [
                  BottomNavigationBarItem(
                      icon: Image.asset(AssetIcons.homeUnSelected).paddingOnly(bottom: 6.h, top: 8.h),
                      activeIcon: const NavIcon(
                        icon: AssetIcons.homeSelected,
                      ),
                      label: context.strings.home),
                  BottomNavigationBarItem(
                      icon: const NavIcon(
                        isUnselected: true,
                        icon: AssetIcons.chatsUnselected,
                        notificationCount: 1,
                      ).paddingOnly(bottom: 4.h, top: 2.h),
                      activeIcon: const NavIcon(
                        icon: AssetIcons.chatsSelected,
                        notificationCount: 1,
                      ),
                      label: context.strings.chats),
                  BottomNavigationBarItem(
                      icon: Image.asset(AssetIcons.ordersUnselected).paddingOnly(bottom: 6.h, top: 8.h),
                      activeIcon: const NavIcon(
                        icon: AssetIcons.ordersSelected,
                      ),
                      label: context.strings.orders),
                  BottomNavigationBarItem(
                      icon: Image.asset(AssetIcons.profileUnSelected).paddingOnly(bottom: 6.h, top: 8.h),
                      activeIcon: const NavIcon(
                        icon: AssetIcons.profileSelected,
                      ),
                      label: context.strings.profile),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget _buildPreservingBottomNav(BottomNavPage currentItem) {
    return Offstage(
      offstage: currentItem != _store.selectedPage,
      child: ChildNavigator(
        navigatorKey: navigatorKeys[currentItem]!,
        page: currentItem,
      ),
    );
  }

  Widget _buildWithoutPreservingBottomNav(BottomNavPage currentItem) {
    return Offstage(
      offstage: currentItem != _store.selectedPage,
      child: _getScreen(context, currentItem),
    );
  }

  _getScreen(BuildContext context, BottomNavPage page) {
    switch (page) {
      case BottomNavPage.home:
        return const HomeScreen();
      case BottomNavPage.chats:
        return const ChatsScreen();
      case BottomNavPage.orders:
        return const OrdersScreen();
      case BottomNavPage.profile:
        return const ProfileScreen();
      default:
        return const Scaffold();
    }
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is removed from the Widget tree
    for (var d in _disposers) {
      d();
    }
    super.dispose();
  }
}
