// To parse this JSON data, do
//
//     final dhabasMonthlyResponse = dhabasMonthlyResponseFromMap(jsonString);

import 'dart:convert';

class DhabasMonthlyResponse {
  DhabasMonthlyResponse({
    required this.success,
    required this.message,
    this.data,
  });

  bool success;
  String message;
  DhabasMonthlyResponseData? data;

  factory DhabasMonthlyResponse.fromJson(String str) =>
      DhabasMonthlyResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DhabasMonthlyResponse.fromMap(Map<String, dynamic> json) =>
      DhabasMonthlyResponse(
        success: json["success"],
        message: json["message"],
        data: DhabasMonthlyResponseData.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "success": success,
        "message": message,
        "data": data!.toMap(),
      };
}

class DhabasMonthlyResponseData {
  DhabasMonthlyResponseData({
    required this.month,
    required this.monthlyVendor,
  });

  String month;
  int monthlyVendor;

  factory DhabasMonthlyResponseData.fromJson(String str) =>
      DhabasMonthlyResponseData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DhabasMonthlyResponseData.fromMap(Map<String, dynamic> json) =>
      DhabasMonthlyResponseData(
        month: json["Month"],
        monthlyVendor: json["Monthly_Vendor"],
      );

  Map<String, dynamic> toMap() => {
        "Month": month,
        "Monthly_Vendor": monthlyVendor,
      };
}
