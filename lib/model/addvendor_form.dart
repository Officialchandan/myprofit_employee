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
    required this.vendorType,
    required this.addedBy,
    required this.shopName,
    required this.ownerName,
    required this.ownerSign,
    required this.address,
    required this.subCatId,
    required this.ownerMobile,
  });

  int vendorId;
  String uniqueId;
  String vendorType;
  int addedBy;
  String shopName;
  String ownerName;
  String ownerSign;
  String address;
  String subCatId;
  String ownerMobile;

  factory AddVendorResponseData.fromJson(String str) =>
      AddVendorResponseData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AddVendorResponseData.fromMap(Map<String, dynamic> json) =>
      AddVendorResponseData(
        vendorId: json["vendor_id"],
        uniqueId: json["unique_id"],
        vendorType: json["vendor_type"],
        addedBy: json["added_by"],
        shopName: json["shop_name"],
        ownerName: json["owner_name"],
        ownerSign: json["owner_sign"],
        address: json["address"],
        subCatId: json["sub_cat_id"],
        ownerMobile: json["owner_mobile"],
      );

  Map<String, dynamic> toMap() => {
        "vendor_id": vendorId,
        "unique_id": uniqueId,
        "vendor_type": vendorType,
        "added_by": addedBy,
        "shop_name": shopName,
        "owner_name": ownerName,
        "owner_sign": ownerSign,
        "address": address,
        "sub_cat_id": subCatId,
        "owner_mobile": ownerMobile,
      };
}
