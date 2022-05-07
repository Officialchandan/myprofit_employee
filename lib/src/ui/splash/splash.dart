import 'dart:async';
import 'dart:developer';

import 'package:employee/main.dart';
import 'package:employee/model/validate_app_version.dart';
import 'package:employee/provider/api_provider.dart';
import 'package:employee/src/ui/bottom_navigation/bottom_navigation.dart';
import 'package:employee/src/ui/login/login.dart';
import 'package:employee/src/ui/store_redirect.dart';
import 'package:employee/utils/colors.dart';
import 'package:employee/utils/network.dart';
import 'package:employee/utils/sharedpref.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    validApp();
    //startTimer();
  }

  void getLogin() async {
    var logs = await SharedPref.getBooleanPreference(SharedPref.LOGIN);
    log("${logs}");
    var permission = await Permission.location.request();
    if (permission.isGranted) {
      if (logs == true) {
        Timer(Duration(seconds: 3),
            () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BottomNavigation())));
      } else {
        Timer(Duration(seconds: 3),
            () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login())));
      }
    } else {
      await openAppSettings();
      getLogin();
    }
  }

  Future<void> validApp() async {
    if (await Network.isConnected()) {
      ValidateAppVersionResponse result = await ApiProvider().validateAppVersion();
      if (result.success) {
        getLogin();
      } else {
        validateAppAlert(result.data!.isMandatory);
      }
    } else {
      Fluttertoast.showToast(msg: "Please Turn On the Internet", backgroundColor: ColorPrimary);
      //internetDialog();
    }
  }

  void validateAppAlert(int mandotory) async {
    double devicewidth = 300;

    showDialog(
        barrierDismissible: false,
        context: navigationService.navigatorKey.currentContext!,
        builder: (context) => AlertDialog(
              content: Text("You are using older Version of Vendor App, \n Please Update App For Better Performance."),
              contentPadding: EdgeInsets.all(15),
              actions: [
                TextButton(
                    onPressed: () async {
                      StoreRedirect.redirect(
                        androidAppId: "com.myprofit.employee",
                        iOSAppId: "123456",
                      );
                    },
                    child: Text("Update")),
                mandotory == 1
                    ? Container()
                    : TextButton(
                        onPressed: () async {
                          Navigator.of(context);
                          getLogin();
                        },
                        child: Text("Later"))
              ],
            ));

    // EasyLoading.showError("Your session has been expired! Please login again",);
  }

  void internetDialog() async {
    double devicewidth = 300;

    showDialog(
        barrierDismissible: false,
        context: navigationService.navigatorKey.currentContext!,
        builder: (context) => AlertDialog(
              content: Text("Please Turn On Your Internet Connection"),
              contentPadding: EdgeInsets.all(15),
              actions: [
                TextButton(
                    onPressed: () async {
                      Navigator.pop(context);
                      validApp();
                    },
                    child: Text("Retry")),
              ],
            ));

    // EasyLoading.showError("Your session has been expired! Please login again",);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Image.asset('images/splash-top.png', width: 130),
            ),
            Image.asset('images/logo.png', width: 150),
            Image.asset('images/splash-bottom.png', width: double.infinity),
          ],
        ),
      ),
    );
  }

  void startTimer() async {
    Future.delayed(Duration(seconds: 3), () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Login()),
      );
    });
  }
}
//splas
