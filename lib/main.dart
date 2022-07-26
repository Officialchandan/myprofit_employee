import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:employee/provider/NavigationService.dart';
import 'package:employee/src/ui/bottom_navigation/bottom_navigation.dart';
import 'package:employee/src/ui/fcm_notification/fcm_config.dart';
import 'package:employee/src/ui/splash/splash_screen.dart';
import 'package:employee/utils/colors.dart';
import 'package:employee/utils/sharedpref.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
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
  print("A bg Message showed up: ${message.data}");
  await Firebase.initializeApp();
  print(message.notification!.title);
}

fcmToken() async {
  try {
    String? tok = await firebaseMessaging.getToken();
    log("====>$tok");
    SharedPref.setStringPreference(SharedPref.DEVICETOKEN, tok!);
  } catch (e) {
    log("error");
  }
}

const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('ic_stat_name');
void selectNotification(String? payload) async {
  if (payload != null) {
    debugPrint('notification payload: $payload');
  }
  Navigator.push(navigationService.navigatorKey.currentContext!, MaterialPageRoute(builder: (_) => BottomNavigation()));
  // String grade = payload!;
  // print("object$grade");
  // switch (grade) {
  //   case "MoneyDueScreen":
  //     {
  //       // Navigator.push(
  //       //     navigationService.navigatorKey.currentContext!, MaterialPageRoute(builder: (_) => MoneyDueScreen(true)));
  //       print("Excellent");
  //     }
  //     break;
  //
  //   case "DueAmountScreen":
  //     {
  //       // Navigator.push(
  //       //     navigationService.navigatorKey.currentContext!, MaterialPageRoute(builder: (_) => DueAmountScreen()));
  //       print("Good");
  //     }
  //     break;
  //
  //   case "UpiTransferHistory":
  //     {
  //       // Navigator.push(
  //       //     navigationService.navigatorKey.currentContext!, MaterialPageRoute(builder: (_) => UpiTransferHistory()));
  //       print("Fair");
  //     }
  //     break;
  //
  //   case "UpiTransferHistoryWithoutInventory":
  //     {
  //       // Navigator.push(navigationService.navigatorKey.currentContext!,
  //       //     MaterialPageRoute(builder: (_) => UpiTransferHistoryWithoutInventory()));
  //       print("Poor");
  //     }
  //     break;
  //   case "SelectReportTypeScreen":
  //     {
  //       // Navigator.push(navigationService.navigatorKey.currentContext!,
  //       //     MaterialPageRoute(builder: (_) => SelectReportTypeScreen()));
  //       print("Poor");
  //     }
  //     break;
  //   case "ReportTypeScreen":
  //     {
  //       // Navigator.push(
  //       //     navigationService.navigatorKey.currentContext!, MaterialPageRoute(builder: (_) => ReportTypeScreen()));
  //       print("Poor");
  //     }
  //     break;
  //   default:
  //     {
  //       print("Invalid choice");
  //     }
  //     break;
  // }
}

configEasyLoading() {
  EasyLoading.instance
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.light
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..backgroundColor = Colors.transparent
    ..progressColor = ColorPrimary
    ..backgroundColor = ColorPrimary
    ..indicatorColor = ColorPrimary
    ..textColor = ColorPrimary
    ..maskColor = ColorPrimary
    ..userInteractions = false
    ..dismissOnTap = false;
}

Future<void> main() async {
  await fcmToken();
  configEasyLoading();
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

  FirebaseMessaging.onBackgroundMessage((_firebaseMessagingBackgroundHandler));
  await FcmConfig.configNotification();
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    log("notification data -> ${message.data}");
    log("notification title ${message.notification!.title}");
    log("notification body ${message.notification!.body}");
    log("===>$android");
    var data = message.data;
    print("notification route==>${data["route"]}");
    if (notification != null && android != null) {
      flutterLocalNotificationsPlugin.initialize(
          InitializationSettings(
            android: initializationSettingsAndroid,
          ),
          onSelectNotification: selectNotification);
      flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android:
              AndroidNotificationDetails(channel.id, channel.name, color: ColorPrimary, playSound: true, icon: "logo"),
        ),
        payload: data["route"],
      );
    }
    // Navigator.push(navigationService.navigatorKey.currentContext!,
    //     MaterialPageRoute(builder: (_) => MoneyDueScreen()));
  });

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    print("a new on message");
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    var data = message.data;

    print("notification data==>$data");

    print("notification route==>${data["route"]}");
    if (notification != null && android != null) {
      String grade = "${message.data["route"]}";
      Navigator.push(
          navigationService.navigatorKey.currentContext!, MaterialPageRoute(builder: (_) => BottomNavigation()));
      //   print("object$grade");
      //   switch (grade) {
      //     case "MoneyDueScreen":
      //       {
      //         // Navigator.push(
      //         //     navigationService.navigatorKey.currentContext!, MaterialPageRoute(builder: (_) => MoneyDueScreen(true)));
      //         print("Excellent");
      //       }
      //       break;
      //
      //     case "DueAmountScreen":
      //       {
      //         // Navigator.push(
      //         //     navigationService.navigatorKey.currentContext!, MaterialPageRoute(builder: (_) => DueAmountScreen()));
      //         print("Good");
      //       }
      //       break;
      //
      //     case "UpiTransferHistory":
      //       {
      //         // Navigator.push(
      //         //     navigationService.navigatorKey.currentContext!, MaterialPageRoute(builder: (_) => UpiTransferHistory()));
      //         print("Fair");
      //       }
      //       break;
      //
      //     case "UpiTransferHistoryWithoutInventory":
      //       {
      //         // Navigator.push(navigationService.navigatorKey.currentContext!,
      //         //     MaterialPageRoute(builder: (_) => UpiTransferHistoryWithoutInventory()));
      //         print("Poor");
      //       }
      //       break;
      //     case "SelectReportTypeScreen":
      //       {
      //         // Navigator.push(navigationService.navigatorKey.currentContext!,
      //         //     MaterialPageRoute(builder: (_) => SelectReportTypeScreen()));
      //         print("Poor");
      //       }
      //       break;
      //     case "ReportTypeScreen":
      //       {
      //         // Navigator.push(
      //         //     navigationService.navigatorKey.currentContext!, MaterialPageRoute(builder: (_) => ReportTypeScreen()));
      //         print("Poor");
      //       }
      //       break;
      //     default:
      //       {
      //         print("Invalid choice");
      //       }
      //       break;
      //   }
    }
  });
  checkForInitialMessage() async {
    await Firebase.initializeApp();
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) async {});
    ;
    log("in terminated");
    if (initialMessage != null) {
      log("in terminated");
    }
  }

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
      builder: (context, child) {
        child = EasyLoading.init()(context, child);
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
          child: child!,
        );
      },
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
