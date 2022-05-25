import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:employee/provider/NavigationService.dart';
import 'package:employee/src/ui/home/home.dart';
import 'package:employee/src/ui/splash/splash_screen.dart';
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
    log("====>$tok");
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
    colorScheme:
    ColorScheme.fromSwatch(
        primarySwatch: MaterialColor(
      ColorPrimary.value,
      <int, Color>{
        50: Color(0xFFFFFFFF),
        100: Color(0xFFD4D1FD),
        200: Color(0xFFABA2F6),
        300: Color(0xFF887BFC),
        400: Color(0xFF796AFF),
        500: Color(ColorPrimary.value),
        600: Color(0xFF5344F8),
        700: Color(0xFF4530FC),
        800: Color(0xFF2C17FF),
        900: Color(0xFF1500F5),
      },
    )).copyWith(secondary: ColorPrimary).copyWith(secondary: ColorPrimary);

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      // statusBarColor is used to set Status bar color in Android devices.
      statusBarColor: Color(0xff844cc6),

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
        primaryColor: ColorPrimary,
        primaryColorDark: ColorPrimary,

        bottomSheetTheme: BottomSheetThemeData(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(topRight: Radius.circular(25), topLeft: Radius.circular(25)))),
        iconTheme: IconThemeData(
          color: ColorPrimary,
          opacity: 1,
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: GoogleFonts.roboto().fontFamily,

        // fontFamily: TextStyle().fontFamily,
        appBarTheme: AppBarTheme(
          elevation: 1,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: ColorPrimary,
            // statusBarIconBrightness: Brightness.light,
          ),
          brightness: Brightness.dark,
          backgroundColor: ColorPrimary,
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
          centerTitle: true,
          actionsIconTheme: IconThemeData(
            color: Colors.white,
          ),
          // toolbarTextStyle: Theme.of(context).textTheme.headline6!.merge(TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          // titleTextStyle: Theme.of(context).textTheme.headline6!.merge(TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
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
