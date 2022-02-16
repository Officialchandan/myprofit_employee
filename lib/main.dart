import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:employee/provider/NavigationService.dart';
import 'package:employee/src/ui/home/home.dart';
import 'package:employee/src/ui/splash/splash.dart';
import 'package:employee/utils/colors.dart';
import 'package:employee/utils/sharedpref.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_fonts/google_fonts.dart';

import 'provider/api_provider.dart';

NavigationService navigationService = NavigationService();
const AndroidNotificationChannel channel = AndroidNotificationChannel(
    "high_importance_channel", "High Importance Notification",
    importance: Importance.high, playSound: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("A bg Message showed up: ${message.messageId}");
}

fcmToken() async {
  try {
    log("device token${await firebaseMessaging.getToken()}");
    String? tok = await firebaseMessaging.getToken();

    SharedPref.setStringPreference(SharedPref.DEVICETOKEN, tok!);
  } catch (e) {
    log("error");
  }
}

Future<void> main() async {
  dio.interceptors.add(LogInterceptor(
      responseBody: true,
      responseHeader: false,
      requestBody: true,
      request: true,
      requestHeader: true,
      error: true,
      logPrint: (text) {
        log(text.toString());
      }));
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await fcmToken();
  FirebaseMessaging.onBackgroundMessage((_firebaseMessagingBackgroundHandler));

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    log("notification data -> ${message.data}");
    log("notification title ${message.notification!.title}");
    log("notification body ${message.notification!.body}");
    log("===>$android");
    if (notification != null && android != null) {
      flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(channel.id, channel.name,
                color: ColorPrimary, playSound: true, icon: "logo"),
          ));
    }
    // Navigator.push(navigationService.navigatorKey.currentContext!,
    //     MaterialPageRoute(builder: (_) => MoneyDueScreen()));
  });

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    print("a new on message");
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    if (notification != null && android != null) {
      log("notification aya");
      Navigator.push(
          navigationService.navigatorKey.currentContext!, MaterialPageRoute(builder: (_) => Home(onTab: () {})));
    }
  });

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  CircularProgressIndicator();

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // String? daa = "";
  // AppTranslationsDelegate _newLocaleDelegate =
  //     AppTranslationsDelegate(newLocale: Locale("en", ""));

  @override
  Widget build(BuildContext context) {
    const MaterialColor themeColor = const MaterialColor(
      0xFF6657f4,
      const <int, Color>{
        50: const Color(0xFF6657f4),
        100: const Color(0xFF6657f4),
        200: const Color(0xFF6657f4),
        300: const Color(0xFF6657f4),
        400: const Color(0xFF6657f4),
        500: const Color(0xFF6657f4),
        600: const Color(0xFF6657f4),
        700: const Color(0xFF6657f4),
        800: const Color(0xFF6657f4),
        900: const Color(0xFF6657f4),
      },
    );

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      // statusBarColor is used to set Status bar color in Android devices.
      statusBarColor: Color(0xff493ad6),

      // To make Status bar icons color white in Android devices.
      statusBarIconBrightness: Brightness.light,

      // statusBarBrightness is used to set Status bar icon color in iOS.
      statusBarBrightness: Brightness.light,
      // Here light means dark color Status bar icons.
    ));

    return MaterialApp(
      title: 'My Profit Employee',
      navigatorKey: navigationService.navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primarySwatch: themeColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: GoogleFonts.roboto().fontFamily,
        // fontFamily: TextStyle().fontFamily,
        appBarTheme: AppBarTheme(
          brightness: Brightness.dark,
        ),
      ),

      home: Splash(),

      // localizationsDelegates: [
      //   _newLocaleDelegate,
      //provides localised strings
      // GlobalMaterialLocalizations.delegate,
      //provides RTL support
      // GlobalWidgetsLocalizations.delegate,
      // ],
      // supportedLocales: [
      //   const Locale("en", ""),
      //   const Locale("hi", ""),
      // ],
    );
  }

//  void onLocaleChange(Locale locale) {
//     print("${locale}");
//      setState(() {
//       // _newLocaleDelegate = AppTranslationsDelegate(newLocale: locale);
//     });
//   }

  // init() async {
  //   var lang = await SharedPref.getStringPreference(SharedPref.SELECTEDLANG);
  //   print("${lang}");
  //   //_newLocaleDelegate = AppTranslationsDelegate(
  //   //   newLocale: Locale(lang.isEmpty ? "en" : lang, ""));
  //   setState(() {});
  //   application.onLocaleChanged = onLocaleChange;
  // }
}
