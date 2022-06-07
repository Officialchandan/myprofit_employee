import 'dart:developer';

import 'package:employee/model/get_location_response.dart';
import 'package:employee/provider/api_provider.dart';
import 'package:employee/src/ui/drawer/drawer.dart';
import 'package:employee/src/ui/home/home.dart';
import 'package:employee/src/ui/performance_tracker/performance_tracker.dart';
import 'package:employee/src/ui/userregister/user_register_screen.dart';
import 'package:employee/utils/colors.dart';
import 'package:employee/utils/network.dart';
import 'package:employee/utils/sharedpref.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class BottomNavigation extends StatefulWidget {
  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();

  // var titleList = ['Home', 'Driver List', 'Performance Tracker'];
  bool checked = false;
  late List<Widget> listScreens;
  late TabController _tabController;
  //  _TabContainerState(page);
  int selectedTab = 0;
  OnSelectListener? listener;

  GetAlotedAreaResponse? res;
  var success;

  getArea() async {
    res = await ApiProvider().getAlotedArea();

    success = res!.success;
    log("====>${await SharedPref.setIntegerPreference(SharedPref.LOCATION, res!.data![0].id)}");
    log("====>${await SharedPref.getIntegerPreference(SharedPref.LOCATION)}");
    await SharedPref.setIntegerPreference(SharedPref.LOCATION, res!.data![0].id);

    setState(() {});
  }

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this, initialIndex: 0);
    _tabController.addListener(_onTab);
    super.initState();
    getArea();
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

                  if (await Network.isConnected()) {
                    SystemChannels.textInput.invokeMethod("TextInput.hide");
                    print("kai kroge +");
                    // Navigator.pushAndRemoveUntil(
                    //     context,
                    //     MaterialPageRoute(builder: (context) => Login()),
                    //     ModalRoute.withName("/"));

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
        } else if (Navigator.canPop(context)) {
          Navigator.pop(context);
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
          body: TabBarView(controller: _tabController, physics: NeverScrollableScrollPhysics(), children: [
            Home(onTab: () {
              _scaffoldkey.currentState!.openDrawer();
            }),
            UserRegister(onTab: (OnSelectListener listener) {
              this.listener = listener;
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
              borderSide: BorderSide(width: 3, color: ColorPrimary),
              insets: EdgeInsets.fromLTRB(30, 0, 30, 70),
            ),
            onTap: (index) {
              if (index == 1) {
                show();
                getArea();
              }
            },
            labelColor: ColorPrimary,
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
                        scale: 2,
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
                        scale: 2,
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
                        scale: 2,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  show() {
    showModalBottomSheet(
        isDismissible: false,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        context: context,
        builder: (BuildContext context) {
          return Container(
              padding: EdgeInsets.only(top: 10),
              height: 250,
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 5,
                    ),
                    Container(
                        height: 20,
                        width: 20,
                        child: Icon(
                          Icons.location_on,
                        )),
                    Text(
                      "   Select Area",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: 120,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        child: Text(
                          "Cancel",
                          style: TextStyle(color: Colors.red, fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                success == true && res != null
                    ? Expanded(
                        child: ListView.builder(
                            itemCount: res!.data!.length,
                            itemBuilder: (context, index) {
                              return CheckboxListTile(
                                title: Text(
                                  "${res!.data![index].locationName}",
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                                value: res!.data![index].checked,
                                activeColor: ColorPrimary,
                                checkColor: Colors.white,
                                onChanged: (value) {
                                  if (value == true) {
                                    res!.data!.forEach((element) {
                                      element.checked = false;

                                      setState(() {});
                                    });

                                    res!.data![index].checked = value!;
                                  }
                                  if (value == false) {
                                    res!.data![index].checked = value!;
                                  }
                                  Navigator.pop(context, res!.data![index].id);
                                },
                              );

                              // return Column(children: [
                              //   // GestureDetector(
                              //   //   onTap: () {
                              //   //Navigator.pop(context, res!.data![index].id);
                              //   // Navigator.pushAndRemoveUntil(
                              //   //     context,
                              //   //     MaterialPageRoute(
                              //   //         builder: (context) => UserRegister(
                              //   //               onTab: () {},
                              //   //               location:
                              //   //                   (res!.data![index].id)
                              //   //                       .toString(),
                              //   //             )),
                              //   //     (Route<dynamic> route) => false);
                              //   // },
                              //   // child:
                              //   ListTile(
                              //     title: Text(
                              //       "${res!.data![index].locationName}",
                              //       style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              //     ),
                              //     trailing: Checkbox(
                              //       activeColor: ColorPrimary,
                              //       value: res!.data![index].checked,
                              //       onChanged: (value) {
                              //         if (value == true) {
                              //           res!.data!.forEach((element) {
                              //             element.checked = false;
                              //
                              //             setState(() {});
                              //           });
                              //
                              //           res!.data![index].checked = value!;
                              //         }
                              //         if (value == false) {
                              //           res!.data![index].checked = value!;
                              //         }
                              //         Navigator.pop(context, res!.data![index].id);
                              //       },
                              //     ),
                              //   ),
                              //   //   ),
                              //   Divider(
                              //     thickness: 1,
                              //   )
                              // ]);
                            }),
                      )
                    : res != null
                        ? Center(
                            child: Text("Area not allocated"),
                          )
                        : Center(
                            child: CircularProgressIndicator(
                            color: ColorPrimary,
                          )),
              ]));
        }).then((value) {
      if (value != null && listener != null) {
        listener!.onAreaSelect(value.toString());
      } else {
        _tabController.animateTo(0);
      }
    });
  }
}
