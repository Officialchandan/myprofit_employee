import 'package:fluttertoast/fluttertoast.dart';
import 'package:myprofit_employee/model/drivers_day_response.dart';
import 'package:myprofit_employee/model/drivers_week_response.dart';
import 'package:myprofit_employee/model/get_employee_tracket.dart';
import 'package:myprofit_employee/model/getcity_by_state_response.dart';
import 'package:myprofit_employee/provider/api_provider.dart';
import 'package:myprofit_employee/src/ui/dhabasday/dhabas_day.dart';
import 'package:myprofit_employee/src/ui/dhabasmonthly/dhabas_monthly.dart';
import 'package:myprofit_employee/src/ui/dhabasweek/dhabas_week.dart';
import 'package:myprofit_employee/src/ui/drawer/drawer.dart';
import 'package:myprofit_employee/src/ui/driverday/drivers_day.dart';
import 'package:myprofit_employee/src/ui/driversmonthly/drivers_monthly.dart';
import 'package:myprofit_employee/src/ui/driverweek/drivers_weekly.dart';
import 'package:myprofit_employee/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myprofit_employee/utils/network.dart';

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
    setState(() {});
    print(tracker);
  }

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
          backgroundColor: Color.fromRGBO(102, 87, 244, 1),
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
          title: Text('Performance Tracker',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
          centerTitle: true,
        ),
        body: tracker == null
            ? Center(child: CircularProgressIndicator())
            : Container(
                padding: EdgeInsets.all(20),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "(|) No of Vendors ",
                              style: GoogleFonts.openSans(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "${tracker!.data!.registeredVendors}",
                              style: GoogleFonts.openSans(
                                fontSize: 18,
                                color: ColorPrimary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ]),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "(||) No of Customer ",
                              style: GoogleFonts.openSans(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "${tracker!.data!.registeredCustomer}",
                              style: GoogleFonts.openSans(
                                fontSize: 18,
                                color: ColorPrimary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ]),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "(|||) No of not Intrested Customer ",
                              style: GoogleFonts.openSans(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "${tracker!.data!.notInterestedCustomer}",
                              style: GoogleFonts.openSans(
                                fontSize: 18,
                                color: ColorPrimary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ]),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //   children: [
                      //     MaterialButton(
                      //       minWidth: deviceWidth * 0.26,
                      //       height: 40,
                      //       padding: const EdgeInsets.all(8.0),
                      //       textColor: Colors.white,
                      //       color: ColorPrimary,
                      //       shape: RoundedRectangleBorder(
                      //           borderRadius: BorderRadius.circular(5)),
                      //       onPressed: () async {
                      //         if (await Network.isConnected()) {
                      //           // getDailyDriver();
                      //           Navigator.push(
                      //               context,
                      //               MaterialPageRoute(
                      //                   builder: (context) => DhabasDay()));
                      //         } else {
                      //           Fluttertoast.showToast(
                      //               backgroundColor: ColorPrimary,
                      //               textColor: Colors.white,
                      //               msg: "Turn on the internet");
                      //         }
                      //       },
                      //       child: new Text(
                      //         " Day",
                      //         style: GoogleFonts.openSans(
                      //             fontSize: 15,
                      //             fontWeight: FontWeight.w600,
                      //             decoration: TextDecoration.none),
                      //       ),
                      //     ),
                      //     MaterialButton(
                      //       minWidth: deviceWidth * 0.26,
                      //       height: 40,
                      //       padding: const EdgeInsets.all(8.0),
                      //       textColor: Colors.white,
                      //       color: ColorPrimary,
                      //       shape: RoundedRectangleBorder(
                      //           borderRadius: BorderRadius.circular(5)),
                      //       onPressed: () async {
                      //         if (await Network.isConnected()) {
                      //           Navigator.push(
                      //               context,
                      //               MaterialPageRoute(
                      //                   builder: (context) => DhabasWeekly()));
                      //         } else {
                      //           Fluttertoast.showToast(
                      //               backgroundColor: ColorPrimary,
                      //               textColor: Colors.white,
                      //               msg: "Turn on the internet");
                      //         }
                      //       },
                      //       child: new Text(
                      //         "Week",
                      //         style: GoogleFonts.openSans(
                      //             fontSize: 15,
                      //             fontWeight: FontWeight.w600,
                      //             decoration: TextDecoration.none),
                      //       ),
                      //     ),
                      //     MaterialButton(
                      //       minWidth: deviceWidth * 0.26,
                      //       height: 40,
                      //       padding: const EdgeInsets.all(8.0),
                      //       textColor: Colors.white,
                      //       color: ColorPrimary,
                      //       shape: RoundedRectangleBorder(
                      //           borderRadius: BorderRadius.circular(5)),
                      //       onPressed: () async {
                      //         if (await Network.isConnected()) {
                      //           Navigator.push(
                      //               context,
                      //               MaterialPageRoute(
                      //                   builder: (context) => DhabasMonthly()));
                      //         } else {
                      //           Fluttertoast.showToast(
                      //               backgroundColor: ColorPrimary,
                      //               textColor: Colors.white,
                      //               msg: "Turn on the internet");
                      //         }
                      //       },
                      //       child: new Text(
                      //         "Monthly",
                      //         style: GoogleFonts.openSans(
                      //             fontSize: 15,
                      //             fontWeight: FontWeight.w600,
                      //             decoration: TextDecoration.none),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      // SizedBox(
                      //   height: 30,
                      // ),
                      // Text(
                      //   "(||) No of Driver",
                      //   style: GoogleFonts.openSans(
                      //     fontSize: 16,
                      //     fontWeight: FontWeight.w600,
                      //   ),
                      // ),
                      // SizedBox(
                      //   height: 15,
                      // ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //   children: [
                      //     MaterialButton(
                      //       minWidth: deviceWidth * 0.26,
                      //       height: 40,
                      //       padding: const EdgeInsets.all(8.0),
                      //       textColor: Colors.white,
                      //       color: ColorPrimary,
                      //       shape: RoundedRectangleBorder(
                      //           borderRadius: BorderRadius.circular(5)),
                      //       onPressed: () async {
                      //         if (await Network.isConnected()) {
                      //           Navigator.push(
                      //               context,
                      //               MaterialPageRoute(
                      //                   builder: (context) => DriversDay()));
                      //         } else {
                      //           Fluttertoast.showToast(
                      //               backgroundColor: ColorPrimary,
                      //               textColor: Colors.white,
                      //               msg: "Turn on the internet");
                      //         }
                      //       },
                      //       child: new Text(
                      //         " Day",
                      //         style: GoogleFonts.openSans(
                      //             fontSize: 15,
                      //             fontWeight: FontWeight.w600,
                      //             decoration: TextDecoration.none),
                      //       ),
                      //     ),
                      //     MaterialButton(
                      //       minWidth: deviceWidth * 0.26,
                      //       height: 40,
                      //       padding: const EdgeInsets.all(8.0),
                      //       textColor: Colors.white,
                      //       color: ColorPrimary,
                      //       shape: RoundedRectangleBorder(
                      //           borderRadius: BorderRadius.circular(5)),
                      //       onPressed: () async {
                      //         if (await Network.isConnected()) {
                      //           Navigator.push(
                      //               context,
                      //               MaterialPageRoute(
                      //                   builder: (context) => DriversWeekly()));
                      //         } else {
                      //           Fluttertoast.showToast(
                      //               backgroundColor: ColorPrimary,
                      //               textColor: Colors.white,
                      //               msg: "Turn on the internet");
                      //         }
                      //       },
                      //       child: new Text(
                      //         "Week",
                      //         style: GoogleFonts.openSans(
                      //             fontSize: 15,
                      //             fontWeight: FontWeight.w600,
                      //             decoration: TextDecoration.none),
                      //       ),
                      //     ),
                      //     MaterialButton(
                      //       minWidth: deviceWidth * 0.26,
                      //       height: 40,
                      //       padding: const EdgeInsets.all(8.0),
                      //       textColor: Colors.white,
                      //       color: ColorPrimary,
                      //       shape: RoundedRectangleBorder(
                      //           borderRadius: BorderRadius.circular(5)),
                      //       onPressed: () async {
                      //         if (await Network.isConnected()) {
                      //           Navigator.push(
                      //               context,
                      //               MaterialPageRoute(
                      //                   builder: (context) => DriversMonthly()));
                      //         } else {
                      //           Fluttertoast.showToast(
                      //               backgroundColor: ColorPrimary,
                      //               textColor: Colors.white,
                      //               msg: "Turn on the internet ");
                      //         }
                      //       },
                      //       child: new Text(
                      //         "Monthly",
                      //         style: GoogleFonts.openSans(
                      //             fontSize: 15,
                      //             fontWeight: FontWeight.w600,
                      //             decoration: TextDecoration.none),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
