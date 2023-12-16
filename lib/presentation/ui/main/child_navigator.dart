import 'package:flutter/material.dart';
import 'package:my_street_merchant/presentation/common_components/routes.dart';

import 'chats/chats_screen.dart';
import 'home/home_screen.dart';
import 'orders/orders_screen.dart';
import 'profile/profile_screen.dart';

enum BottomNavPage { home, chats, orders, profile }

class ChildNavigator extends StatelessWidget {
  static const String homeNavigatorRoot = '/';

  final GlobalKey<NavigatorState>? navigatorKey;
  final BottomNavPage page;

  const ChildNavigator({Key? key, required this.navigatorKey, required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final routeBuilders = _routeBuilder();
    return Navigator(
      key: navigatorKey,
      initialRoute: homeNavigatorRoot,
      onGenerateInitialRoutes: (_, initialRoute) {
        return [
          MaterialPageRoute(
              settings: const RouteSettings(name: homeNavigatorRoot),
              builder: (context) => routeBuilders[initialRoute]!(context))
        ];
      },
      onGenerateRoute: AppRouter.onGenerateNestedRoute,
    );
  }

  Map<String, WidgetBuilder> _routeBuilder() {
    return {homeNavigatorRoot: (context) => _getScreen(context, page)};
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
}
