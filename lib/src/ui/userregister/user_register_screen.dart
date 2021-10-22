import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myprofit_employee/src/ui/userregister/user_not_intrested.dart';
import 'package:myprofit_employee/utils/colors.dart';
import 'package:myprofit_employee/utils/validator.dart';

class UserRegister extends StatefulWidget {
  final Function onTab;
  UserRegister({
    Key? key,
    required this.onTab,
  }) : super(key: key);

  @override
  _UserRegisterState createState() => _UserRegisterState();
}

class _UserRegisterState extends State<UserRegister> {
  var nameList = [
    'John Parker',
    'George Smith',
    'Devin Coinneach',
    'Brayden Aaron'
  ];
  TextEditingController _name = TextEditingController();
  TextEditingController _emailaddress = TextEditingController();

  TextEditingController _mobile = TextEditingController();
  TextEditingController _address = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Color.fromRGBO(102, 87, 244, 1),
            // leading: Builder(
            //   builder: (BuildContext context) {
            //     return InkWell(
            //       child: Padding(
            //         padding: EdgeInsets.fromLTRB(10, 15, 15, 15),
            //         child: Image.asset('images/@3x/w-menu.png'),
            //       ),
            //       onTap: () {
            //         widget.onTab();
            //       },
            //     );
            //   },
            // ),
            title: Text('User Register',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
            centerTitle: true,
            // actions: [
            //   GestureDetector(
            //     child: Stack(
            //       children: [
            //         Container(
            //           margin: EdgeInsets.fromLTRB(0, 14, 16, 0),
            //           padding: EdgeInsets.fromLTRB(14, 7, 25, 7),
            //           decoration: BoxDecoration(
            //             color: Colors.white,
            //             borderRadius: BorderRadius.circular(50),
            //           ),
            //           child: Text('Add Driver ', style: TextStyle(color: Color.fromRGBO(102, 87, 244, 1), fontSize: 12, fontWeight: FontWeight.w600)),
            //         ),
            //         Positioned(
            //           top: 9,
            //           right: 4,
            //           child: Image.asset('images/@3x/w-plus.png', width: 40),
            //         ),
            //       ],
            //     ),
            //     onTap: (){
            //       Navigator.push(
            //         context,
            //         MaterialPageRoute(builder: (context) => DriverForm()),
            //       );
            //     },
            //   )
            // ],
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.fromLTRB(16, 14, 16, 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Name',
                      style: TextStyle(
                          color: Color.fromRGBO(48, 48, 48, 1),
                          fontSize: 15,
                          fontWeight: FontWeight.w600)),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _name,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z ]')),
                    ],
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    //autovalidate: true,
                    maxLength: 25,
                    decoration: InputDecoration(
                      counterText: "",
                      contentPadding:
                          EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                      filled: true,
                      fillColor: Color.fromRGBO(242, 242, 242, 1),
                      hintText: 'Enter here',
                      hintStyle: TextStyle(
                          color: ColorTextPrimary,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text('Mobile',
                      style: TextStyle(
                          color: Color.fromRGBO(48, 48, 48, 1),
                          fontSize: 15,
                          fontWeight: FontWeight.w600)),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _mobile,
                    keyboardType: TextInputType.number,
                    validator: (numb) =>
                        Validator.validateMobile(numb!, context),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    maxLength: 10,
                    autofocus: false,
                    decoration: InputDecoration(
                      counterText: "",
                      contentPadding:
                          EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                      filled: true,
                      fillColor: Color.fromRGBO(242, 242, 242, 1),
                      hintText: 'Enter here',
                      hintStyle: TextStyle(
                          color: ColorTextPrimary,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text('Email Address',
                      style: TextStyle(
                          color: Color.fromRGBO(48, 48, 48, 1),
                          fontSize: 15,
                          fontWeight: FontWeight.w600)),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _emailaddress,
                    validator: (numb) => Validator.emailValidator(numb!),
                    autovalidateMode: AutovalidateMode.onUserInteraction,

                    //autovalidate: true,
                    maxLength: 25,
                    decoration: InputDecoration(
                      counterText: "",
                      contentPadding:
                          EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                      filled: true,
                      fillColor: Color.fromRGBO(242, 242, 242, 1),
                      hintText: 'Enter here',
                      hintStyle: TextStyle(
                          color: ColorTextPrimary,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text('Address',
                      style: TextStyle(
                          color: Color.fromRGBO(48, 48, 48, 1),
                          fontSize: 15,
                          fontWeight: FontWeight.w600)),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _address,

                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    //autovalidate: true,
                    maxLength: 25,
                    decoration: InputDecoration(
                      counterText: "",
                      contentPadding:
                          EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                      filled: true,
                      fillColor: Color.fromRGBO(242, 242, 242, 1),
                      hintText: 'Enter here',
                      hintStyle: TextStyle(
                          color: ColorTextPrimary,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (contex) => UserNotInterested()));
                        },
                        child: Text(
                          "User Not Interested",
                          style: TextStyle(
                              fontSize: 18,
                              decoration: TextDecoration.underline,
                              color: ColorTextPrimary,
                              fontWeight: FontWeight.w500),
                        ),
                      )),
                  SizedBox(
                    height: 40,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: ButtonTheme(
                      minWidth: 240,
                      // ignore: deprecated_member_use
                      child: RaisedButton(
                        padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                        color: Color.fromRGBO(102, 87, 244, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        onPressed: () {
                          log("kai kai---->");
                        },
                        child: Text(
                          "REGISTER",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )

          // ListView(
          //   children: List.generate(4, (index) {
          //     return GestureDetector(
          //       child: Container(
          //         padding: EdgeInsets.fromLTRB(16, 14, 16, 10),
          //         decoration: BoxDecoration(
          //           border: Border(
          //               bottom: BorderSide(width: 1, color: Color(0xffcdcdcd))),
          //         ),
          //         child: Column(
          //           children: [
          //             Align(
          //               alignment: Alignment.topLeft,
          //               child: Text(nameList[index],
          //                   style: TextStyle(
          //                       color: Colors.black,
          //                       fontSize: 16,
          //                       fontWeight: FontWeight.w600)),
          //             ),
          //             SizedBox(height: 5),
          //             Align(
          //               alignment: Alignment.topLeft,
          //               child: Text('+91 9820347326',
          //                   style: TextStyle(
          //                       color: Color(0xff555555),
          //                       fontSize: 14,
          //                       fontWeight: FontWeight.w600)),
          //             ),
          //             SizedBox(height: 5),
          //             Row(
          //               mainAxisAlignment: MainAxisAlignment.start,
          //               children: [
          //                 Image.asset('images/g-pin.png', width: 13),
          //                 Text('2859, Timbercrest Road',
          //                     style: TextStyle(
          //                         color: Color(0xff555555),
          //                         fontSize: 14,
          //                         fontWeight: FontWeight.w600)),
          //               ],
          //             ),
          //           ],
          //         ),
          //       ),
          //       onTap: () {
          //         Navigator.push(
          //           context,
          //           MaterialPageRoute(builder: (context) => DriverForm()),
          //         );
          //       },
          //     );
          //   }),
          // ),
          ),
    );
  }
}
