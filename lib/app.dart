import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_street_merchant/presentation/common_components/routes.dart';
import 'package:my_street_merchant/presentation/stores/main/bottom_nav_store.dart';
import 'package:my_street_merchant/presentation/stores/main/home/home_store.dart';
import 'package:my_street_merchant/presentation/stores/main/orders/orders_store.dart';
import 'package:my_street_merchant/presentation/stores/main/profile/profile_store.dart';
import 'package:my_street_merchant/presentation/ui/onboarding/splash_screen.dart';
import 'package:my_street_merchant/utils/dark_theme_provider.dart';
import 'package:my_street_merchant/utils/navigator_service.dart';
import 'package:my_street_merchant/utils/sharedpref_utils.dart';
import 'package:provider/provider.dart';
import 'package:uni_links/uni_links.dart';

import 'data/constants/app_colors.dart';
import 'data/constants/styles.dart';
import 'generated/l10n.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = DarkThemeProvider();
  late StreamSubscription _linkSubscription;

  @override
  void initState() {
    super.initState();
    getCurrentAppTheme();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    _linkSubscription = uriLinkStream.listen((Uri? uri) {
      debugPrint("DEEPLINK: $uri");
      debugPrint("UNMOUNTED DEEPLINK?: $uri");
    }, onError: (Object err) {
      debugPrint("DEEPLINK ERROR: $err");
    });
  }

  void getCurrentAppTheme() {
    themeChangeProvider.setDarkTheme(SharedPrefs().isDarkMode);
  }

  @override
  Widget build(BuildContext context) {
    var mySystemTheme = SystemUiOverlayStyle.dark.copyWith(
        systemNavigationBarColor: AppColors().white, systemNavigationBarIconBrightness: Brightness.dark);
    SystemChrome.setSystemUIOverlayStyle(mySystemTheme);
    final bottomNavStore = BottomNavStore();
    final homeStore = HomeStore();
    final profileStore = ProfileStore();
    final ordersStore = OrdersStore();

    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => themeChangeProvider),
          Provider<BottomNavStore>(
            create: (_) => bottomNavStore,
          ),
          Provider<HomeStore>(
            create: (_) => homeStore,
            lazy: true,
          ),
          Provider<ProfileStore>(
            lazy: true,
            create: (_) => profileStore,
          ),
          Provider<OrdersStore>(
            lazy: true,
            create: (_) => ordersStore,
          ),
        ],
        child: Consumer<DarkThemeProvider>(
          builder: (context, value, child) {
            return ScreenUtilInit(
                minTextAdapt: false,
                designSize: const Size(393, 852),
                builder: (context, snapshot) {
                  ScreenUtil().setSp(28);
                  return MaterialApp(
                    debugShowCheckedModeBanner: false,
                    title: 'Flutter Mobx Boilerplate',
                    navigatorKey: NavigationService().navigationKey,
                    builder: (context, widget) {
                      return MediaQuery(
                        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                        child: widget!,
                      );
                    },
                    localizationsDelegates: const [
                      S.delegate,
                      GlobalMaterialLocalizations.delegate,
                      GlobalWidgetsLocalizations.delegate,
                      GlobalCupertinoLocalizations.delegate
                    ],
                    supportedLocales: const [Locale('en', '')],
                    theme: Styles.themeData(themeChangeProvider.darkTheme, context),
                    home: const SplashScreen(),
                    onGenerateRoute: AppRouter().onGenerateRoute,
                  );
                });
          },
        ));
  }
}
