// To parse this JSON data, do
//
//     final DriverDailyResponse = DriverDailyResponseFromMap(jsonString);

import 'dart:convert';

class DriverDailyResponse {
  DriverDailyResponse({
    required this.success,
    required this.message,
    this.data,
  });

  bool success;
  String message;
  DriverDailyResponseData? data;

  factory DriverDailyResponse.fromJson(String str) =>
      DriverDailyResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DriverDailyResponse.fromMap(Map<String, dynamic> json) =>
      DriverDailyResponse(
        success: json["success"],
        message: json["message"],
        data: DriverDailyResponseData.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "success": success,
        "message": message,
        "data": data!.toMap(),
      };
}

class DriverDailyResponseData {
  DriverDailyResponseData({
    required this.today,
    required this.dailyDriver,
  });

  String today;
  int dailyDriver;

  factory DriverDailyResponseData.fromJson(String str) =>
      DriverDailyResponseData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DriverDailyResponseData.fromMap(Map<String, dynamic> json) =>
      DriverDailyResponseData(
        today: json["Today"],
        dailyDriver: json["Daily_driver"],
      );

  Map<String, dynamic> toMap() => {
        "Today": today,
        "Daily_driver": dailyDriver,
      };
}
