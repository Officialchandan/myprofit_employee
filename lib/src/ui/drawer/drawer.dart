import 'dart:developer';

import 'package:employee/model/logout_response.dart';
import 'package:employee/provider/api_provider.dart';
import 'package:employee/src/ui/bottom_navigation/bottom_navigation.dart';
import 'package:employee/src/ui/login/login.dart';
import 'package:employee/src/ui/scripts/scripts.dart';
import 'package:employee/utils/colors.dart';
import 'package:employee/utils/network.dart';
import 'package:employee/utils/sharedpref.dart';
import 'package:employee/utils/webView_Screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  //logout-dialog
  logoutDialog() {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            contentPadding: EdgeInsets.fromLTRB(25, 10, 0, 0),
            title: Text("Logout", style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600)),
            content: Text("Are you sure you want to logout?",
                style: TextStyle(color: Color.fromRGBO(85, 85, 85, 1), fontSize: 15, fontWeight: FontWeight.w500)),
            actions: [
              MaterialButton(
                child: Text("Cancel", style: TextStyle(color: ColorTextPrimary, fontWeight: FontWeight.w600)),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              MaterialButton(
                child: Text("Logout", style: TextStyle(color: Color(0xfff4511e), fontWeight: FontWeight.w600)),
                onPressed: () async {
                  log("ndndnd");
                  LogOutResponse logoutData = await ApiProvider().logout();
                  print("kai kroge +${logoutData.success}");
                  await SharedPref.setBooleanPreference(SharedPref.LOGIN, false);
                  print("kai kroge +${logoutData.success}");
                  if (await Network.isConnected()) {
                    SystemChannels.textInput.invokeMethod("TextInput.hide");
                    print("kai kroge +");
                    Navigator.pushAndRemoveUntil(
                        context, MaterialPageRoute(builder: (context) => Login()), ModalRoute.withName("/"));

                    Fluttertoast.showToast(
                        backgroundColor: ColorPrimary, textColor: Colors.white, msg: "Logout Successfully"
                        // timeInSecForIos: 3
                        );
                  } else {
                    Fluttertoast.showToast(
                        backgroundColor: ColorPrimary, textColor: Colors.white, msg: "Please turn on  internet");
                  }
                  // LogOut();
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => Login()),
                  // );
                },
              ),
            ],
          );
        });
  }

  //logout-dialog
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }

  String name = "", mobile = "";
  void getdata() async {
    name = await SharedPref.getStringPreference(SharedPref.NAME);
    mobile = await SharedPref.getStringPreference(SharedPref.MOBILE);
    log("==>$name");
    log("==>$mobile");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 270,
      child: Drawer(
        child: Container(
          color: Colors.white,
          child: ListView(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                child: Column(children: [
                  Image.asset("images/logo.png", width: 170, height: 170),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "$name",
                    style: TextStyle(color: ColorPrimary, fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text("+91 $mobile",
                      style: TextStyle(
                        color: ColorTextPrimary,
                        fontSize: 16,
                      ))
                ]),
              ),

              Container(
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(width: 0.7, color: Color(0xffcdcdcd))),
                ),
                child: ListTile(
                  leading: Container(width: 20, child: Image.asset('images/s1.png')),
                  title: Text("Home", style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w600)),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushAndRemoveUntil(
                        context, MaterialPageRoute(builder: (context) => BottomNavigation()), ModalRoute.withName("/"));
                  },
                ),
              ),

              Container(
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(width: 0.7, color: Color(0xffcdcdcd))),
                ),
                child: ListTile(
                  leading: Container(width: 20, child: Image.asset('images/s2.png', width: 20)),
                  title:
                      Text("Script", style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w600)),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Scripts()),
                    );
                  },
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(width: 0.7, color: Color(0xffcdcdcd))),
                ),
                child: ListTile(
                  leading: Container(width: 20, child: Image.asset('images/s3.png', width: 20)),
                  title: Text("About Us",
                      style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w600)),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => WebViewScreen(
                                title: "Privacy Policy",
                                url: "http://employee.myprofitinc.com/aboutus",
                              )),
                    );
                  },
                ),
              ),
              // Container(
              //   decoration: BoxDecoration(
              //     border: Border(bottom: BorderSide(width: 0.7, color: Color(0xffcdcdcd))),
              //   ),
              //   child: ListTile(
              //     leading: Container(width: 20, child: Image.asset('images/s4.png', width: 20)),
              //     title:
              //         Text("Rate Us", style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w600)),
              //   ),
              // ),
              // Container(
              //   decoration: BoxDecoration(
              //     border: Border(
              //         bottom: BorderSide(width: 0.7, color: Color(0xffcdcdcd))),
              //   ),
              //   child: ListTile(
              //     leading: Image.asset('images/s5.png', width: 20),
              //     title: Text("Change Language",
              //         style: TextStyle(
              //             color: Colors.black,
              //             fontSize: 15,
              //             fontWeight: FontWeight.w600)),
              //     onTap: () {
              //       Navigator.pop(context);
              //
              //       Navigator.push(
              //         context,
              //         MaterialPageRoute(builder: (context) => ChangeLanGuage()),
              //       );
              //       // logoutDialog();
              //     },
              //   ),
              // ),
              Container(
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(width: 0.7, color: Color(0xffcdcdcd))),
                ),
                child: ListTile(
                  leading: Container(width: 20, child: Image.asset('images/s6.png', width: 20)),
                  title: Text("Logout",
                      style:
                          TextStyle(color: Color.fromRGBO(249, 45, 40, 1), fontSize: 15, fontWeight: FontWeight.w600)),
                  onTap: () {
                    Navigator.pop(context);
                    logoutDialog();
                    // logoutDialog();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
