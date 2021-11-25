// To parse this JSON data, do
//
//     final GetLocationrOtpResponse = GetLocationrOtpResponseFromMap(jsonString);

import 'dart:convert';

class GetLocationrOtpResponse {
  GetLocationrOtpResponse({
    required this.success,
    required this.message,
  });

  bool success;
  String message;

  factory GetLocationrOtpResponse.fromJson(String str) =>
      GetLocationrOtpResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetLocationrOtpResponse.fromMap(Map<String, dynamic> json) =>
      GetLocationrOtpResponse(
        success: json["success"] == null ? null : json["success"],
        message: json["message"] == null ? null : json["message"],
      );

  Map<String, dynamic> toMap() => {
        "success": success == null ? null : success,
        "message": message == null ? null : message,
      };
}
