// To parse this JSON data, do
//
//     final driverWeeklyResponse = driverWeeklyResponseFromMap(jsonString);

import 'dart:convert';

class DriverWeeklyResponse {
  DriverWeeklyResponse({
    required this.success,
    required this.message,
    this.data,
  });

  bool success;
  String message;
  DriverWeeklyResponseData? data;

  factory DriverWeeklyResponse.fromJson(String str) =>
      DriverWeeklyResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DriverWeeklyResponse.fromMap(Map<String, dynamic> json) =>
      DriverWeeklyResponse(
        success: json["success"],
        message: json["message"],
        data: DriverWeeklyResponseData.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "success": success,
        "message": message,
        "data": data!.toMap(),
      };
}

class DriverWeeklyResponseData {
  DriverWeeklyResponseData({
    required this.startWeek,
    required this.endWeek,
    required this.weeklyDriver,
  });

  String startWeek;
  String endWeek;
  int weeklyDriver;

  factory DriverWeeklyResponseData.fromJson(String str) =>
      DriverWeeklyResponseData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DriverWeeklyResponseData.fromMap(Map<String, dynamic> json) =>
      DriverWeeklyResponseData(
        startWeek: json["Start_Week"] ?? "",
        endWeek: json["End_Week"] ?? "",
        weeklyDriver: json["Weekly_driver"] ?? 0,
      );

  Map<String, dynamic> toMap() => {
        "Start_Week": startWeek,
        "End_Week": endWeek,
        "Weekly_driver": weeklyDriver,
      };
}
