// To parse this JSON data, do
//
//     final addIntrestedUserResponse = addIntrestedUserResponseFromMap(jsonString);

import 'dart:convert';

class AddIntrestedUserResponse {
  AddIntrestedUserResponse({
    required this.success,
    required this.message,
    this.data,
  });

  bool success;
  String message;
  AddIntrestedUserData? data;

  factory AddIntrestedUserResponse.fromJson(String str) =>
      AddIntrestedUserResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AddIntrestedUserResponse.fromMap(Map<String, dynamic> json) =>
      AddIntrestedUserResponse(
        success: json["success"] == null ? null : json["success"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null
            ? null
            : AddIntrestedUserData.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "success": success == null ? null : success,
        "message": message == null ? null : message,
        "data": data == null ? null : data!.toMap(),
      };
}

class AddIntrestedUserData {
  AddIntrestedUserData({
    required this.employeeId,
    required this.userId,
    required this.locationId,
  });

  String employeeId;
  String userId;
  String locationId;

  factory AddIntrestedUserData.fromJson(String str) =>
      AddIntrestedUserData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AddIntrestedUserData.fromMap(Map<String, dynamic> json) =>
      AddIntrestedUserData(
        employeeId:
            json["employee_id"] == null ? "" : json["employee_id"].toString(),
        userId: json["user_id"] == null ? "" : json["user_id"].toString(),
        locationId:
            json["location_id"] == null ? "" : json["location_id"].toString(),
      );

  Map<String, dynamic> toMap() => {
        "employee_id": employeeId == null ? null : employeeId,
        "user_id": userId == null ? null : userId,
        "location_id": locationId == null ? null : locationId,
      };
}
