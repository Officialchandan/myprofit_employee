import 'dart:developer';

import 'package:employee/model/user_not_intrested.dart';
import 'package:employee/provider/api_provider.dart';
import 'package:employee/src/ui/bottom_navigation/bottom_navigation.dart';
import 'package:employee/src/ui/emp_status_one/emp_status.dart';
import 'package:employee/utils/colors.dart';
import 'package:employee/utils/network.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../utils/constant.dart';
import '../../../utils/sharedpref.dart';

class UserNotInterested extends StatefulWidget {
  final String? location;
  UserNotInterested({Key? key, this.location}) : super(key: key);

  @override
  _UserNotInterestedState createState() => _UserNotInterestedState();
}

class _UserNotInterestedState extends State<UserNotInterested> {
  TextEditingController _name = TextEditingController();
  TextEditingController _pincode = TextEditingController();

  TextEditingController _address = TextEditingController();
  TextEditingController _reason = TextEditingController();

  addUser() async {
    Constant.empStatus =
        await SharedPref.getIntegerPreference(SharedPref.EMP_STATUS);
    if (await Network.isConnected()) {
      SystemChannels.textInput.invokeMethod("TextInput.hide");

      if (_name.text.isEmpty) {
        Fluttertoast.showToast(
            backgroundColor: ColorPrimary,
            textColor: Colors.white,
            msg: "Please Enter User Name");
      } else if (_address.text.isEmpty) {
        Fluttertoast.showToast(
            backgroundColor: ColorPrimary,
            textColor: Colors.white,
            msg: "Please Enter User Address");
      } else if (_pincode.text.isEmpty) {
        Fluttertoast.showToast(
            backgroundColor: ColorPrimary,
            textColor: Colors.white,
            msg: "Please Enter Pincode");
      } else {
        final UserNotIntrestedResponse loginData = await ApiProvider()
            .getUnIntrestedUser(widget.location, _name.text, _address.text,
                _pincode.text, _reason.text);

        log("ooooo $loginData");
        if (loginData.success) {
          Fluttertoast.showToast(
              backgroundColor: ColorPrimary,
              textColor: Colors.white,
              msg: loginData.message);

          if (Constant.empStatus == 1) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => EmpStatusOne()),
                (Route<dynamic> route) => false);
          } else {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => BottomNavigation()),
                (Route<dynamic> route) => false);
          }
        } else {
          Fluttertoast.showToast(
              backgroundColor: ColorPrimary,
              textColor: Colors.white,
              msg: loginData.message);
        }
      }
    } else {
      Fluttertoast.showToast(
          backgroundColor: ColorPrimary,
          textColor: Colors.white,
          msg: "Please turn on the internet");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: ColorPrimary,
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                )),
            title: Text('User Register',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.fromLTRB(16, 14, 16, 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Name *',
                      style: TextStyle(
                          color: Color.fromRGBO(48, 48, 48, 1),
                          fontSize: 15,
                          fontWeight: FontWeight.w600)),
                  SizedBox(height: 10),
                  TextFormField(
                    cursorColor: ColorPrimary,
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
                      fillColor: Colors.white,
                      hintText: '',
                      hintStyle: TextStyle(
                          color: ColorTextPrimary,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: ColorPrimary, width: 2),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text('Address *',
                      style: TextStyle(
                          color: Color.fromRGBO(48, 48, 48, 1),
                          fontSize: 15,
                          fontWeight: FontWeight.w600)),
                  SizedBox(height: 10),
                  TextFormField(
                    cursorColor: ColorPrimary,
                    controller: _address,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp(r"[A-Za-z0-9'\.\-\s\,\\\/]")),
                    ],
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    //autovalidate: true,
                    maxLength: 25,
                    decoration: InputDecoration(
                      counterText: "",
                      contentPadding:
                          EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: '',
                      hintStyle: TextStyle(
                          color: ColorTextPrimary,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: ColorPrimary, width: 2),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text('Pincode *',
                      style: TextStyle(
                          color: Color.fromRGBO(48, 48, 48, 1),
                          fontSize: 15,
                          fontWeight: FontWeight.w600)),
                  SizedBox(height: 10),
                  TextFormField(
                    cursorColor: ColorPrimary,
                    controller: _pincode,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    //autovalidate: true,
                    maxLength: 6,
                    decoration: InputDecoration(
                      counterText: "",
                      contentPadding:
                          EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: '',
                      hintStyle: TextStyle(
                          color: ColorTextPrimary,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: ColorPrimary, width: 2),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text('Reason *',
                      style: TextStyle(
                          color: Color.fromRGBO(48, 48, 48, 1),
                          fontSize: 15,
                          fontWeight: FontWeight.w600)),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _reason,
                    cursorColor: ColorPrimary,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp(r"[A-Za-z0-9'\.\-\s\,\\\/]")),
                    ],
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    //autovalidate: true,
                    maxLength: 200,
                    maxLines: 6,
                    minLines: 5,
                    decoration: InputDecoration(
                      counterText: "",
                      contentPadding:
                          EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: '',
                      hintStyle: TextStyle(
                          color: ColorTextPrimary,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: ColorPrimary, width: 2),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  ButtonTheme(
                    minWidth: MediaQuery.of(context).size.width,
                    // ignore: deprecated_member_use
                    child: RaisedButton(
                      padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                      color: ColorPrimary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      onPressed: () {
                        log("kai kai----> ${widget.location}");
                        addUser();
                      },
                      child: Text(
                        "SUBMIT",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
