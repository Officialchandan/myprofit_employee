// To parse this JSON data, do
//
//     final getAllCityByStateResponse = getAllCityByStateResponseFromMap(jsonString);

import 'dart:convert';

class GetAllCityByStateResponse {
    GetAllCityByStateResponse({
        required this.success,
        required this.message,
        this.data,
    });

    bool success;
    String message;
    List<GetAllCityByStateResponseData>? data;

    factory GetAllCityByStateResponse.fromJson(String str) => GetAllCityByStateResponse.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory GetAllCityByStateResponse.fromMap(Map<String, dynamic> json) => GetAllCityByStateResponse(
        success: json["success"],
        message: json["message"],
        data: List<GetAllCityByStateResponseData>.from(json["data"].map((x) => GetAllCityByStateResponseData.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toMap())),
    };
}

class GetAllCityByStateResponseData {
    GetAllCityByStateResponseData({
        required this.id,
        required this.name,
    });

    int id;
    String name;

    factory GetAllCityByStateResponseData.fromJson(String str) => GetAllCityByStateResponseData.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory GetAllCityByStateResponseData.fromMap(Map<String, dynamic> json) => GetAllCityByStateResponseData(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
    };
}
