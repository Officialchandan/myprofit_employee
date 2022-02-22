// To parse this JSON data, do
//
//     final getAllStateResponse = getAllStateResponseFromMap(jsonString);

import 'dart:convert';

class GetAllStateResponse {
  GetAllStateResponse({
    required this.success,
    required this.message,
    this.data,
  });

  bool success;
  String message;
  List<GetAllStateResponseData>? data;

  factory GetAllStateResponse.fromJson(String str) => GetAllStateResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetAllStateResponse.fromMap(Map<String, dynamic> json) => GetAllStateResponse(
        success: json["success"],
        message: json["message"],
        data: List<GetAllStateResponseData>.from(json["data"].map((x) => GetAllStateResponseData.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toMap())),
      };
}

class GetAllStateResponseData {
  GetAllStateResponseData({
    required this.id,
    required this.statename,
  });

  int id;
  String statename;

  factory GetAllStateResponseData.fromJson(String str) => GetAllStateResponseData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetAllStateResponseData.fromMap(Map<String, dynamic> json) => GetAllStateResponseData(
        id: json["id"],
        statename: json["state_name"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "state_name": statename,
      };
}
