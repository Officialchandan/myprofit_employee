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
  });

  int emp_id;
  String token;
  String tokenType;

  factory OtpVerificationResponseData.fromJson(String str) =>
      OtpVerificationResponseData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory OtpVerificationResponseData.fromMap(Map<String, dynamic> json) =>
      OtpVerificationResponseData(
        emp_id: json["emp_id"] ,
        token: json["token"],
        tokenType: json["token_type"],
      );

  Map<String, dynamic> toMap() => {
        "emp_id": emp_id,
        "token": token,
        "token_type": tokenType,
      };
}
