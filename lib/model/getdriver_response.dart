// To parse this JSON data, do
//
//     final getDriverListResponse = getDriverListResponseFromMap(jsonString);

import 'dart:convert';

class GetDriverListResponse {
  GetDriverListResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  bool success;
  String message;
  List<GetDriverListResponseData> data;

  factory GetDriverListResponse.fromJson(String str) =>
      GetDriverListResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetDriverListResponse.fromMap(Map<String, dynamic> json) =>
      GetDriverListResponse(
        success: json["success"],
        message: json["message"],
        data: List<GetDriverListResponseData>.from(
            json["data"].map((x) => GetDriverListResponseData.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
      };
}

class GetDriverListResponseData {
  GetDriverListResponseData({
    required this.id,
    required this.addedBy,
    required this.driverName,
    required this.driverMobile,
    required this.driverAddressForGift,
  });

  int id;
  String addedBy;
  String driverName;
  String driverMobile;
  String driverAddressForGift;

  factory GetDriverListResponseData.fromJson(String str) =>
      GetDriverListResponseData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetDriverListResponseData.fromMap(Map<String, dynamic> json) =>
      GetDriverListResponseData(
        id: json["id"],
        addedBy: json["added_by"],
        driverName: json["driver_name"],
        driverMobile: json["driver_mobile"],
        driverAddressForGift: json["driver_address_for_gift"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "added_by": addedBy,
        "driver_name": driverName,
        "driver_mobile": driverMobile,
        "driver_address_for_gift": driverAddressForGift,
      };
}
