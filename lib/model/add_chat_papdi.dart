// To parse this JSON data, do
//
//     final chatPapdiResponse = chatPapdiResponseFromMap(jsonString);

import 'dart:convert';

class ChatPapdiResponse {
  ChatPapdiResponse({
    required this.success,
    required this.message,
    this.data,
  });

  bool success;
  String message;
  ChatPapdiData? data;

  factory ChatPapdiResponse.fromJson(String str) => ChatPapdiResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ChatPapdiResponse.fromMap(Map<String, dynamic> json) => ChatPapdiResponse(
        success: json["success"] == null ? null : json["success"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null ? null : ChatPapdiData.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "success": success == null ? null : success,
        "message": message == null ? null : message,
        "data": data == null ? null : data!.toMap(),
      };
}

class ChatPapdiData {
  ChatPapdiData({
    required this.vendorId,
    required this.uniqueId,
    required this.categoryType,
    required this.addedBy,
    required this.shopName,
    required this.shopCommission,
    required this.ownerName,
    required this.ownerSign,
    required this.ownerIdProof,
    required this.ownerMobile,
    required this.address,
    required this.landmark,
    required this.city,
    required this.state,
    required this.pin,
    required this.latitude,
    required this.longitude,
  });

  int vendorId;
  String uniqueId;
  String categoryType;
  String addedBy;
  String shopName;
  String shopCommission;
  String ownerName;
  String ownerSign;
  String ownerIdProof;

  String ownerMobile;
  String address;
  String landmark;
  String city;
  String state;
  String pin;
  String latitude;
  String longitude;

  factory ChatPapdiData.fromJson(String str) => ChatPapdiData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ChatPapdiData.fromMap(Map<String, dynamic> json) => ChatPapdiData(
        vendorId: json["vendor_id"] == null ? null : json["vendor_id"],
        uniqueId: json["unique_id"] == null ? "" : json["unique_id"].toString(),
        categoryType: json["category_type"] == null ? "" : json["category_type"].toString(),
        addedBy: json["added_by"] == null ? "" : json["added_by"].toString(),
        shopName: json["shop_name"] == null ? "" : json["shop_name"].toString(),
        shopCommission: json["shop_commission"] == null ? "" : json["shop_commission"].toString(),
        ownerName: json["owner_name"] == null ? "" : json["owner_name"].toString(),
        ownerSign: json["owner_sign"] == null ? "" : json["owner_sign"].toString(),
        ownerIdProof: json["owner_id_proof"] == null ? null : json["owner_id_proof"],
        ownerMobile: json["owner_mobile"] == null ? "" : json["owner_mobile"].toString(),
        address: json["address"] == null ? "" : json["address"].toString(),
        landmark: json["landmark"] == null ? "" : json["landmark"].toString(),
        city: json["city"] == null ? "" : json["city"].toString(),
        state: json["state"] == null ? "" : json["state"].toString(),
        pin: json["pin"] == null ? "" : json["pin"].toString(),
        latitude: json["latitude"] == null ? "" : json["latitude"].toString(),
        longitude: json["longitude"] == null ? "" : json["longitude"].toString(),
      );

  Map<String, dynamic> toMap() => {
        "vendor_id": vendorId == null ? null : vendorId,
        "unique_id": uniqueId == null ? null : uniqueId,
        "category_type": categoryType == null ? null : categoryType,
        "added_by": addedBy == null ? null : addedBy,
        "shop_name": shopName == null ? null : shopName,
        "shop_commission": shopCommission == null ? null : shopCommission,
        "owner_name": ownerName == null ? null : ownerName,
        "owner_sign": ownerSign == null ? null : ownerSign,
        "owner_id_proof": ownerIdProof == null ? null : ownerIdProof,
        "owner_mobile": ownerMobile == null ? null : ownerMobile,
        "address": address == null ? null : address,
        "landmark": landmark == null ? null : landmark,
        "city": city == null ? null : city,
        "state": state == null ? null : state,
        "pin": pin == null ? null : pin,
        "latitude": latitude == null ? null : latitude,
        "longitude": longitude == null ? null : longitude,
      };
}
