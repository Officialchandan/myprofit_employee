// To parse this JSON data, do
//
//     final driverMonthlyResponse = driverMonthlyResponseFromMap(jsonString);

import 'dart:convert';

class DriverMonthlyResponse {
  DriverMonthlyResponse({
    required this.success,
    required this.message,
    this.data,
  });

  bool success;
  String message;
  DriverMonthlyResponseData? data;

  factory DriverMonthlyResponse.fromJson(String str) =>
      DriverMonthlyResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DriverMonthlyResponse.fromMap(Map<String, dynamic> json) =>
      DriverMonthlyResponse(
        success: json["success"],
        message: json["message"],
        data: DriverMonthlyResponseData.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "success": success,
        "message": message,
        "data": data!.toMap(),
      };
}

class DriverMonthlyResponseData {
  DriverMonthlyResponseData({
    required this.month,
    required this.monthlyDriver,
  });

  String month;
  int monthlyDriver;

  factory DriverMonthlyResponseData.fromJson(String str) =>
      DriverMonthlyResponseData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DriverMonthlyResponseData.fromMap(Map<String, dynamic> json) =>
      DriverMonthlyResponseData(
        month: json["Month"],
        monthlyDriver: json["Monthly_driver"],
      );

  Map<String, dynamic> toMap() => {
        "Month": month,
        "Monthly_driver": monthlyDriver,
      };
}
