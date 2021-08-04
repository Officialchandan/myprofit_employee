// To parse this JSON data, do
//
//     final dhabasWeeklyResponse = dhabasWeeklyResponseFromMap(jsonString);

import 'dart:convert';

class DhabasWeeklyResponse {
  DhabasWeeklyResponse({
    required this.success,
    required this.message,
    this.data,
  });

  bool success;
  String message;
  DhabasWeeklyResponseData? data;

  factory DhabasWeeklyResponse.fromJson(String str) =>
      DhabasWeeklyResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DhabasWeeklyResponse.fromMap(Map<String, dynamic> json) =>
      DhabasWeeklyResponse(
        success: json["success"],
        message: json["message"],
        data: DhabasWeeklyResponseData.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "success": success,
        "message": message,
        "data": data!.toMap(),
      };
}

class DhabasWeeklyResponseData {
  DhabasWeeklyResponseData({
    required this.startWeek,
    required this.endWeek,
    required this.weeklyVendor,
  });

  String startWeek;
  String endWeek;
  int weeklyVendor;

  factory DhabasWeeklyResponseData.fromJson(String str) =>
      DhabasWeeklyResponseData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DhabasWeeklyResponseData.fromMap(Map<String, dynamic> json) =>
      DhabasWeeklyResponseData(
        startWeek: json["Start_Week"],
        endWeek: json["End_Week"],
        weeklyVendor: json["Weekly_Vendor"],
      );

  Map<String, dynamic> toMap() => {
        "Start_Week": startWeek,
        "End_Week": endWeek,
        "Weekly_Vendor": weeklyVendor,
      };
}
