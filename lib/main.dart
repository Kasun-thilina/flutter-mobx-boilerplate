import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:my_street_merchant/utils/environment_utils.dart';
import 'package:my_street_merchant/utils/sharedpref_utils.dart';

import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ///Need to generate firebase_options.dart to setup firebase. Otherwise delete the commented code
  ///https://firebase.google.com/docs/flutter/setup?platform=ios
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  await EnvironmentUtils.load(env: Environment.qa);
  SharedPrefs().init();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  ///Crashlytics
  if(!kDebugMode){
    // FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  }

  /// FCM
  // final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  // final fcmToken = await firebaseMessaging.getToken();
  // debugPrint("#FCM TOKEN: $fcmToken");
  // NotificationSettings settings = await firebaseMessaging.requestPermission(
  //   alert: true,
  //   badge: true,
  //   provisional: false,
  //   sound: true,
  // );
  // await firebaseMessaging.setForegroundNotificationPresentationOptions(
  //   alert: true,
  //   badge: true,
  //   sound: true,
  // );


  ///Android notification Handler
  // final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  // const AndroidInitializationSettings initializationSettingsAndroid =
  //     AndroidInitializationSettings('pro_icon');
  // final DarwinInitializationSettings initializationSettingsDarwin =
  //     DarwinInitializationSettings(onDidReceiveLocalNotification: (val0, val1, val2, val3) {});
  //
  // final InitializationSettings initializationSettings = InitializationSettings(
  //   android: initializationSettingsAndroid,
  //   iOS: initializationSettingsDarwin,
  // );
  // await flutterLocalNotificationsPlugin.initialize(initializationSettings,
  //     onDidReceiveNotificationResponse: (NotificationResponse notificationResponse) async {
  //   final String? payload = notificationResponse.payload;
  //   if (notificationResponse.payload != null) {
  //     debugPrint('notification payload: $payload');
  //   }
  // });

  // FirebaseMessaging.onMessage.listen((event) async {
  //   debugPrint("New Message: ${event.data}");
  //   if (Platform.isAndroid) {
  //     const AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
  //         "high_importance_channel", "AppName",
  //         importance: Importance.max, priority: Priority.high, groupKey: "AppName");
  //
  //     const NotificationDetails notificationDetails =
  //         NotificationDetails(android: androidNotificationDetails);
  //     await flutterLocalNotificationsPlugin.show(
  //       0,
  //       event.notification?.title ?? "",
  //       event.notification?.body ?? "",
  //       notificationDetails,
  //     );
  //   }
  // });

  runApp(const MyApp());
}
