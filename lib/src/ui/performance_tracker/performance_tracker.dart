import 'package:employee/model/drivers_week_response.dart';
import 'package:employee/model/get_employee_tracket.dart';
import 'package:employee/provider/api_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/colors.dart';

class PerformanceTracker extends StatefulWidget {
  final Function onTab;
  PerformanceTracker({
    Key? key,
    required this.onTab,
  }) : super(key: key);

  @override
  _PerformanceTrackerState createState() => _PerformanceTrackerState();
}

class _PerformanceTrackerState extends State<PerformanceTracker> {
  GetEmployeTrackerResponse? tracker;
  getDailyDriver() async {
    DriverWeeklyResponse result = await ApiProvider().getWeeklyDrivers();
    tracker = await ApiProvider().getEmployeTracker();
    a = tracker!.data!.registeredVendors;
    b = tracker!.data!.registeredCustomer;
    c = tracker!.data!.notInterestedCustomer;
    setState(() {});
    print(tracker);
  }

  String a = "0", b = "0", c = "0";
  @override
  initState() {
    // TODO: implement initState
    getDailyDriver();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: ColorPrimary,
          leading: Builder(
            builder: (BuildContext context) {
              return InkWell(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(10, 15, 15, 15),
                  child: Image.asset('images/@3x/w-menu.png'),
                ),
                onTap: () {
                  widget.onTab();
                },
              );
            },
          ),
          title: Text('Performance Tracker', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
          centerTitle: true,
        ),
        body: tracker == null
            ? Center(
                child: CircularProgressIndicator(
                color: ColorPrimary,
              ))
            : Container(
                padding: EdgeInsets.all(15),

                child: Column(children: [
                  Stack(children: [
                    Container(
                      height: 70,
                      width: MediaQuery.of(context).size.width,
                      // margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        title: Text(
                          "Number of Vendors ",
                          style: GoogleFonts.openSans(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Text(
                            "$a",
                            style: GoogleFonts.openSans(
                              fontSize: 18,
                              color: ColorPrimary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                        left: 0,
                        top: 0,
                        bottom: 0,
                        child: Container(
                          width: 5,
                          decoration: BoxDecoration(
                              color: CustomColors.darkGolden.withOpacity(0.8),
                              borderRadius:
                                  BorderRadius.only(topLeft: Radius.circular(5), bottomLeft: Radius.circular(5))),
                        )),
                  ]),
                  SizedBox(
                    height: 20,
                  ),
                  Stack(children: [
                    Container(
                      height: 70,
                      width: MediaQuery.of(context).size.width,
                      // margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        title: Text(
                          "Number of Customer",
                          style: GoogleFonts.openSans(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Text(
                            "$b",
                            style: GoogleFonts.openSans(
                              fontSize: 18,
                              color: ColorPrimary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                        left: 0,
                        top: 0,
                        bottom: 0,
                        child: Container(
                          width: 5,
                          decoration: BoxDecoration(
                              color: CustomColors.darkGolden.withOpacity(0.8),
                              borderRadius:
                                  BorderRadius.only(topLeft: Radius.circular(5), bottomLeft: Radius.circular(5))),
                        )),
                  ]),
                  SizedBox(
                    height: 20,
                  ),
                  Stack(children: [
                    Container(
                      height: 70,
                      width: MediaQuery.of(context).size.width,
                      // margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        title: Text(
                          "Number of not Intrested Customer",
                          style: GoogleFonts.openSans(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Text(
                            "$c",
                            style: GoogleFonts.openSans(
                              fontSize: 18,
                              color: ColorPrimary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                        left: 0,
                        top: 0,
                        bottom: 0,
                        child: Container(
                          width: 5,
                          decoration: BoxDecoration(
                              color: CustomColors.darkGolden.withOpacity(0.8),
                              borderRadius:
                                  BorderRadius.only(topLeft: Radius.circular(5), bottomLeft: Radius.circular(5))),
                        )),
                  ]),
                ]),

                //       // Row(
                //       //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //       //   children: [
                //       //     MaterialButton(
                //       //       minWidth: deviceWidth * 0.26,
                //       //       height: 40,
                //       //       padding: const EdgeInsets.all(8.0),
                //       //       textColor: Colors.white,
                //       //       color: ColorPrimary,
                //       //       shape: RoundedRectangleBorder(
                //       //           borderRadius: BorderRadius.circular(5)),
                //       //       onPressed: () async {
                //       //         if (await Network.isConnected()) {
                //       //           // getDailyDriver();
                //       //           Navigator.push(
                //       //               context,
                //       //               MaterialPageRoute(
                //       //                   builder: (context) => DhabasDay()));
                //       //         } else {
                //       //           Fluttertoast.showToast(
                //       //               backgroundColor: ColorPrimary,
                //       //               textColor: Colors.white,
                //       //               msg: "Turn on the internet");
                //       //         }
                //       //       },
                //       //       child: new Text(
                //       //         " Day",
                //       //         style: GoogleFonts.openSans(
                //       //             fontSize: 15,
                //       //             fontWeight: FontWeight.bold,
                //       //             decoration: TextDecoration.none),
                //       //       ),
                //       //     ),
                //       //     MaterialButton(
                //       //       minWidth: deviceWidth * 0.26,
                //       //       height: 40,
                //       //       padding: const EdgeInsets.all(8.0),
                //       //       textColor: Colors.white,
                //       //       color: ColorPrimary,
                //       //       shape: RoundedRectangleBorder(
                //       //           borderRadius: BorderRadius.circular(5)),
                //       //       onPressed: () async {
                //       //         if (await Network.isConnected()) {
                //       //           Navigator.push(
                //       //               context,
                //       //               MaterialPageRoute(
                //       //                   builder: (context) => DhabasWeekly()));
                //       //         } else {
                //       //           Fluttertoast.showToast(
                //       //               backgroundColor: ColorPrimary,
                //       //               textColor: Colors.white,
                //       //               msg: "Turn on the internet");
                //       //         }
                //       //       },
                //       //       child: new Text(
                //       //         "Week",
                //       //         style: GoogleFonts.openSans(
                //       //             fontSize: 15,
                //       //             fontWeight: FontWeight.bold,
                //       //             decoration: TextDecoration.none),
                //       //       ),
                //       //     ),
                //       //     MaterialButton(
                //       //       minWidth: deviceWidth * 0.26,
                //       //       height: 40,
                //       //       padding: const EdgeInsets.all(8.0),
                //       //       textColor: Colors.white,
                //       //       color: ColorPrimary,
                //       //       shape: RoundedRectangleBorder(
                //       //           borderRadius: BorderRadius.circular(5)),
                //       //       onPressed: () async {
                //       //         if (await Network.isConnected()) {
                //       //           Navigator.push(
                //       //               context,
                //       //               MaterialPageRoute(
                //       //                   builder: (context) => DhabasMonthly()));
                //       //         } else {
                //       //           Fluttertoast.showToast(
                //       //               backgroundColor: ColorPrimary,
                //       //               textColor: Colors.white,
                //       //               msg: "Turn on the internet");
                //       //         }
                //       //       },
                //       //       child: new Text(
                //       //         "Monthly",
                //       //         style: GoogleFonts.openSans(
                //       //             fontSize: 15,
                //       //             fontWeight: FontWeight.bold,
                //       //             decoration: TextDecoration.none),
                //       //       ),
                //       //     ),
                //       //   ],
                //       // ),
                //       // SizedBox(
                //       //   height: 30,
                //       // ),
                //       // Text(
                //       //   "(||) Number of Driver",
                //       //   style: GoogleFonts.openSans(
                //       //     fontSize: 16,
                //       //     fontWeight: FontWeight.bold,
                //       //   ),
                //       // ),
                //       // SizedBox(
                //       //   height: 15,
                //       // ),
                //       // Row(
                //       //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //       //   children: [
                //       //     MaterialButton(
                //       //       minWidth: deviceWidth * 0.26,
                //       //       height: 40,
                //       //       padding: const EdgeInsets.all(8.0),
                //       //       textColor: Colors.white,
                //       //       color: ColorPrimary,
                //       //       shape: RoundedRectangleBorder(
                //       //           borderRadius: BorderRadius.circular(5)),
                //       //       onPressed: () async {
                //       //         if (await Network.isConnected()) {
                //       //           Navigator.push(
                //       //               context,
                //       //               MaterialPageRoute(
                //       //                   builder: (context) => DriversDay()));
                //       //         } else {
                //       //           Fluttertoast.showToast(
                //       //               backgroundColor: ColorPrimary,
                //       //               textColor: Colors.white,
                //       //               msg: "Turn on the internet");
                //       //         }
                //       //       },
                //       //       child: new Text(
                //       //         " Day",
                //       //         style: GoogleFonts.openSans(
                //       //             fontSize: 15,
                //       //             fontWeight: FontWeight.bold,
                //       //             decoration: TextDecoration.none),
                //       //       ),
                //       //     ),
                //       //     MaterialButton(
                //       //       minWidth: deviceWidth * 0.26,
                //       //       height: 40,
                //       //       padding: const EdgeInsets.all(8.0),
                //       //       textColor: Colors.white,
                //       //       color: ColorPrimary,
                //       //       shape: RoundedRectangleBorder(
                //       //           borderRadius: BorderRadius.circular(5)),
                //       //       onPressed: () async {
                //       //         if (await Network.isConnected()) {
                //       //           Navigator.push(
                //       //               context,
                //       //               MaterialPageRoute(
                //       //                   builder: (context) => DriversWeekly()));
                //       //         } else {
                //       //           Fluttertoast.showToast(
                //       //               backgroundColor: ColorPrimary,
                //       //               textColor: Colors.white,
                //       //               msg: "Turn on the internet");
                //       //         }
                //       //       },
                //       //       child: new Text(
                //       //         "Week",
                //       //         style: GoogleFonts.openSans(
                //       //             fontSize: 15,
                //       //             fontWeight: FontWeight.bold,
                //       //             decoration: TextDecoration.none),
                //       //       ),
                //       //     ),
                //       //     MaterialButton(
                //       //       minWidth: deviceWidth * 0.26,
                //       //       height: 40,
                //       //       padding: const EdgeInsets.all(8.0),
                //       //       textColor: Colors.white,
                //       //       color: ColorPrimary,
                //       //       shape: RoundedRectangleBorder(
                //       //           borderRadius: BorderRadius.circular(5)),
                //       //       onPressed: () async {
                //       //         if (await Network.isConnected()) {
                //       //           Navigator.push(
                //       //               context,
                //       //               MaterialPageRoute(
                //       //                   builder: (context) => DriversMonthly()));
                //       //         } else {
                //       //           Fluttertoast.showToast(
                //       //               backgroundColor: ColorPrimary,
                //       //               textColor: Colors.white,
                //       //               msg: "Turn on the internet ");
                //       //         }
                //       //       },
                //       //       child: new Text(
                //       //         "Monthly",
                //       //         style: GoogleFonts.openSans(
                //       //             fontSize: 15,
                //       //             fontWeight: FontWeight.bold,
                //       //             decoration: TextDecoration.none),
                //       //       ),
                //       //     ),
                //       //   ],
                //       // ),
                //     ],
                //   ),
                // ),
              ),
      ),
    );
  }
}
