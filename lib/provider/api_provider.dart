import 'dart:collection';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:myprofit_employee/model/addvendor_form.dart';
import 'package:myprofit_employee/model/categories_respnse.dart';
import 'package:myprofit_employee/model/dhabas_day_response.dart';
import 'package:myprofit_employee/model/dhabas_monthly_response.dart';
import 'package:myprofit_employee/model/dhabas_week_response.dart';
import 'package:myprofit_employee/model/drivers_day_response.dart';
import 'package:myprofit_employee/model/drivers_monthly_response.dart';
import 'package:myprofit_employee/model/drivers_week_response.dart';
import 'package:myprofit_employee/model/getvenordbyid_response.dart';
import 'package:myprofit_employee/model/login_response.dart';
import 'package:myprofit_employee/model/logout_response.dart';
import 'package:myprofit_employee/model/otp_response.dart';
import 'package:myprofit_employee/model/updatevendordetail_response.dart';
import 'package:myprofit_employee/provider/server_error.dart';
import 'package:myprofit_employee/utils/sharedpref.dart';

BaseOptions baseOptions = BaseOptions(
  receiveTimeout: 60000,
  sendTimeout: 60000,
  responseType: ResponseType.json,
  maxRedirects: 3,
);

class ApiProvider {
  var client = http.Client();
  var baseUrl = "http://employee.tekzee.in/api/v1";
  Dio dio = Dio(baseOptions);

  Future<LoginResponse> login(mobile) async {
    log("chl gyi");
    try {
      Response res = await dio.post('$baseUrl/user/genereateOTP',
          //options: Options(
          // headers: {"Authorization": "Bearer ${SharedPref.getString('token')}"},
          //)
          data: {"mobile": mobile});

      return LoginResponse.fromJson(res.toString());
    } catch (error, stacktrace) {
      String message = "";
      if (error is DioError) {
        ServerError e = ServerError.withError(error: error);
        message = e.getErrorMessage();
      } else {
        message = "Something Went wrong";
      }
      print("Exception occurred: $message stackTrace: $stacktrace");
      return LoginResponse(success: false, message: message);
    }
  }

  Future<OtpVerificationResponse> verifyOtp(mobile, otp) async {
    log("chl gyi ${mobile + otp}");
    try {
      Response res = await dio.post('$baseUrl/user/verifyOTP',
          data: {"mobile": mobile, "otp": otp});
      log("chl gyi 2${res}");

      return OtpVerificationResponse.fromJson(res.toString());
    } catch (error, stacktrace) {
      String message = "";
      if (error is DioError) {
        ServerError e = ServerError.withError(error: error);
        message = e.getErrorMessage();
      } else {
        message = "Something Went wrong";
      }
      print("Exception occurred: $message stackTrace: $error");
      return OtpVerificationResponse(success: false, message: message);
    }
  }

  Future<LogOutResponse> logout() async {
    log("chl gyi");
    var token = await SharedPref.getStringPreference('token');
    try {
      Response res = await dio.post('$baseUrl/user/logout',
          options: Options(
            headers: {"Authorization": "Bearer ${token}"},
          ));
      log("sss${res.data}");

      return LogOutResponse.fromJson(res.toString());
    } catch (error, stacktrace) {
      String message = "";
      if (error is DioError) {
        ServerError e = ServerError.withError(error: error);
        message = e.getErrorMessage();
      } else {
        message = "Something Went wrong";
      }
      print("Exception occurred: $message stackTrace: $stacktrace");
      return LogOutResponse(success: false, message: message);
    }
  }

  Future<GetVendorByIdResponse> getVendorId(id) async {
    log("chl gyi");
    var token = await SharedPref.getStringPreference('token');
    try {
      Response res = await dio.post('$baseUrl/getVendorByType',
          data: ({"vendor_type": id}),
          options: Options(
            headers: {"Authorization": "Bearer $token"},
          ));
      log("sss${res.data.toString()}");

      return GetVendorByIdResponse.fromJson(res.toString());
    } catch (error, stacktrace) {
      String message = "";
      if (error is DioError) {
        ServerError e = ServerError.withError(error: error);
        message = e.getErrorMessage();
      } else {
        message = "Something Went wrong";
      }
      print("Exception occurred: $message stackTrace: $stacktrace");
      return GetVendorByIdResponse(success: false, message: message);
    }
  }

  Future<UpdateVendorResponse> updatedetails(
      id, shopname, ownername, mobile, address,
      [cat, subcat]) async {
    log("chl gyi }");
    log("chl gyi $id");
    var token = await SharedPref.getStringPreference('token');
    try {
      log("chl gyi }");
      Response res = await dio.post('$baseUrl/updateVendorForm',
          data: {
            "id": id,
            "shop_name": shopname,
            "owner_name": ownername,
            "owner_mobile": mobile,
            "address": address,
            "sub_cat_id": cat,
            "sub_cat_commission": subcat,
          },
          options: Options(
            headers: {"Authorization": "Bearer ${token}"},
          ));
      log("${res.requestOptions.data}");

      log("chl gyi 2${res}");

      return UpdateVendorResponse.fromJson(res.toString());
    } catch (error, stacktrace) {
      log("chl gyi catkk}");
      String message = "";
      if (error is DioError) {
        ServerError e = ServerError.withError(error: error);
        message = e.getErrorMessage();
      } else {
        message = "Something Went wrong";
      }
      print("Exception occurred: $message stackTrace: $error");
      return UpdateVendorResponse(success: false, message: message);
    }
  }

  Future<AddVendorResponse> addVendor(
      vendor,
      shopname,
      ownername,
      commission,
      ownermobile,
      address,
      landmark,
      city,
      state,
      pin,
       lat,
      lng,
      ownersign,
      subcat,
      subcatcommission) async {
    //log("chl gyi ${mobile + otp}");
    try {
      Map<String, dynamic> addvendor = HashMap<String, dynamic>();
      addvendor["category_type"] = vendor;
      addvendor["shop_name"] = shopname;
      addvendor["owner_name"] = ownername;
      addvendor["vendor_commission"] = commission;
      addvendor["owner_mobile"] = ownermobile;
      addvendor["address"] = address;
      addvendor["landmark"] = landmark;
      addvendor["city"] = city;
      addvendor["state"] = state;
      addvendor["pin"] = pin;
      addvendor["lat"] = lat;
      addvendor["lng"] = lng;
      addvendor["owner_sign"] = await MultipartFile.fromBytes(ownersign,
          filename: DateTime.now().microsecondsSinceEpoch.toString() + ".png");
      addvendor["sub_cat_id"] = subcat;
      addvendor["sub_cat_commission"] = subcatcommission;
      FormData requestData = FormData.fromMap(addvendor);
      var token = await SharedPref.getStringPreference('token');
      Response res = await dio.post('$baseUrl/addVendorForm',
          data: requestData,
          options: Options(
            headers: {"Authorization": "Bearer ${token}"},
          ));
      log("chl gyi 2===========>$res");

      return AddVendorResponse.fromJson(res.toString());
    } catch (error, stacktrace) {
      String message = "";
      if (error is DioError) {
        ServerError e = ServerError.withError(error: error);
        message = e.getErrorMessage();
      } else {
        message = "Something Went wrong";
      }
      print("Exception occurred: $message stackTrace: $error");
      return AddVendorResponse(success: false, message: message);
    }
  }

  Future<DriverDailyResponse> getDailyDrivers() async {
    log("chl gyi 2}");
    print(await SharedPref.getStringPreference('token'));
    var token = await SharedPref.getStringPreference('token');
    try {
      Response res = await dio.get(
        '$baseUrl/performance/driver/daily',
        options: Options(headers: {"Authorization": "Bearer ${token}"}),
      );
      log("d");
      log("${res}");

      return DriverDailyResponse.fromJson(res.toString());
    } catch (error, stacktrace) {
      log("chl gyi 2}");
      String message = "";
      if (error is DioError) {
        ServerError e = ServerError.withError(error: error);
        message = e.getErrorMessage();
      } else {
        message = "Something Went wrong";
      }
      print("Exception occurred: $message stackTrace: $stacktrace");
      return DriverDailyResponse(success: false, message: message);
    }
  }

  Future<DriverWeeklyResponse> getWeeklyDrivers() async {
    log("chl gyi 2}");
    print(await SharedPref.getStringPreference('token'));
    var token = await SharedPref.getStringPreference('token');
    try {
      Response res = await dio.get(
        '$baseUrl/performance/driver/weekly',
        options: Options(headers: {"Authorization": "Bearer ${token}"}),
      );
      log("d");
      log("${res}");

      return DriverWeeklyResponse.fromJson(res.toString());
    } catch (error, stacktrace) {
      log("chl gyi 2}");
      String message = "";
      if (error is DioError) {
        ServerError e = ServerError.withError(error: error);
        message = e.getErrorMessage();
      } else {
        message = "Something Went wrong";
      }
      print("Exception occurred: $message stackTrace: $stacktrace");
      return DriverWeeklyResponse(success: false, message: message);
    }
  }

  Future<DriverMonthlyResponse> getMonthlyDrivers() async {
    log("chl gyi 2}");
    print(await SharedPref.getStringPreference('token'));
    var token = await SharedPref.getStringPreference('token');
    try {
      Response res = await dio.get(
        '$baseUrl/performance/driver/monthly',
        options: Options(headers: {"Authorization": "Bearer ${token}"}),
      );
      log("d");
      log("${res}");

      return DriverMonthlyResponse.fromJson(res.toString());
    } catch (error, stacktrace) {
      log("chl gyi 2}");
      String message = "";
      if (error is DioError) {
        ServerError e = ServerError.withError(error: error);
        message = e.getErrorMessage();
      } else {
        message = "Something Went wrong";
      }
      print("Exception occurred: $message stackTrace: $stacktrace");
      return DriverMonthlyResponse(success: false, message: message);
    }
  }

  Future<DhabasDailyResponse> getDhabasDay() async {
    log("chl gyi 2}");
    print(await SharedPref.getStringPreference('token'));
    var token = await SharedPref.getStringPreference('token');
    try {
      Response res = await dio.get(
        '$baseUrl/performance/dhaba/daily',
        options: Options(headers: {"Authorization": "Bearer ${token}"}),
      );
      log("d");
      log("${res}");

      return DhabasDailyResponse.fromJson(res.toString());
    } catch (error, stacktrace) {
      log("chl gyi 2}");
      String message = "";
      if (error is DioError) {
        ServerError e = ServerError.withError(error: error);
        message = e.getErrorMessage();
      } else {
        message = "Something Went wrong";
      }
      print("Exception occurred: $message stackTrace: $stacktrace");
      return DhabasDailyResponse(success: false, message: message);
    }
  }

  Future<DhabasWeeklyResponse> getDhabasWeek() async {
    log("chl gyi 2}");
    print(await SharedPref.getStringPreference('token'));
    var token = await SharedPref.getStringPreference('token');
    try {
      Response res = await dio.get(
        '$baseUrl/performance/dhaba/weekly',
        options: Options(headers: {"Authorization": "Bearer ${token}"}),
      );
      log("d");
      log("${res}");

      return DhabasWeeklyResponse.fromJson(res.toString());
    } catch (error, stacktrace) {
      log("chl gyi 2}");
      String message = "";
      if (error is DioError) {
        ServerError e = ServerError.withError(error: error);
        message = e.getErrorMessage();
      } else {
        message = "Something Went wrong";
      }
      print("Exception occurred: $message stackTrace: $stacktrace");
      return DhabasWeeklyResponse(success: false, message: message);
    }
  }

  Future<DhabasMonthlyResponse> getDhabasMonthly() async {
    log("chl gyi 2}");
    print(await SharedPref.getStringPreference('token'));
    var token = await SharedPref.getStringPreference('token');
    try {
      Response res = await dio.get(
        '$baseUrl/performance/dhaba/monthly',
        options: Options(headers: {"Authorization": "Bearer ${token}"}),
      );
      log("d");
      log("${res}");

      return DhabasMonthlyResponse.fromJson(res.toString());
    } catch (error, stacktrace) {
      log("chl gyi 2}");
      String message = "";
      if (error is DioError) {
        ServerError e = ServerError.withError(error: error);
        message = e.getErrorMessage();
      } else {
        message = "Something Went wrong";
      }
      print("Exception occurred: $message stackTrace: $stacktrace");
      return DhabasMonthlyResponse(success: false, message: message);
    }
  }

  Future<CategoriesResponse> getCategoriess() async {
    log("chl gyi 2}");
    print(await SharedPref.getStringPreference('token'));
    var token = await SharedPref.getStringPreference('token');
    try {
      Response res = await dio.get(
        '$baseUrl/getCategories',
        options: Options(headers: {"Authorization": "Bearer ${token}"}),
      );
      log("====${res.data}");

      //return fromJson(res.toString());
      return CategoriesResponse.fromJson(res.toString());
    } catch (error, stacktrace) {
      log("chl gyi 2}");
      String message = "";
      if (error is DioError) {
        ServerError e = ServerError.withError(error: error);
        message = e.getErrorMessage();
      } else {
        message = "Something Went wrong";
      }
      print("Exception occurred: $message stackTrace: $stacktrace");
      return CategoriesResponse(success: false, message: message);
    }
  }
}
