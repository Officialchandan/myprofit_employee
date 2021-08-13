import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myprofit_employee/model/getvenordbyid_response.dart';
import 'package:myprofit_employee/provider/api_provider.dart';
import 'package:myprofit_employee/src/ui/bottom_navigation/bottom_navigation.dart';
import 'package:myprofit_employee/src/ui/editvendor_details/edit_vendor_detail.dart';
import 'package:myprofit_employee/src/ui/home/home.dart';
import 'package:myprofit_employee/src/ui/vendor_form/vendor_form.dart';
import 'package:myprofit_employee/utils/colors.dart';
import 'package:myprofit_employee/utils/network.dart';
import 'package:rxdart/rxdart.dart';

class AddFootwear extends StatefulWidget {
  final String title;
  final int id;

  const AddFootwear({required this.title, required this.id});
  @override
  _AddFootwearState createState() => _AddFootwearState(this.title, this.id);
}

class _AddFootwearState extends State<AddFootwear> {
  // var t = widget.title;
  var footwearListText = [
    'Shoe Fly',
    'Sole Mates',
    'Hot Heels Boutique',
    'FootCandy Shoes',
    'Kickass Kicks'
  ];
  var datas = [];
  _AddFootwearState(String title, int id);
  final PublishSubject<List<GetVendorByIdResponseData>> subject =
      PublishSubject();

  // GetVendorByIdResponse? loginData;
  List<GetVendorByIdResponseData> loginData = [];
  @override
  void dispose() {
    super.dispose();
    subject.close();
  }

  @override
  void initState() {
    super.initState();
    getVendorId(widget.id);
  }

  //searching
  TextEditingController _searchController = TextEditingController();

  String searchText = "";
  bool searching = false;

  Future<List<GetVendorByIdResponseData>> getVendorId(id) async {
    if (await Network.isConnected()) {
      SystemChannels.textInput.invokeMethod("TextInput.hide");
      print("kai kroge +${id}");
      GetVendorByIdResponse getVendor = await ApiProvider().getVendorId(id);
      if (getVendor.success) {
        loginData = getVendor.data!;
        subject.add(loginData);
        log("ggg ${loginData}");
        //  setState(() {});
      }

      // SharedPref.setStringPreference(SharedPref.USERSTATUS, loginData.status);

    } else {
      Fluttertoast.showToast(
          backgroundColor: ColorPrimary,
          textColor: Colors.white,
          msg: "Please turn on  internet");
    }
    return loginData;
    //_tap = true;
  }

  List<GetVendorByIdResponseData> categorieslist = [];
  var gradientColor = GradientTemplate.gradientTemplate;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => BottomNavigation()));
        return Future.value(false);
      },
      child: SafeArea(
          child: StreamBuilder<List<GetVendorByIdResponseData>>(
              stream: subject.stream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Text("Data Not Found"),
                  );
                }
                return Scaffold(
                    backgroundColor: Colors.white,
                    appBar: AppBar(
                      backgroundColor: Color.fromRGBO(102, 87, 244, 1),
                      leading: Builder(
                        builder: (BuildContext context) {
                          return IconButton(
                            icon: const Icon(Icons.arrow_back_ios),
                            iconSize: 20,
                            onPressed: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          BottomNavigation()));
                            },
                          );
                        },
                      ),
                      title: Text('${widget.title}',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w600)),
                      // centerTitle: true,
                      actions: [
                        // loginData.isEmpty
                        //     ? Container()
                        //     :
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: GestureDetector(
                            child: Center(
                              child: Stack(
                                children: [
                                  Container(
                                    height: 35,
                                    color: Colors.transparent,
                                    child: FittedBox(
                                      //height: 55,
                                      // constraints: BoxConstraints(
                                      //   minWidth: 150,
                                      // ),
                                      child: Container(
                                        //width: 150,

                                        height: 30,
                                        margin: EdgeInsets.all(8),
                                        padding: EdgeInsets.only(
                                            right: 35, left: 10),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: AutoSizeText(
                                            'Add ${widget.title}',
                                            style: TextStyle(
                                              color: ColorPrimary,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            minFontSize: 12,
                                            maxFontSize: 14,
                                            maxLines: 1,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: -2,
                                    right: -5,
                                    child: Image.asset('images/w-plus.png',
                                        width: 40, fit: BoxFit.cover),
                                  ),
                                ],
                              ),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => VendorForm(
                                          id: widget.id,
                                          title: widget.title,
                                        )),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    body: Column(
                        //height: 400,
                        children: [
                          // loginData.isEmpty

                          //     ? GestureDetector(
                          //         child: Center(
                          //           child: Stack(
                          //             children: [
                          //               Container(
                          //                 height: 56,
                          //                 child: FittedBox(
                          //                   //height: 55,
                          //                   // constraints: BoxConstraints(
                          //                   //   minWidth: 150,
                          //                   // ),
                          //                   child: Container(
                          //                     //width: 150,
                          //                     height: 50,
                          //                     margin: EdgeInsets.all(8),
                          //                     padding: EdgeInsets.only(
                          //                         right: 65, left: 20),
                          //                     decoration: BoxDecoration(
                          //                       color:
                          //                           Color.fromRGBO(102, 87, 244, 1),
                          //                       borderRadius:
                          //                           BorderRadius.circular(50),
                          //                     ),
                          //                     child: Align(
                          //                       alignment: Alignment.centerLeft,
                          //                       child: Text(
                          //                         'Add ${widget.title} ',
                          //                         style: TextStyle(
                          //                           color: Colors.white,
                          //                           fontSize: 17,
                          //                           fontWeight: FontWeight.w600,
                          //                         ),
                          //                         maxLines: 1,
                          //                       ),
                          //                     ),
                          //                   ),
                          //                 ),
                          //               ),
                          //               Positioned(
                          //                 top: -15,
                          //                 right: -15,
                          //                 child: Image.asset('images/p-plus.png',
                          //                     width: 80, fit: BoxFit.cover),
                          //               ),
                          //             ],
                          //           ),
                          //         ),
                          //         onTap: () {
                          //           Navigator.push(
                          //             context,
                          //             MaterialPageRoute(
                          //                 builder: (context) => VendorForm(
                          //                     id: widget.id, title: widget.title)),
                          //           );
                          //         },
                          //       )
                          // :

                          TextFormField(
                            controller: _searchController,
                            autofocus: false,
                            decoration: InputDecoration(
                              isCollapsed: true,
                              contentPadding: EdgeInsets.fromLTRB(10, 8, 5, 8),
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Search Category',
                              hintStyle: TextStyle(
                                  color: Color.fromRGBO(85, 85, 85, 1),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(7),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            onChanged: (text) {
                              List<GetVendorByIdResponseData> searchList = [];
                              if (text.isNotEmpty) {
                                print("searchText -->$text");

                                log("ram ${loginData}");
                                for (int i = 0; i < loginData.length; i++) {
                                  if (loginData[i]
                                      .name
                                      .toLowerCase()
                                      .contains(text.toLowerCase())) {
                                    print("Container -->$text");
                                    searchList.add(loginData[i]);
                                    log("ram ${loginData[i].name}");
                                  } else {
                                    print("Container -->data not found");
                                  }
                                }

                                subject.add(searchList);
                              } else {
                                subject.add(categorieslist);
                              }
                            },
                          ),

                          Expanded(
                            flex: 1,
                            child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: loginData.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return GestureDetector(
                                    child: Container(
                                      margin: const EdgeInsets.only(
                                          bottom: 10,
                                          top: 10,
                                          left: 10,
                                          right: 10),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 8),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.grey.shade400,
                                              blurRadius: 4,
                                              spreadRadius: 2,
                                              offset: Offset(2, 2)),
                                        ],
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)),
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(loginData[index].name,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600)),
                                              SizedBox(height: 5),
                                              Text(
                                                  '+91 ${loginData[index].ownerMobile}',
                                                  style: TextStyle(
                                                      color: Color(0xff555555),
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600)),
                                              SizedBox(height: 5),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Image.asset(
                                                      'images/g-pin.png',
                                                      width: 13),
                                                  Text(
                                                      ' ${loginData[index].address}',
                                                      style: TextStyle(
                                                          color:
                                                              Color(0xff555555),
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w600)),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  UpdateVendorDetail(
                                                      title: widget.title,
                                                      id: widget.id,
                                                      vendordata:
                                                          loginData[index])));
                                    },
                                  );
                                }),
                          ),

                          //dhaba-list
                        ]));
              })),
    );
  }
}
