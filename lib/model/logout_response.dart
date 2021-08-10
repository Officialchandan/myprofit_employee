// To parse this JSON data, do
//
//     final dhabasMonthlyResponse = dhabasMonthlyResponseFromMap(jsonString);

import 'dart:convert';

class LogOutResponse {
  LogOutResponse({
    required this.success,
    required this.message,
  });

  bool success;
  String message;

  factory LogOutResponse.fromJson(String str) =>
      LogOutResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LogOutResponse.fromMap(Map<String, dynamic> json) => LogOutResponse(
        success: json["success"],
        message: json["message"],
      );

  Map<String, dynamic> toMap() => {
        "success": success,
        "message": message,
      };
}
