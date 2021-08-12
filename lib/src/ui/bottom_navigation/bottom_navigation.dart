import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myprofit_employee/src/ui/drawer/drawer.dart';
import 'package:myprofit_employee/src/ui/home/home.dart';
import 'package:myprofit_employee/src/ui/driver_list/driver_list.dart';
import 'package:myprofit_employee/src/ui/performance_tracker/performance_tracker.dart';
import 'package:myprofit_employee/utils/colors.dart';
import 'package:myprofit_employee/utils/network.dart';

class BottomNavigation extends StatefulWidget {
  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation>
    with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();

  // var titleList = ['Home', 'Driver List', 'Performance Tracker'];

  late List<Widget> listScreens;
  late TabController _tabController;
  //  _TabContainerState(page);
  int selectedTab = 0;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this, initialIndex: 0);
    _tabController.addListener(_onTab);
    super.initState();
  }

  _onTab() {
    setState(() {
      selectedTab = _tabController.index;
    });
  }

  logoutDialog() {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            contentPadding: EdgeInsets.fromLTRB(25, 10, 0, 0),
            title: Text("Logout",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w600)),
            content: Text("Are you sure you want to logout?",
                style: TextStyle(
                    color: Color.fromRGBO(85, 85, 85, 1),
                    fontSize: 15,
                    fontWeight: FontWeight.w500)),
            actions: [
              MaterialButton(
                child: Text("Cancel",
                    style: TextStyle(
                        color: ColorTextPrimary, fontWeight: FontWeight.w600)),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              MaterialButton(
                child: Text("Logout",
                    style: TextStyle(
                        color: Color(0xfff4511e), fontWeight: FontWeight.w600)),
                onPressed: () async {
                  log("ndndnd");

                  if (await Network.isConnected()) {
                    SystemChannels.textInput.invokeMethod("TextInput.hide");
                    print("kai kroge +");
                    // Navigator.pushAndRemoveUntil(
                    //     context,
                    //     MaterialPageRoute(builder: (context) => Login()),
                    //     ModalRoute.withName("/"));

                    Fluttertoast.showToast(
                        backgroundColor: ColorPrimary,
                        textColor: Colors.white,
                        msg: "Logout Successfully"
                        // timeInSecForIos: 3
                        );
                  } else {
                    Fluttertoast.showToast(
                        backgroundColor: ColorPrimary,
                        textColor: Colors.white,
                        msg: "Please turn on  internet");
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

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (Navigator.canPop(context) && _tabController.index != 0) {
          Navigator.pop(context);
        } else if (_tabController.index != 0) {
          // Navigator.pop(context);
          //   _tabController.index == 3 ?
          //   Fluttertoast.showToast(msg: "HI")
          //   :
          //   if (Navigator.canPop(context)) {
          //   Navigator.pop(context);
          // } else {
          //   SystemNavigator.pop();
          //   return Future.value(true);
          // }

          _tabController.animateTo(0);
        } else {
          SystemNavigator.pop();
        }
        return Future.value(false);

        // _tabController.index == 0
        //     ? SystemNavigator.pop()
        //     : _tabController.animateTo(0);
        // return Future.value(false);
      },
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          key: _scaffoldkey,
          drawer: AppDrawer(),
          body: TabBarView(
              controller: _tabController,
              physics: NeverScrollableScrollPhysics(),
              children: [
                Home(onTab: () {
                  _scaffoldkey.currentState!.openDrawer();
                }),
                DriverList(onTab: () {
                  _scaffoldkey.currentState!.openDrawer();
                }),
                PerformanceTracker(onTab: () {
                  _scaffoldkey.currentState!.openDrawer();
                }),
              ]),
          bottomNavigationBar: TabBar(
            controller: _tabController,
            // indicatorWeight: 10,
            // indicatorColor: Colors.black,
            // automaticIndicatorColorAdjustment: true,
            indicator: UnderlineTabIndicator(
              borderSide:
                  BorderSide(width: 3, color: Color.fromRGBO(102, 87, 244, 1)),
              insets: EdgeInsets.fromLTRB(30, 0, 30, 70),
            ),
            labelColor: Color.fromRGBO(102, 87, 244, 1),
            labelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
            unselectedLabelColor: Color.fromRGBO(128, 128, 128, 1),
            tabs: [
              Tab(
                text: 'Categories',
                icon: selectedTab == 0
                    ? Image.asset(
                        "images/f1-a.png",
                        scale: 8,
                      )
                    : Image.asset(
                        "images/f1.png",
                        scale: 8,
                      ),
              ),
              Tab(
                text: 'Survey',
                icon: selectedTab == 1
                    ? Image.asset(
                        "images/f2-a.png",
                        scale: 8,
                      )
                    : Image.asset(
                        "images/f2.png",
                        scale: 8,
                      ),
              ),
              Tab(
                text: 'Performance',
                icon: selectedTab == 2
                    ? Image.asset(
                        "images/f3-a.png",
                        scale: 8,
                      )
                    : Image.asset(
                        "images/f3.png",
                        scale: 8,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
