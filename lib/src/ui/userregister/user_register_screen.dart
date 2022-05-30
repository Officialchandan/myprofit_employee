import 'dart:developer';

import 'package:employee/model/add_intrested_user.dart';
import 'package:employee/model/area_aloted_otp.dart';
import 'package:employee/provider/api_provider.dart';
import 'package:employee/src/ui/bottom_navigation/bottom_navigation.dart';
import 'package:employee/src/ui/userregister/user_not_intrested.dart';
import 'package:employee/utils/colors.dart';
import 'package:employee/utils/network.dart';
import 'package:employee/utils/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class OnSelectListener {
  onAreaSelect(String areaId);
}

class UserRegister extends StatefulWidget {
  final Function(OnSelectListener listener) onTab;

  final String? location;
  UserRegister({Key? key, required this.onTab, this.location}) : super(key: key);

  @override
  _UserRegisterState createState() => _UserRegisterState();
}

class _UserRegisterState extends State<UserRegister> implements OnSelectListener {
  var nameList = ['John Parker', 'George Smith', 'Devin Coinneach', 'Brayden Aaron'];
  String? areaId;

  _UserRegisterState();
  var userid;
  TextEditingController _name = TextEditingController();
  TextEditingController _emailaddress = TextEditingController();
  TextEditingController _pincode = TextEditingController();

  TextEditingController _mobile = TextEditingController();
  TextEditingController _address = TextEditingController();
  TextEditingController _otp = TextEditingController();
  int _character = -1;
  int _gift = -1;
  //otp api call
  otpapi(userid) async {
    if (await Network.isConnected()) {
      SystemChannels.textInput.invokeMethod("TextInput.hide");

      if (_otp.text.isEmpty) {
        Fluttertoast.showToast(backgroundColor: ColorPrimary, textColor: Colors.white, msg: "Please Enter OTP");
      } else {
        final GetLocationrOtpResponse loginData = await ApiProvider().getOtpIntrestedUser(userid, _otp.text);
        log("ooooo ${loginData}");
        if (loginData.success == true) {
          Fluttertoast.showToast(
            backgroundColor: ColorPrimary,
            textColor: Colors.white,
            msg: loginData.message,
          );
          _name.clear();
          _mobile.clear();
          _emailaddress.clear();
          _address.clear();
          _otp.clear();
          // Navigator.pop(context);

          Navigator.pushAndRemoveUntil(
              context, MaterialPageRoute(builder: (context) => BottomNavigation()), (Route<dynamic> route) => false);
        } else {
          Fluttertoast.showToast(
            backgroundColor: ColorPrimary,
            textColor: Colors.white,
            msg: loginData.success == false ? "OTP is incorrect" : "thanks for login ",
            // timeInSecForIos: 3
          );
        }
      }
    } else {
      Fluttertoast.showToast(
          backgroundColor: ColorPrimary, textColor: Colors.white, msg: "Please turn on the internet");
    }
  }

//otp dialog box
  _displayDialog(
    BuildContext context,
  ) async {
    return showDialog(
        context: context,
        builder: (context) {
          return ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 400, maxHeight: 150),
            child: AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              title: RichText(
                text: TextSpan(
                  text: "OTP Verification\n",
                  style: GoogleFonts.openSans(
                    fontSize: 20.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              content: TextField(
                controller: _otp,
                cursorColor: ColorPrimary,
                keyboardType: TextInputType.number,
                //inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                  filled: true,

                  // fillColor: Colors.black,
                  hintText: "Enter OTP",
                  hintStyle: GoogleFonts.openSans(
                    fontWeight: FontWeight.w600,
                  ),
                  contentPadding: const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: ColorPrimary, width: 2),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              actions: <Widget>[
                Center(
                  child: MaterialButton(
                    minWidth: MediaQuery.of(context).size.width * 0.60,
                    height: 50,
                    padding: const EdgeInsets.all(8.0),
                    textColor: Colors.white,
                    color: ColorPrimary,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    onPressed: () {
                      otpapi(userid);
                    },
                    child: new Text(
                      "Verify",
                      style: GoogleFonts.openSans(
                          fontSize: 17, fontWeight: FontWeight.w600, decoration: TextDecoration.none),
                    ),
                  ),
                ),
                Container(
                  height: 20,
                  width: MediaQuery.of(context).size.width * 0.95,
                  color: Colors.transparent,
                )
              ],
            ),
          );
        });
  }

//add intrested user api call
  addUser() async {
    if (await Network.isConnected()) {
      SystemChannels.textInput.invokeMethod("TextInput.hide");

      if (_name.text.isEmpty) {
        Fluttertoast.showToast(backgroundColor: ColorPrimary, textColor: Colors.white, msg: "Please Enter User Name");
      } else if (_mobile.text.isEmpty) {
        Fluttertoast.showToast(
            backgroundColor: ColorPrimary, textColor: Colors.white, msg: "Please Enter Mobile Number 10 digits");
      } else if (_address.text.isEmpty) {
        Fluttertoast.showToast(
            backgroundColor: ColorPrimary, textColor: Colors.white, msg: "Please Enter User Address");
      } else if (_pincode.text.isEmpty) {
        Fluttertoast.showToast(backgroundColor: ColorPrimary, textColor: Colors.white, msg: "Please Enter Pincode");
      } else if (_character == -1) {
        Fluttertoast.showToast(
            backgroundColor: ColorPrimary, textColor: Colors.white, msg: "Please Select On Phone Type");
      } else if (_gift == -1) {
        Fluttertoast.showToast(
            backgroundColor: ColorPrimary, textColor: Colors.white, msg: "Please Select gift given or not");
      } else if (_emailaddress.text.isEmpty) {
        final AddIntrestedUserResponse loginData = await ApiProvider().getIntrestedUser(
            areaId, _name.text, _mobile.text, _emailaddress.text, _address.text, _character, _pincode.text, _gift);

        log("ooooo ${loginData}");
        if (loginData.success) {
          userid = loginData.data!.userId;
          _displayDialog(context);
        } else {
          Fluttertoast.showToast(backgroundColor: ColorPrimary, textColor: Colors.white, msg: loginData.message);
        }
      } else {
        final AddIntrestedUserResponse loginData = await ApiProvider().getIntrestedUser(
            areaId, _name.text, _mobile.text, _emailaddress.text, _address.text, _character, _pincode.text, _gift);

        log("ooooo ${loginData}");
        if (loginData.success) {
          userid = loginData.data!.userId;
          _displayDialog(context);
        } else {
          Fluttertoast.showToast(backgroundColor: ColorPrimary, textColor: Colors.white, msg: loginData.message);
        }
      }
    } else {
      Fluttertoast.showToast(
          backgroundColor: ColorPrimary, textColor: Colors.white, msg: "Please turn on the internet");
    }
  }

  @override
  void initState() {
    widget.onTab(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pushAndRemoveUntil(
            context, MaterialPageRoute(builder: (BuildContext context) => BottomNavigation()), (route) => false);
        return Future.value(false);
      },
      child: SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context, MaterialPageRoute(builder: (context) => BottomNavigation()), ModalRoute.withName("/"));
                },
                icon: Icon(Icons.arrow_back_ios),
              ),
              backgroundColor: ColorPrimary,
              title: Text('User Register', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.fromLTRB(16, 14, 16, 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Name *',
                        style:
                            TextStyle(color: Color.fromRGBO(48, 48, 48, 1), fontSize: 15, fontWeight: FontWeight.w600)),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: _name,

                      cursorColor: ColorPrimary,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z ]')),
                      ],
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      //autovalidate: true,
                      maxLength: 25,
                      decoration: InputDecoration(
                        counterText: "",
                        contentPadding: EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                        filled: true,
                        fillColor: Colors.white,
                        hintText: '',
                        hintStyle: TextStyle(color: ColorTextPrimary, fontSize: 14, fontWeight: FontWeight.w600),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: ColorPrimary, width: 2),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text('Mobile *',
                        style:
                            TextStyle(color: Color.fromRGBO(48, 48, 48, 1), fontSize: 15, fontWeight: FontWeight.w600)),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: _mobile,
                      cursorColor: ColorPrimary,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      maxLength: 10,
                      validator: (numb) => Validator.validateMobile(numb!, context),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      autofocus: false,
                      decoration: InputDecoration(
                        counterText: "",
                        contentPadding: EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                        filled: true,
                        fillColor: Colors.white,
                        hintText: '',
                        hintStyle: TextStyle(color: ColorTextPrimary, fontSize: 14, fontWeight: FontWeight.w600),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: ColorPrimary, width: 2),
                        ),
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text('Email Address (Optional)',
                        style:
                            TextStyle(color: Color.fromRGBO(48, 48, 48, 1), fontSize: 15, fontWeight: FontWeight.w600)),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: _emailaddress,
                      cursorColor: ColorPrimary,
                      validator: (numb) => Validator.emailValidator(numb!),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      // inputFormatters: [
                      //   FilteringTextInputFormatter.allow(RegExp(r"[a-z A-Z,.\-]")),
                      // ],
                      //autovalidate: true,
                      maxLength: 25,
                      decoration: InputDecoration(
                        counterText: "",
                        contentPadding: EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                        filled: true,
                        fillColor: Colors.white,
                        hintText: '',
                        hintStyle: TextStyle(color: ColorTextPrimary, fontSize: 14, fontWeight: FontWeight.w600),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: ColorPrimary, width: 2),
                        ),
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text('Address *',
                        style:
                            TextStyle(color: Color.fromRGBO(48, 48, 48, 1), fontSize: 15, fontWeight: FontWeight.w600)),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: _address,
                      cursorColor: ColorPrimary,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      //autovalidate: true,
                      maxLength: 25,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r"[A-Za-z0-9'\.\-\s\,\\\/]")),
                      ],
                      decoration: InputDecoration(
                        counterText: "",
                        contentPadding: EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                        filled: true,
                        fillColor: Colors.white,
                        hintText: '',
                        hintStyle: TextStyle(color: ColorTextPrimary, fontSize: 14, fontWeight: FontWeight.w600),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: ColorPrimary, width: 2),
                        ),
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text('Pincode *',
                        style:
                            TextStyle(color: Color.fromRGBO(48, 48, 48, 1), fontSize: 15, fontWeight: FontWeight.w600)),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: _pincode,
                      cursorColor: ColorPrimary,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      //autovalidate: true,
                      maxLength: 6,
                      decoration: InputDecoration(
                        counterText: "",
                        contentPadding: EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                        filled: true,
                        fillColor: Colors.white,
                        hintText: '',
                        hintStyle: TextStyle(color: ColorTextPrimary, fontSize: 14, fontWeight: FontWeight.w600),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: ColorPrimary, width: 2),
                        ),
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text('Phone Type *',
                        style:
                            TextStyle(color: Color.fromRGBO(48, 48, 48, 1), fontSize: 15, fontWeight: FontWeight.w600)),
                    // Row(
                    //   children: [
                    //     Container(
                    //       width: MediaQuery.of(context).size.width * 0.30,
                    //       child: ListTile(
                    //         contentPadding: EdgeInsets.all(0),
                    //         title: const Text('Smart Phone'),
                    //         leading: Container(
                    //           height: 20,
                    //           width: 20,
                    //           child: Radio<int>(
                    //             value: 1,
                    //             groupValue: _character,
                    //             onChanged: (value) {
                    //               log("===>$_character");
                    //               setState(() {
                    //                 _character = value!;
                    //               });
                    //             },
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //     Container(
                    //       width: MediaQuery.of(context).size.width * 0.40,
                    //       child: ListTile(
                    //         title: const Text('Feature Phone'),
                    //         contentPadding: EdgeInsets.all(0),
                    //         leading: Radio<int>(
                    //           value: 0,
                    //           groupValue: _character,
                    //           onChanged: (value) {
                    //             log("===>$_character");
                    //             setState(() {
                    //               _character = value!;
                    //             });
                    //           },
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                          Radio<int>(
                            activeColor: ColorPrimary,
                            value: 1,
                            groupValue: _character,
                            onChanged: (value) {
                              log("===>$_character");
                              setState(() {
                                _character = value!;
                              });
                            },
                          ),
                          Text(
                            'Smart Phone',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ]),
                        Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                          Radio<int>(
                            activeColor: ColorPrimary,
                            value: 0,
                            groupValue: _character,
                            onChanged: (value) {
                              log("===>$_character");
                              setState(() {
                                _character = value!;
                              });
                            },
                          ),
                          Text(
                            'Feature Phone  ',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          )
                        ]),
                      ],
                    ),
                    SizedBox(height: 20),
                    Text('Gift Given? *',
                        style:
                            TextStyle(color: Color.fromRGBO(48, 48, 48, 1), fontSize: 15, fontWeight: FontWeight.w600)),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                          Radio<int>(
                            activeColor: ColorPrimary,
                            value: 1,
                            groupValue: _gift,
                            onChanged: (value) {
                              log("===>$_gift");
                              setState(() {
                                _gift = value!;
                              });
                            },
                          ),
                          Text(
                            'Yes',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ]),
                        Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                          Radio<int>(
                            activeColor: ColorPrimary,
                            value: 0,
                            groupValue: _gift,
                            onChanged: (value) {
                              log("===>$_gift");
                              setState(() {
                                _gift = value!;
                              });
                            },
                          ),
                          Text(
                            'No',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          )
                        ]),
                        SizedBox()
                      ],
                    ),
                    SizedBox(height: 20),
                    ButtonTheme(
                      // ignore: deprecated_member_use
                      minWidth: MediaQuery.of(context).size.width,
                      child: RaisedButton(
                        padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                        color: ColorPrimary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        onPressed: () {
                          log("kai kai---->");
                          addUser();
                          log(" location: areaId,${areaId}");
                        },
                        child: Text(
                          "REGISTER",
                          style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (contex) => UserNotInterested(
                                        location: areaId,
                                      )));
                        },
                        child: Text(
                          "User Not Interested",
                          style: TextStyle(
                              fontSize: 18,
                              decoration: TextDecoration.underline,
                              color: ColorTextPrimary,
                              fontWeight: FontWeight.w500),
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
      ),
    );
  }

  @override
  onAreaSelect(String id) {
    areaId = id;
  }
}
