// To parse this JSON data, do
//
//     final dhabasDailyResponse = dhabasDailyResponseFromMap(jsonString);

import 'dart:convert';

class DhabasDailyResponse {
  DhabasDailyResponse({
    required this.success,
    required this.message,
    this.data,
  });

  bool success;
  String message;
  DhabasDailyResponseData? data;

  factory DhabasDailyResponse.fromJson(String str) =>
      DhabasDailyResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DhabasDailyResponse.fromMap(Map<String, dynamic> json) =>
      DhabasDailyResponse(
        success: json["success"],
        message: json["message"],
        data: DhabasDailyResponseData.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "success": success,
        "message": message,
        "data": data!.toMap(),
      };
}

class DhabasDailyResponseData {
  DhabasDailyResponseData({
    required this.today,
    required this.dailyVendor,
  });

  String today;
  int dailyVendor;

  factory DhabasDailyResponseData.fromJson(String str) =>
      DhabasDailyResponseData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DhabasDailyResponseData.fromMap(Map<String, dynamic> json) =>
      DhabasDailyResponseData(
        today: json["Today"],
        dailyVendor: json["Daily_Vendor"],
      );

  Map<String, dynamic> toMap() => {
        "Today": today,
        "Daily_Vendor": dailyVendor,
      };
}
