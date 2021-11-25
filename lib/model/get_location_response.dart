// To parse this JSON data, do
//
//     final GetAlotedAreaResponse = GetAlotedAreaResponseFromMap(jsonString);

import 'dart:convert';

class GetAlotedAreaResponse {
  GetAlotedAreaResponse({
    required this.success,
    required this.message,
    this.data,
  });

  bool success;
  String message;
  List<GetAlotedAreaData>? data;

  factory GetAlotedAreaResponse.fromJson(String str) =>
      GetAlotedAreaResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetAlotedAreaResponse.fromMap(Map<String, dynamic> json) =>
      GetAlotedAreaResponse(
        success: json["success"] == null ? null : json["success"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null
            ? null
            : List<GetAlotedAreaData>.from(
                json["data"].map((x) => GetAlotedAreaData.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "success": success == null ? null : success,
        "message": message == null ? null : message,
        "data":
            data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
      };
}

class GetAlotedAreaData {
  GetAlotedAreaData({
    required this.id,
    required this.employeeId,
    required this.locationName,
  });

  int id;
  int employeeId;
  String locationName;

  factory GetAlotedAreaData.fromJson(String str) =>
      GetAlotedAreaData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetAlotedAreaData.fromMap(Map<String, dynamic> json) =>
      GetAlotedAreaData(
        id: json["id"] == null ? null : json["id"],
        employeeId: json["employee_id"] == null ? null : json["employee_id"],
        locationName: json["location_name"] == null
            ? ""
            : json["location_name"].toString(),
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "employee_id": employeeId == null ? null : employeeId,
        "location_name": locationName == null ? null : locationName,
      };
}
