// To parse this JSON data, do
//
//     final getVendorByIdResponse = getVendorByIdResponseFromMap(jsonString);

import 'dart:convert';

class GetVendorByIdResponse {
  GetVendorByIdResponse({
    required this.success,
    required this.message,
    this.data,
  });

  bool success;
  String message;
  List<GetVendorByIdResponseData>? data;

  factory GetVendorByIdResponse.fromJson(String str) =>
      GetVendorByIdResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetVendorByIdResponse.fromMap(Map<String, dynamic> json) =>
      GetVendorByIdResponse(
        success: json["success"],
        message: json["message"],
        data: List<GetVendorByIdResponseData>.from(
            json["data"].map((x) => GetVendorByIdResponseData.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toMap())),
      };
}

class GetVendorByIdResponseData {
  GetVendorByIdResponseData({
    required this.id,
    required this.vendorType,
    required this.subCatId,
    required this.lat,
    required this.lng,
    required this.name,
    required this.address,
    required this.ownerName,
    required this.ownerMobile,
    required this.ownerSign,
  });

  int id;
  int vendorType;
  String subCatId;
  String lat;
  String lng;
  String name;
  String address;
  String ownerName;
  String ownerMobile;
  String ownerSign;

  factory GetVendorByIdResponseData.fromJson(String str) =>
      GetVendorByIdResponseData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetVendorByIdResponseData.fromMap(Map<String, dynamic> json) =>
      GetVendorByIdResponseData(
        id: json["id"],
        vendorType: json["vendor_type"],
        subCatId: json["sub_cat_id"] == null ? "" : json["sub_cat_id"],
        lat: json["lat"] == null ? "" : json["lat"],
        lng: json["lng"] == null ? "" : json["lng"],
        name: json["name"],
        address: json["address"] == null ? "" : json["address"],
        ownerName: json["owner_name"] == null ? "" : json["owner_name"],
        ownerMobile: json["owner_mobile"] == null ? "" : json["owner_mobile"],
        ownerSign: json["owner_sign"] == null ? "" : json["owner_sign"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "vendor_type": vendorType,
        "sub_cat_id": subCatId == null ? null : subCatId,
        "lat": lat == null ? null : lat,
        "lng": lng == null ? null : lng,
        "name": name,
        "address": address == null ? null : address,
        "owner_name": ownerName == null ? null : ownerName,
        "owner_mobile": ownerMobile == null ? null : ownerMobile,
        "owner_sign": ownerSign == null ? null : ownerSign,
      };
}
