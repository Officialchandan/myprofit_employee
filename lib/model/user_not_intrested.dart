// To parse this JSON data, do
//
//     final userNotIntrestedResponse = userNotIntrestedResponseFromMap(jsonString);

import 'dart:convert';

class UserNotIntrestedResponse {
  UserNotIntrestedResponse({
    required this.success,
    required this.message,
    this.data,
  });

  bool success;
  String message;
  UserNotIntrestedData? data;

  factory UserNotIntrestedResponse.fromJson(String str) =>
      UserNotIntrestedResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserNotIntrestedResponse.fromMap(Map<String, dynamic> json) =>
      UserNotIntrestedResponse(
        success: json["success"] == null ? null : json["success"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null
            ? null
            : UserNotIntrestedData.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "success": success == null ? null : success,
        "message": message == null ? null : message,
        "data": data == null ? null : data!.toMap(),
      };
}

class UserNotIntrestedData {
  UserNotIntrestedData({
    required this.employeeId,
    required this.locationId,
    required this.userId,
    required this.reason,
  });

  String employeeId;
  String locationId;
  String userId;
  String reason;

  factory UserNotIntrestedData.fromJson(String str) =>
      UserNotIntrestedData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserNotIntrestedData.fromMap(Map<String, dynamic> json) =>
      UserNotIntrestedData(
        employeeId:
            json["employee_id"] == null ? "" : json["employee_id"].toString(),
        locationId:
            json["location_id"] == null ? "" : json["location_id"].toString(),
        userId: json["user_id"] == null ? "" : json["user_id"].toString(),
        reason: json["reason"] == null ? "" : json["reason"].toString(),
      );

  Map<String, dynamic> toMap() => {
        "employee_id": employeeId == null ? null : employeeId,
        "location_id": locationId == null ? null : locationId,
        "user_id": userId == null ? null : userId,
        "reason": reason == null ? null : reason,
      };
}
