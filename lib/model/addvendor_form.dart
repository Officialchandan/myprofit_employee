// To parse this JSON data, do
//
//     final addVendorResponse = addVendorResponseFromMap(jsonString);

import 'dart:convert';

class AddVendorResponse {
  AddVendorResponse({
    required this.success,
    required this.message,
    this.data,
  });

  bool success;
  String message;
  AddVendorResponseData? data;

  factory AddVendorResponse.fromJson(String str) =>
      AddVendorResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AddVendorResponse.fromMap(Map<String, dynamic> json) =>
      AddVendorResponse(
        success: json["success"],
        message: json["message"],
        data: AddVendorResponseData.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "success": success,
        "message": message,
        "data": data!.toMap(),
      };
}

class AddVendorResponseData {
  AddVendorResponseData({
    required this.vendorId,
    required this.uniqueId,
    required this.categoryType,
    required this.addedBy,
    required this.shopName,
    required this.shopCommission,
    required this.ownerName,
    required this.ownerSign,
    required this.address,
    this.latitude,
    this.longitude,
    required this.ownerMobile,
  });

  int vendorId;
  String uniqueId;
  String categoryType;
  int addedBy;
  String shopName;
  String shopCommission;
  String ownerName;
  String ownerSign;
  String address;
  dynamic latitude;
  dynamic longitude;
  String ownerMobile;

  factory AddVendorResponseData.fromJson(String str) =>
      AddVendorResponseData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AddVendorResponseData.fromMap(Map<String, dynamic> json) =>
      AddVendorResponseData(
        vendorId: json["vendor_id"],
        uniqueId: json["unique_id"],
        categoryType: json["category_type"],
        addedBy: json["added_by"],
        shopName: json["shop_name"],
        shopCommission: json["shop_commission"],
        ownerName: json["owner_name"],
        ownerSign: json["owner_sign"],
        address: json["address"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        ownerMobile: json["owner_mobile"],
      );

  Map<String, dynamic> toMap() => {
        "vendor_id": vendorId,
        "unique_id": uniqueId,
        "category_type": categoryType,
        "added_by": addedBy,
        "shop_name": shopName,
        "shop_commission": shopCommission,
        "owner_name": ownerName,
        "owner_sign": ownerSign,
        "address": address,
        "latitude": latitude,
        "longitude": longitude,
        "owner_mobile": ownerMobile,
      };
}
