// To parse this JSON data, do
//
//     final addDriverResponse = addDriverResponseFromMap(jsonString);

import 'dart:convert';

class AddDriverResponse {
  AddDriverResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  bool success;
  String message;
  AddDriverResponseData data;

  factory AddDriverResponse.fromJson(String str) =>
      AddDriverResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AddDriverResponse.fromMap(Map<String, dynamic> json) =>
      AddDriverResponse(
        success: json["success"],
        message: json["message"],
        data: AddDriverResponseData.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "success": success,
        "message": message,
        "data": data.toMap(),
      };
}

class AddDriverResponseData {
  AddDriverResponseData({
    required this.driverResponseOnBusinessIdea,
    required this.driverName,
    required this.driverMobile,
    required this.driverPerMealExpenditure,
    required this.driverReferenceMobile,
    required this.addedBy,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  String driverResponseOnBusinessIdea;
  String driverName;
  String driverMobile;
  String driverPerMealExpenditure;
  String driverReferenceMobile;
  int addedBy;
  DateTime updatedAt;
  DateTime createdAt;
  int id;

  factory AddDriverResponseData.fromJson(String str) =>
      AddDriverResponseData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AddDriverResponseData.fromMap(Map<String, dynamic> json) =>
      AddDriverResponseData(
        driverResponseOnBusinessIdea: json["driver_response_on_business_idea"],
        driverName: json["driver_name"],
        driverMobile: json["driver_mobile"],
        driverPerMealExpenditure: json["driver_per_meal_expenditure"],
        driverReferenceMobile: json["driver_reference_mobile"],
        addedBy: json["added_by"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
      );

  Map<String, dynamic> toMap() => {
        "driver_response_on_business_idea": driverResponseOnBusinessIdea,
        "driver_name": driverName,
        "driver_mobile": driverMobile,
        "driver_per_meal_expenditure": driverPerMealExpenditure,
        "driver_reference_mobile": driverReferenceMobile,
        "added_by": addedBy,
        "updated_at": updatedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "id": id,
      };
}
