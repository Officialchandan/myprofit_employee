// To parse this JSON data, do
//
//     final otpVerificationResponse = otpVerificationResponseFromMap(jsonString);

import 'dart:convert';

class OtpVerificationResponse {
  OtpVerificationResponse({
    required this.success,
    required this.message,
    this.data,
  });

  bool success;
  String message;
  OtpVerificationResponseData? data;

  factory OtpVerificationResponse.fromJson(String str) =>
      OtpVerificationResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory OtpVerificationResponse.fromMap(Map<String, dynamic> json) =>
      OtpVerificationResponse(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : OtpVerificationResponseData.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "success": success,
        "message": message,
        "data": data?.toMap(),
      };
}

class OtpVerificationResponseData {
  OtpVerificationResponseData({
    required this.emp_id,
    required this.token,
    required this.tokenType,
    required this.firstName,
    required this.lastName,
    required this.profileImage,
    required this.isActive,
    required this.pin,
    required this.city,
    required this.state,
    required this.emp_status,
  });

  int emp_id;
  String firstName;
  String lastName;
  String profileImage;
  String isActive;
  String pin;
  String city;
  String state;

  String token;
  String tokenType;
  int emp_status;

  factory OtpVerificationResponseData.fromJson(String str) =>
      OtpVerificationResponseData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory OtpVerificationResponseData.fromMap(Map<String, dynamic> json) =>
      OtpVerificationResponseData(
        emp_id: json["emp_id"],
        firstName: json["first_name"] == null ? "" : json["first_name"],
        lastName: json["last_name"] == null ? "" : json["last_name"],
        profileImage:
            json["profile_image"] == null ? "" : json["profile_image"],
        isActive: json["is_active"] == null ? "" : json["is_active"].toString(),
        pin: json["pin"] == null ? "" : json["pin"],
        city: json["city"] == null ? "" : json["city"],
        state: json["state"] == null ? "" : json["state"],
        token: json["token"],
        tokenType: json["token_type"],
        emp_status: json["emp_status"] == null ? 0 : json["emp_status"],
      );

  Map<String, dynamic> toMap() => {
        "emp_id": emp_id,
        "first_name": firstName == null ? null : firstName,
        "last_name": lastName == null ? null : lastName,
        "profile_image": profileImage == null ? null : profileImage,
        "is_active": isActive == null ? null : isActive,
        "pin": pin == null ? null : pin,
        "city": city == null ? null : city,
        "state": state == null ? null : state,
        "token": token,
        "token_type": tokenType,
        "emp_status": emp_status == null ? 0 : emp_status,
      };
}
