import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myprofit_employee/model/user_not_intrested.dart';
import 'package:myprofit_employee/provider/api_provider.dart';
import 'package:myprofit_employee/src/ui/bottom_navigation/bottom_navigation.dart';
import 'package:myprofit_employee/src/ui/userregister/user_register_screen.dart';
import 'package:myprofit_employee/utils/colors.dart';
import 'package:myprofit_employee/utils/network.dart';
import 'package:myprofit_employee/utils/validator.dart';

class UserNotInterested extends StatefulWidget {
  final String? location;
  UserNotInterested({Key? key, this.location}) : super(key: key);

  @override
  _UserNotInterestedState createState() => _UserNotInterestedState();
}

class _UserNotInterestedState extends State<UserNotInterested> {
  TextEditingController _name = TextEditingController();

  TextEditingController _address = TextEditingController();
  TextEditingController _reason = TextEditingController();

  addUser() async {
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
      } else {
        final UserNotIntrestedResponse loginData = await ApiProvider()
            .getUnIntrestedUser(
                widget.location, _name.text, _address.text, _reason.text);

        log("ooooo ${loginData}");
        if (loginData.success) {
          Fluttertoast.showToast(
              backgroundColor: ColorPrimary,
              textColor: Colors.white,
              msg: loginData.message);
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => BottomNavigation()),
              (Route<dynamic> route) => false);
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
            backgroundColor: Color.fromRGBO(102, 87, 244, 1),
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
                  Text('Address',
                      style: TextStyle(
                          color: Color.fromRGBO(48, 48, 48, 1),
                          fontSize: 15,
                          fontWeight: FontWeight.w600)),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _address,
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
                  Text('Reason',
                      style: TextStyle(
                          color: Color.fromRGBO(48, 48, 48, 1),
                          fontSize: 15,
                          fontWeight: FontWeight.w600)),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _reason,

                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z ]')),
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
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
