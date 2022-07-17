import 'package:employee/main.dart';
import 'package:employee/src/ui/bottom_navigation/bottom_navigation.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class FcmConfig {
  static NotificationSettings? settings;
  static String fcmToken = "";

  static requestPermission() async {
    settings = await firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    debugPrint('User granted permission: ${settings!.authorizationStatus}');
  }

  static configNotification() async {
    await FcmConfig.requestPermission();
    print("configNotification--->");
    FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) async {});
  }

  static Future<void> getInitialMessage(RemoteMessage message) async {
    print("getInitialMessage--->${message.toMap()}");
    Navigator.push(
        navigationService.navigatorKey.currentContext!, MaterialPageRoute(builder: (_) => BottomNavigation()));
    // String grade = message.data['route']!;
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
}
