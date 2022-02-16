import 'dart:async';
import 'dart:developer';

import 'package:employee/src/ui/bottom_navigation/bottom_navigation.dart';
import 'package:employee/src/ui/login/login.dart';
import 'package:employee/utils/sharedpref.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
    getLogin();
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
