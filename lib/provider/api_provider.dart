import 'dart:collection';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:employee/main.dart';
import 'package:employee/model/add_chat_papdi.dart';
import 'package:employee/model/add_intrested_user.dart';
import 'package:employee/model/add_vendor_otp.dart';
import 'package:employee/model/addvendor_form.dart';
import 'package:employee/model/area_aloted_otp.dart';
import 'package:employee/model/categories_respnse.dart';
import 'package:employee/model/dhabas_day_response.dart';
import 'package:employee/model/dhabas_monthly_response.dart';
import 'package:employee/model/dhabas_week_response.dart';
import 'package:employee/model/drivers_day_response.dart';
import 'package:employee/model/drivers_monthly_response.dart';
import 'package:employee/model/drivers_week_response.dart';
import 'package:employee/model/get_all_state_response.dart';
import 'package:employee/model/get_employee_tracket.dart';
import 'package:employee/model/get_location_response.dart';
import 'package:employee/model/getcity_by_state_response.dart';
import 'package:employee/model/getvenordbyid_response.dart';
import 'package:employee/model/login_response.dart';
import 'package:employee/model/logout_response.dart';
import 'package:employee/model/otp_response.dart';
import 'package:employee/model/update-notification.dart';
import 'package:employee/model/updatevendordetail_response.dart';
import 'package:employee/model/user_not_intrested.dart';
import 'package:employee/model/validate_app_version.dart';
import 'package:employee/model/vendor_send_notification.dart';
import 'package:employee/provider/server_error.dart';
import 'package:employee/utils/sharedpref.dart';
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';

import '../model/get_state_city_bypincode.dart';

Dio dio = Dio(baseOptions);

BaseOptions baseOptions = BaseOptions(
  receiveTimeout: 60000,
  sendTimeout: 60000,
  responseType: ResponseType.json,
  maxRedirects: 3,
);

class ApiProvider {
  var client = http.Client();
  //var baseUrl = "http://employee.tekzee.in/api/v1";
  var baseUrl = "http://employee.myprofitinc.com/api/v1";

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

  Future<OtpVerificationResponse> verifyOtp(mobile, otp, token) async {
    log("chl gyi ${mobile + otp + token}");
    try {
      Response res = await dio.post('$baseUrl/user/verifyOTP', data: {
        "mobile": mobile,
        "otp": otp,
        "device_token": token,
      });
      log("chl gyi 2$res");

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

  Future<ValidateAppVersionResponse> validateAppVersion() async {
    try {
      PackageInfo _packageInfo = await PackageInfo.fromPlatform();
      Map<String, dynamic> input = {
        "app_name": "employee_app",
        "app_version": "${_packageInfo.version}",
        "device_type": Platform.isAndroid ? "1" : "2"
      };
      Response res = await dio.post('$baseUrl/validateAppVersion', data: input);

      return ValidateAppVersionResponse.fromJson(res.toString());
    } catch (error) {
      String message = "";
      if (error is DioError) {
        ServerError e = ServerError.withError(error: error);
        message = e.getErrorMessage();
      } else {
        message = "Something Went wrong";
      }
      print("Exception occurred: $message stackTrace: $error");
      return ValidateAppVersionResponse(success: false, message: message);
    }
  }

  Future<LogOutResponse> logout() async {
    log("chl gyi");
    var token = await SharedPref.getStringPreference('token');
    try {
      Response res = await dio.post('$baseUrl/user/logout',
          options: Options(
            headers: {"Authorization": "Bearer $token"},
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
    //  try {
    Response res = await dio.post('$baseUrl/getVendorByType',
        data: ({"vendor_type": id}),
        options: Options(
          headers: {"Authorization": "Bearer $token"},
        ));
    log("sss${res.data.toString()}");

    return GetVendorByIdResponse.fromJson(res.toString());
    // } catch (error, stacktrace) {
    //   String message = "";
    //   if (error is DioError) {
    //     ServerError e = ServerError.withError(error: error);
    //     message = e.getErrorMessage();
    //   } else {
    //     message = "Something Went wrong";
    //   }
    //   print("Exception occurred: $message stackTrace: $stacktrace");
    //   return GetVendorByIdResponse(success: false, message: message);
    // }
  }

  Future<GetAllStateCityByPincodeResponse> getStatebypincode(pincode) async {
    log("chl gyi");
    var token = await SharedPref.getStringPreference('token');
    try {
      Response res = await dio.post('$baseUrl/getCityStateByPincode',
          data: ({"pincode": pincode}),
          options: Options(
            headers: {"Authorization": "Bearer $token"},
          ));
      log("sss${res.data.toString()}");

      return GetAllStateCityByPincodeResponse.fromJson(res.toString());
    } catch (error, stacktrace) {
      String message = "";
      if (error is DioError) {
        ServerError e = ServerError.withError(error: error);
        message = e.getErrorMessage();
      } else {
        message = "Something Went wrong";
      }
      print("Exception occurred: $message stackTrace: $stacktrace");
      return GetAllStateCityByPincodeResponse(success: false, message: message);
    }
  }

  Future<GetAllStateResponse> getState(id) async {
    log("chl gyi");
    var token = await SharedPref.getStringPreference('token');
    try {
      Response res = await dio.post('$baseUrl/getAllState',
          data: ({"country_id": id}),
          options: Options(
            headers: {"Authorization": "Bearer $token"},
          ));
      log("sss${res.data.toString()}");

      return GetAllStateResponse.fromJson(res.toString());
    } catch (error, stacktrace) {
      String message = "";
      if (error is DioError) {
        ServerError e = ServerError.withError(error: error);
        message = e.getErrorMessage();
      } else {
        message = "Something Went wrong";
      }
      print("Exception occurred: $message stackTrace: $stacktrace");
      return GetAllStateResponse(success: false, message: message);
    }
  }

  Future<GetAllCityByStateResponse> getCityByState(id) async {
    log("chl gyi");
    var token = await SharedPref.getStringPreference('token');
    try {
      Response res = await dio.post('$baseUrl/getAllCityByStateID',
          data: ({"state_id": id}),
          options: Options(
            headers: {"Authorization": "Bearer $token"},
          ));
      log("sss${res.data.toString()}");

      return GetAllCityByStateResponse.fromJson(res.toString());
    } catch (error, stacktrace) {
      String message = "";
      if (error is DioError) {
        ServerError e = ServerError.withError(error: error);
        message = e.getErrorMessage();
      } else {
        message = "Something Went wrong";
      }
      print("Exception occurred: $message stackTrace: $stacktrace");
      return GetAllCityByStateResponse(success: false, message: message);
    }
  }

  Future<UpdateVendorResponse> updatedetails(id, shopname, ownername, mobile, address, landmark, city, state, pin,
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
            "landmark": landmark,
            "city": city,
            "state": state,
            "pin": pin,
            "sub_cat_id": cat,
            "sub_cat_commission": subcat,
          },
          options: Options(
            headers: {"Authorization": "Bearer $token"},
          ));
      log("${res.requestOptions.data}");

      log("chl gyi 2$res");

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
    accountholdername,
    bankifsc,
    accountnumber,
    gstno,
    List<File> owneridproof,
    subcat,
    subcatcommission,
    opentime,
    closetime,
    List<String> openingdays,
    List<Map<String, String>> customfield,
  ) async {
    //log("chl gyi ${mobile + otp}");
    //  try {
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
    addvendor["owner_sign"] =
        MultipartFile.fromBytes(ownersign, filename: DateTime.now().microsecondsSinceEpoch.toString() + ".png");
    addvendor["acc_holder_name"] = accountholdername;
    addvendor["ifsc"] = bankifsc;
    addvendor["account_no"] = accountnumber;
    addvendor["gst_no"] = gstno;
    log("yha tak to agyy      ====>1");
    //log("${owneridproof.length}");

    List<MultipartFile> ownerIdProof = [];

    await Future.forEach(owneridproof, (File element) async {
      ownerIdProof.add(await MultipartFile.fromFile(element.path,
          filename: DateTime.now().microsecondsSinceEpoch.toString() + ".png"));
      log("===>lengthInBytes${(element.readAsBytesSync().lengthInBytes / 1024) / 1024}");
    });

    addvendor["owner_id_proof[]"] = ownerIdProof;

    addvendor["sub_cat_id"] = subcat;
    addvendor["sub_cat_commission"] = subcatcommission;
    addvendor["opening_time"] = opentime;
    addvendor["closing_time"] = closetime;
    log("yha tak to agyy      ====>${await firebaseMessaging.getToken()}");
    addvendor["device_token"] = await firebaseMessaging.getToken();
    addvendor["custom_field"] = customfield.toString();

    String opendays = "";
    for (int i = 0; i < openingdays.length; i++) {
      opendays += openingdays[i] + ",";
    }
    addvendor["opening_days"] = opendays;

    log("addvendor$addvendor");
    FormData requestData = FormData.fromMap(addvendor);
    var token = await SharedPref.getStringPreference('token');
    Response res = await dio.post('$baseUrl/addVendorForm',
        data: requestData,
        options: Options(
          headers: {"Authorization": "Bearer $token"},
        ));
    log("chl gyi 2===========>$res");

    return AddVendorResponse.fromJson(res.toString());
    // } catch (error, stacktrace) {
    //   String message = "";
    //   if (error is DioError) {
    //     ServerError e = ServerError.withError(error: error);
    //     message = e.getErrorMessage();
    //   } else {
    //     message = "Something Went wrong";
    //   }
    //   print("Exception occurred: $message stackTrace: $error");
    //   return AddVendorResponse(success: false, message: message);
    // }
  }

  Future<ChatPapdiResponse> addChatPapdi(
      category,
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
      accountholdername,
      bankifsc,
      accountnumber,
      gstno,
      List<File> document) async {
    //log("chl gyi ${mobile + otp}");
    // try {
    Map<String, dynamic> addvendor = HashMap<String, dynamic>();
    addvendor["category_type"] = category;
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
    addvendor["owner_sign"] =
        MultipartFile.fromBytes(ownersign, filename: DateTime.now().microsecondsSinceEpoch.toString() + ".png");

    List<MultipartFile> ownerIdProof = [];

    await Future.forEach(document, (File element) async {
      ownerIdProof.add(await MultipartFile.fromFile(element.path,
          filename: DateTime.now().microsecondsSinceEpoch.toString() + ".png"));
      log("===>lengthInBytes${(element.readAsBytesSync().lengthInBytes / 1024) / 1024}");
    });
    addvendor["acc_holder_name"] = accountholdername;
    addvendor["ifsc"] = bankifsc;
    addvendor["account_no"] = accountnumber;
    addvendor["gst_no"] = gstno;
    addvendor["owner_id_proof[]"] = ownerIdProof;

    log("addvendor$addvendor");
    FormData requestData = FormData.fromMap(addvendor);
    var token = await SharedPref.getStringPreference('token');
    Response res = await dio.post('$baseUrl/chatPapdiRegistration',
        data: requestData,
        options: Options(
          headers: {"Authorization": "Bearer $token"},
        ));
    log("chl gyi 2===========>$res");

    return ChatPapdiResponse.fromJson(res.toString());
    // } catch (error, stacktrace) {
    //   String message = "";
    //   if (error is DioError) {
    //     ServerError e = ServerError.withError(error: error);
    //     message = e.getErrorMessage();
    //   } else {
    //     message = "Something Went wrong";
    //   }
    //   print("Exception occurred: $message stackTrace: $error");
    //   return ChatPapdiResponse(success: false, message: message);
    // }
  }

  Future<AddVendorOtpResponse> addVendorVerifyOtp(id, otp) async {
    log("chl gyi ${id + otp}");
    var token = await SharedPref.getStringPreference('token');
    var dtoken = (await firebaseMessaging.getToken())!;
    try {
      Response res = await dio.post('$baseUrl/addVendorForm_verifyOTP',
          data: {"vendor_id": id, "otp": otp, "device_token": dtoken},
          options: Options(
            headers: {"Authorization": "Bearer $token"},
          ));
      log("chl gyi 2$res");

      return AddVendorOtpResponse.fromJson(res.toString());
    } catch (error, stacktrace) {
      String message = "";
      if (error is DioError) {
        ServerError e = ServerError.withError(error: error);
        message = e.getErrorMessage();
      } else {
        message = "Something Went wrong";
      }
      print("Exception occurred: $message stackTrace: $error");
      return AddVendorOtpResponse(success: false, message: message);
    }
  }

  Future<DriverDailyResponse> getDailyDrivers() async {
    log("chl gyi 2}");
    print(await SharedPref.getStringPreference('token'));
    var token = await SharedPref.getStringPreference('token');
    try {
      Response res = await dio.get(
        '$baseUrl/performance/driver/daily',
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );
      log("d");
      log("$res");

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
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );
      log("d");
      log("$res");

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
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );
      log("d");
      log("$res");

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
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );
      log("d");
      log("$res");

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
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );
      log("d");
      log("$res");

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
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );
      log("d");
      log("$res");

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
        options: Options(headers: {"Authorization": "Bearer $token"}),
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

  Future<AddIntrestedUserResponse> getIntrestedUser(locationId, name, mobile, email, address, phone, pincode, gift,
      occupation, income, hometype, familyMembers, marketOfChoice) async {
    log("chl gyi");
    var token = await SharedPref.getStringPreference('token');
    log("parameter ${SharedPref.getStringPreference(SharedPref.VENDORID)}");
    log("parameter $locationId");
    log("parameter $name");
    log("parameter $mobile");
    log("parameter $email");
    log("parameter $address");
    try {
      Response res = await dio.post('$baseUrl/registerInterestedUser',
          data: ({
            "employee_id": await SharedPref.getStringPreference(SharedPref.VENDORID),
            "location_id": locationId,
            "name": name,
            "mobile": mobile,
            "email": email,
            "address": address,
            "is_smartphone": phone,
            "pincode": pincode,
            "is_gift_given": gift,
            "occupation": occupation,
            "income": income,
            "ghar_type": hometype,
            "family_members": familyMembers,
            "market_choice": marketOfChoice
          }),
          options: Options(
            headers: {"Authorization": "Bearer $token"},
          ));
      log("sss${res.data.toString()}");

      return AddIntrestedUserResponse.fromJson(res.toString());
    } catch (error, stacktrace) {
      String message = "";
      if (error is DioError) {
        ServerError e = ServerError.withError(error: error);
        message = e.getErrorMessage();
      } else {
        message = "Something Went wrong";
      }
      print("Exception occurred: $message stackTrace: $stacktrace");
      return AddIntrestedUserResponse(success: false, message: message);
    }
  }

  Future<GetLocationrOtpResponse> getOtpIntrestedUser(
    userId,
    otp,
  ) async {
    log("chl gyi");
    var token = await SharedPref.getStringPreference('token');

    try {
      Response res = await dio.post('$baseUrl/confirmInterestedUserByOTP',
          data: ({"user_id": userId, "otp": otp}),
          options: Options(
            headers: {"Authorization": "Bearer $token"},
          ));
      log("sss${res.data.toString()}");

      return GetLocationrOtpResponse.fromJson(res.toString());
    } catch (error, stacktrace) {
      String message = "";
      if (error is DioError) {
        ServerError e = ServerError.withError(error: error);
        message = e.getErrorMessage();
      } else {
        message = "Something Went wrong";
      }
      print("Exception occurred: $message stackTrace: $stacktrace");
      return GetLocationrOtpResponse(success: false, message: message);
    }
  }

  Future<GetAlotedAreaResponse> getAlotedArea() async {
    log("chl gyi 2}");
    print(await SharedPref.getStringPreference('token'));
    var token = await SharedPref.getStringPreference('token');
    try {
      Response res = await dio.post(
        '$baseUrl/getCampaignLocation',
        data: ({"employee_id": await SharedPref.getStringPreference(SharedPref.VENDORID)}),
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );
      log("====${res.data}");

      //return fromJson(res.toString());
      return GetAlotedAreaResponse.fromJson(res.toString());
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
      return GetAlotedAreaResponse(success: false, message: message);
    }
  }

  Future<UserNotIntrestedResponse> getUnIntrestedUser(locationId, name, address, pincode, reason) async {
    log("chl gyi");
    var token = await SharedPref.getStringPreference('token');
    log("parameter ${await SharedPref.getStringPreference(SharedPref.VENDORID)}");

    log("parameter $name");

    log("parameter $address");
    log("parameter $reason");
    try {
      Response res = await dio.post('$baseUrl/registerNotInterestedUser',
          data: ({
            "employee_id": await SharedPref.getStringPreference(SharedPref.VENDORID),
            "location_id": locationId,
            "name": name,
            "address": address,
            "pincode": pincode,
            "reason": reason,
          }),
          options: Options(
            headers: {"Authorization": "Bearer $token"},
          ));
      log("sss${res.data.toString()}");

      return UserNotIntrestedResponse.fromJson(res.toString());
    } catch (error, stacktrace) {
      String message = "";
      if (error is DioError) {
        ServerError e = ServerError.withError(error: error);
        message = e.getErrorMessage();
      } else {
        message = "Something Went wrong";
      }
      print("Exception occurred: $message stackTrace: $stacktrace");
      return UserNotIntrestedResponse(success: false, message: message);
    }
  }

  Future<GetEmployeTrackerResponse> getEmployeTracker() async {
    log("chl gyi 2}");
    print(await SharedPref.getStringPreference('token'));
    var token = await SharedPref.getStringPreference('token');
    try {
      Response res = await dio.get(
        '$baseUrl/getEmployeeTracker',
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );
      log("d");
      log("$res");

      return GetEmployeTrackerResponse.fromJson(res.toString());
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
      return GetEmployeTrackerResponse(success: false, message: message);
    }
  }

  Future<VendorNotificationResponse> getNotifications(Map input) async {
    // try {
    var token = await SharedPref.getStringPreference('token');
    Response res = await dio.post('$baseUrl/getEmployeeSendNotificatonList',
        data: input, options: Options(headers: {"Authorization": "Bearer $token"}));

    return VendorNotificationResponse.fromJson(res.toString());
    // } catch (error) {
    //   String message = "";
    //   if (error is DioError) {
    //     ServerError e = ServerError.withError(error: error);
    //     message = e.getErrorMessage();
    //   } else {
    //     message = "Please try again later!";
    //   }
    //   print("Exception occurred: $message stackTrace: $error");
    //   return VendorNotificationResponse(success: false, message: message);
    //}
  }

  Future<UpdateNotificationStatus> markAsReadNotification(Map input) async {
    try {
      var token = await SharedPref.getStringPreference('token');
      Response res = await dio.post('$baseUrl/updateSendNotificationStatus',
          data: input, options: Options(headers: {"Authorization": "Bearer $token"}));

      return UpdateNotificationStatus.fromJson(res.toString());
    } catch (error) {
      String message = "";
      if (error is DioError) {
        ServerError e = ServerError.withError(error: error);
        message = e.getErrorMessage();
      } else {
        message = "Please try again later!";
      }
      print("Exception occurred: $message stackTrace: $error");
      return UpdateNotificationStatus(success: false, message: message);
    }
  }
}
