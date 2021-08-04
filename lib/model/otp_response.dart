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
        data: OtpVerificationResponseData.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "success": success,
        "message": message,
        "data": data?.toMap(),
      };
}

class OtpVerificationResponseData {
  OtpVerificationResponseData({
    required this.vendorId,
    required this.token,
    required this.tokenType,
  });

  int vendorId;
  String token;
  String tokenType;

  factory OtpVerificationResponseData.fromJson(String str) =>
      OtpVerificationResponseData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory OtpVerificationResponseData.fromMap(Map<String, dynamic> json) =>
      OtpVerificationResponseData(
        vendorId: json["vendor_id"],
        token: json["token"],
        tokenType: json["token_type"],
      );

  Map<String, dynamic> toMap() => {
        "vendor_id": vendorId,
        "token": token,
        "token_type": tokenType,
      };
}
