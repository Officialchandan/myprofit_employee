import 'package:dio/dio.dart';
import 'package:employee/main.dart';
import 'package:employee/src/ui/login/login.dart';
import 'package:employee/utils/colors.dart';
import 'package:employee/utils/sharedpref.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ServerError implements Exception {
  int? _errorCode = 200;
  String _errorMessage = "";

  ServerError.withError({required DioError? error}) {
    _handleError(error!);
  }

  getErrorCode() {
    return _errorCode;
  }

  getErrorMessage() {
    return _errorMessage;
  }

  _handleError(DioError error) async {
    _errorCode = error.response!.statusCode!;
    print(error);
    print(error.message);
    switch (error.type) {
      case DioErrorType.cancel:
        _errorMessage = "Request was cancelled";
        break;
      case DioErrorType.connectTimeout:
        _errorMessage = "Connection timeout";
        break;
      case DioErrorType.other:
        _errorMessage = "Connection failed due to internet connection";
        break;
      case DioErrorType.receiveTimeout:
        _errorMessage = "Receive timeout in connection";
        break;
      case DioErrorType.response:
        _errorMessage = "Received invalid status code: ${error.response!.statusCode}";
        if (error.response!.statusCode == 401) {
          print("come here-->");

          logout();
        }
        if (error.response!.statusCode == 404) {
          print("come here-->");
          Fluttertoast.showToast(
              msg: "Request not found. Please try again after some time.", backgroundColor: ColorPrimary);
        }
        if (error.response!.statusCode == 401) {
          print("come here-->");
          Fluttertoast.showToast(
              msg: "Request not found. Please try again after some time.", backgroundColor: ColorPrimary);
        }
        if (error.response!.statusCode == 202) {
          print("come here-->");

          Fluttertoast.showToast(
              msg: "Network congestion error. Please check your internet connection.", backgroundColor: ColorPrimary);
        }
        if (error.response!.statusCode == 429) {
          print("come here-->");

          Fluttertoast.showToast(
              msg: "Network congestion error.. Please try again after some time.", backgroundColor: ColorPrimary);
        }
        if (error.response!.statusCode == 500) {
          print("come here-->");
          Fluttertoast.showToast(
              msg: "Something went wrong. Please try again after some time.", backgroundColor: ColorPrimary);
        }
        if (error.response!.statusCode == 502) {
          print("come here-->");
          Fluttertoast.showToast(
              msg: "Network congestion error.. Please try again after some time.", backgroundColor: ColorPrimary);
        }
        if (error.response!.statusCode == 503) {
          print("come here-->");
          Fluttertoast.showToast(
              msg: "The server is currently unavailable. Please try again after some time.",
              backgroundColor: ColorPrimary);
        }
        if (error.response!.statusCode == 504) {
          print("come here-->");
          Fluttertoast.showToast(
              msg: "Gateway timeout. Please try again after some time.", backgroundColor: ColorPrimary);
        }
        break;

      case DioErrorType.sendTimeout:
        _errorMessage = "Receive timeout in send request";
        break;
    }
    return _errorMessage;
  }

  void logout() async {
    double devicewidth = 300;

    showDialog(
        barrierDismissible: false,
        context: navigationService.navigatorKey.currentContext!,
        builder: (context) => AlertDialog(
              content: Text("Your session has been expired! Please login again"),
              contentPadding: EdgeInsets.all(15),
              actions: [
                TextButton(
                    onPressed: () async {
                      SharedPref.clearSharedPreference(context);
                      Navigator.pushAndRemoveUntil(
                          context, MaterialPageRoute(builder: (context) => Login()), (route) => false);
                    },
                    child: Text("Ok"))
              ],
            ));

    // EasyLoading.showError("Your session has been expired! Please login again",);
  }
}
