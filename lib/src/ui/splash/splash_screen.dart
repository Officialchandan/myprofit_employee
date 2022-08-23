import 'dart:async';
import 'dart:developer';

import 'package:employee/main.dart';
import 'package:employee/model/validate_app_version.dart';
import 'package:employee/provider/api_provider.dart';
import 'package:employee/src/ui/bottom_navigation/bottom_navigation.dart';
import 'package:employee/src/ui/login/login.dart';
import 'package:employee/utils/colors.dart';
import 'package:employee/utils/network.dart';
import 'package:employee/utils/sharedpref.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:store_redirect/store_redirect.dart';

import '../emp_status_one/emp_status.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    validApp();
    //startTimer();
  }

  void getLogin() async {
    var logs = await SharedPref.getBooleanPreference(SharedPref.LOGIN);
    log("$logs");
    var permission = await Permission.location.request();
    if (permission.isGranted) {
      if (logs == true) {
        int empStatus =
            await SharedPref.getIntegerPreference(SharedPref.EMP_STATUS);

        if (empStatus == 1) {
          Timer(
              Duration(seconds: 3),
              () => Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => EmpStatusOne())));
        } else {
          Timer(
              Duration(seconds: 3),
              () => Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => BottomNavigation())));
        }
      } else {
        Timer(
            Duration(seconds: 3),
            () => Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => Login())));
      }
    } else {
      await openAppSettings();
      getLogin();
    }
  }

  Future<void> validApp() async {
    if (await Network.isConnected()) {
      ValidateAppVersionResponse result =
          await ApiProvider().validateAppVersion();
      if (result.success) {
        getLogin();
      } else {
        validateAppAlert(result.data!.isMandatory);
      }
    } else {
      Fluttertoast.showToast(
          msg: "Please Turn On the Internet", backgroundColor: ColorPrimary);
      //internetDialog();
    }
  }

  void validateAppAlert(int mandotory) async {
    double devicewidth = 300;

    showDialog(
        barrierDismissible: false,
        context: navigationService.navigatorKey.currentContext!,
        builder: (context) => AlertDialog(
              content: Text(
                  "You are using older Version of Employee App Please Update App For Better Performance."),
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
                mandotory == 4
                    ? Container()
                    : TextButton(
                        onPressed: () async {
                          Navigator.of(context);
                          getLogin();
                        },
                        child: Text("Later"))
              ],
            ));

    ///
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

  refresh() {
    log("refresh hua");
    validApp();
    _refreshController.refreshCompleted();

    //setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    return SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        enablePullUp: false,
        onRefresh: () {
          refresh();
        },
        child: SafeArea(
          child: Container(
            color: Colors.white,
            height: MediaQuery.of(context).size.height * 0.96,
            child: Stack(children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Image.asset('images/splash-top.png'),
                  ),
                  Align(
                      alignment: Alignment.bottomRight,
                      child: Image.asset('images/splash-bottom.png',
                          width: MediaQuery.of(context).size.width * 0.7)),
                ],
              ),
              Positioned(
                  child: Center(
                child: Image.asset(
                  'images/logo.png',
                  height: deviceHeight * 0.40,
                ),
              )),
            ]),
          ),
        ));
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
