import 'dart:async';
import 'dart:developer';

import 'package:employee/main.dart';
import 'package:employee/model/otp_response.dart';
import 'package:employee/provider/api_provider.dart';
import 'package:employee/src/ui/bottom_navigation/bottom_navigation.dart';
import 'package:employee/src/ui/emp_status_one/emp_status.dart';
import 'package:employee/utils/colors.dart';
import 'package:employee/utils/network.dart';
import 'package:employee/utils/sharedpref.dart';
import 'package:employee/utils/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/constant.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  FocusNode focusNode = new FocusNode();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  bool _passwordVisible = true;
  bool _tap = true;
  String token = "";
  void _toggle() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }

  var email;
  //var status = SharedPref.getStringPreference(SharedPref.USERSTATUS);

  String? validateEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return "Email is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Invalid Email";
    } else {
      return null;
    }
  }

  TextEditingController _textFieldController = TextEditingController();
  onTouchKeyBoard() {
    return GestureDetector(onTap: () {
      FocusScopeNode currentFocus = FocusScope.of(context);

      if (!currentFocus.hasPrimaryFocus) {
        currentFocus.unfocus();
      }
    });
  }

  Timer? countdownTimer;
  Duration myDuration = Duration(seconds: 60);
  bool resentOtpCheck = false;

  void startTimer() {
    print("startTimet-->");
    countdownTimer =
        Timer.periodic(Duration(seconds: 1), (_) => setCountDown());
    print("countdownTimer-->$countdownTimer.");
  }

  void setCountDown() {
    final reduceSecondsBy = 1;
    final seconds = myDuration.inSeconds - reduceSecondsBy;
    if (seconds < 0) {
      countdownTimer!.cancel();
    } else {
      myDuration = Duration(seconds: seconds);
      String strDigits(int n) => n.toString().padLeft(2, '0');
      Constant.seconds.value = strDigits(myDuration.inSeconds.remainder(60));
      // print("myDuration__${Constant.seconds.value}");
    }
    ifMounted();
  }

  ifMounted() {
    if (!mounted) {
      setState(() {});
    }
  }

  _displayDialog(BuildContext context, mobile) async {
    return showDialog(
        context: context,
        builder: (context) {
          return WillPopScope(
            onWillPop: () {
              if (Constant.seconds.value != '00') {
                return Future.value(false);
              } else {
                return Future.value(true);
              }
            },
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 400),
              child: AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                title: RichText(
                  text: TextSpan(
                    text: "OTP Verification\n",
                    style: GoogleFonts.openSans(
                      fontSize: 25.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                    children: [
                      TextSpan(
                        text: "Please verify your OTP on $mobile",
                        style: GoogleFonts.openSans(
                          fontSize: 14.0,
                          color: ColorTextPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ],
                  ),
                ),
                content: TextField(
                  controller: _textFieldController,
                  cursorColor: ColorPrimary,
                  keyboardType: TextInputType.number,
                  maxLength: 4,
                  //inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(
                    filled: true,
                    counterText: "",
                    // fillColor: Colors.black,
                    hintText: "Enter OTP",
                    hintStyle: GoogleFonts.openSans(
                      fontWeight: FontWeight.w600,
                    ),
                    contentPadding: const EdgeInsets.only(
                        left: 14.0, bottom: 8.0, top: 8.0),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                actions: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MaterialButton(
                        minWidth: MediaQuery.of(context).size.width * 0.65,
                        height: 50,
                        padding: const EdgeInsets.all(8.0),
                        textColor: Colors.white,
                        color: ColorPrimary,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        onPressed: () {
                          loginApiCall(
                              mobileController.text, _textFieldController.text);
                        },
                        child: new Text(
                          "Verify",
                          style: GoogleFonts.openSans(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              decoration: TextDecoration.none),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: Size(50, 30),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            alignment: Alignment.center),
                        onPressed: () {
                          if (Constant.seconds.value == '00') {
                            resentOtpCheck = true;
                            loginApiOtpCall(mobile);
                            setState(() {});
                          }
                        },
                        child: ValueListenableBuilder(
                          valueListenable: Constant.seconds,
                          builder: (BuildContext context, String value, _) {
                            return Text(
                                value == '00'
                                    ? "Resend OTP"
                                    : "Resend OTP after $value seconds",
                                style: TextStyle(
                                    color: value == '00'
                                        ? ColorPrimary
                                        : Colors.grey.shade400,
                                    fontSize: 16));
                          },
                        ),
                      ),
                    ],
                  ),
                  // Container(
                  //   height: 20,
                  //   width: MediaQuery.of(context).size.width * 0.95,
                  //   color: Colors.transparent,
                  // )
                ],
              ),
            ),
          );
        });
  }

  loginApiOtpCall(mobile) async {
    if (await Network.isConnected()) {
      SystemChannels.textInput.invokeMethod("TextInput.hide");
      print("kai kroge +");
      if (mobileController.text.isEmpty) {
        Fluttertoast.showToast(
            backgroundColor: ColorPrimary,
            textColor: Colors.white,
            msg: "Please enter Mobile Number");
      } else {
        token = (await firebaseMessaging.getToken())!;
        log("token====$token");
        final loginData = await ApiProvider().login(mobile);
        // SharedPref.setStringPrefe  rence(SharedPref.USERSTATUS, loginData.status);
        print("kai kroge +${loginData.message}");

        if (loginData.success == true) {
          if (Constant.seconds.value == '00') {
            if (countdownTimer != null) {
              countdownTimer!.cancel();
              myDuration = const Duration(seconds: 60);
            }
            startTimer();
          }
          if (!resentOtpCheck) {
            _displayDialog(context, mobileController.text);
          }
        } else {
          Fluttertoast.showToast(
            backgroundColor: ColorPrimary,
            textColor: Colors.white,
            msg: loginData.success == false
                ? loginData.message
                : "Thanks for Login",

            // timeInSecForIos: 3
          );
        }
      }
    } else {
      Fluttertoast.showToast(
          backgroundColor: ColorPrimary,
          textColor: Colors.white,
          msg: "Please turn on  internet");
    }
    _tap = true;
  }

  loginApiCall(mobile, otp) async {
    if (await Network.isConnected()) {
      SystemChannels.textInput.invokeMethod("TextInput.hide");

      if (_textFieldController.text.isEmpty) {
        Fluttertoast.showToast(
            backgroundColor: ColorPrimary,
            textColor: Colors.white,
            msg: "Please Enter OTP");
      } else {
        final OtpVerificationResponse loginData =
            await ApiProvider().verifyOtp(mobile, otp, token);
        log("ooooo $loginData");
        if (loginData.success == true) {
          SharedPref.setBooleanPreference(SharedPref.LOGIN, true);
          SharedPref.setStringPreference(
              SharedPref.TOKEN, loginData.data!.token);
          SharedPref.setStringPreference(
              SharedPref.VENDORID, loginData.data!.emp_id.toString());
          SharedPref.setStringPreference(
              SharedPref.NAME,
              (loginData.data!.firstName + " " + loginData.data!.lastName)
                  .toString());
          SharedPref.setStringPreference(SharedPref.MOBILE, mobile.toString());

          SharedPref.setIntegerPreference(
              SharedPref.EMP_STATUS, loginData.data!.emp_status);
          print(await SharedPref.getBooleanPreference(SharedPref.LOGIN));

          // pref.setBool("login", true);
          // pref.setString("token", loginData.token);
          // pref.setBool("sucees", loginData.success);

          int empStatus =
              await SharedPref.getIntegerPreference(SharedPref.EMP_STATUS);

          if (empStatus == 1) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => EmpStatusOne()),
                (Route<dynamic> route) => false);
          } else {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => BottomNavigation()),
                (Route<dynamic> route) => false);
            print((SharedPref.getStringPreference("token")));
          }
        } else {
          Fluttertoast.showToast(
            backgroundColor: ColorPrimary,
            textColor: Colors.white,
            msg: loginData.success == false
                ? "OTP is incorrect"
                : "thanks for login ",
            // timeInSecForIos: 3
          );
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
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    Widget mobileNumber = TextFormField(
      keyboardType: TextInputType.number,
      validator: (numb) => Validator.validateMobile(numb!, context),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      maxLength: 10,
      cursorColor: ColorPrimary,
      controller: mobileController,
      decoration: InputDecoration(
        counterText: "",
        focusedBorder: UnderlineInputBorder(
          borderSide: const BorderSide(color: ColorPrimary, width: 2),
        ),
        hintText: "Please Enter Mobile Number",
        prefixIcon: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "   +91",
              style: TextStyle(color: ColorPrimary),
            ),
            Container(
              height: 25,
              width: 1.5,
              margin: EdgeInsets.all(10),
              color: ColorTextPrimary,
            )
          ],
        ),
        prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
        // errorText: Validator.validateMobile(edtMobile.text, context),
      ),
    );
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Stack(
            children: [
              Container(
                  height: deviceHeight,
                  //width: 400,
                  child: Image.asset(
                    "images/bg.png",
                    height: deviceHeight,
                    width: double.infinity,
                    fit: BoxFit.fill,
                  )),
              Positioned(
                left: 20,
                right: 20,
                top: deviceHeight * 0.30,
                child: Container(
                  width: 500,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Login",
                          style: GoogleFonts.openSans(
                              fontSize: 28,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              decoration: TextDecoration.none),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "Add your details to login",
                          style: GoogleFonts.openSans(
                              fontSize: 17,
                              color: ColorTextPrimary,
                              fontWeight: FontWeight.w600,
                              decoration: TextDecoration.none),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        mobileNumber,
                        SizedBox(
                          height: 80,
                        ),
                        Center(
                          child: Column(
                              // mainAxisAlignment: MainAxisAlignment.center,
                              // crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                MaterialButton(
                                  minWidth: deviceWidth * 0.60,
                                  height: 50,
                                  padding: const EdgeInsets.all(8.0),
                                  textColor: Colors.white,
                                  color: ColorPrimary,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  onPressed: () {
                                    _textFieldController.clear();
                                    if (_tap == true) {
                                      _tap = false;
                                      resentOtpCheck = false;
                                      loginApiOtpCall(mobileController.text);
                                    }
                                  },
                                  child: new Text(
                                    "Login",
                                    style: GoogleFonts.openSans(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w600,
                                        decoration: TextDecoration.none),
                                  ),
                                ),
                              ]),
                        ),
                      ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
