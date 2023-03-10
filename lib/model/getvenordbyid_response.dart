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

  factory GetVendorByIdResponse.fromJson(String str) => GetVendorByIdResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetVendorByIdResponse.fromMap(Map<String, dynamic> json) => GetVendorByIdResponse(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<GetVendorByIdResponseData>.from(json["data"].map((x) => GetVendorByIdResponseData.fromMap(x))),
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
    required this.categoryType,
    required this.name,
    required this.commission,
    required this.address,
    required this.landmark,
    required this.city,
    required this.state,
    required this.pin,
    required this.lat,
    required this.lng,
    required this.ownerName,
    required this.ownerMobile,
    required this.ownerSign,
    required this.ownerIdProof,
    required this.openingTime,
    required this.closingTime,
    required this.openingDays,
    required this.isActive,
    required this.customField,
    required this.cityName,
    required this.stateName,
    required this.vendorImage,
    required this.subCategory,
  });

  int id;
  int categoryType;
  String name;
  String commission;
  String address;
  String landmark;
  String city;
  String state;
  int pin;
  String lat;
  String lng;
  String ownerName;
  String ownerMobile;
  String ownerSign;
  String ownerIdProof;
  String openingTime;
  String closingTime;
  String openingDays;
  int isActive;
  String customField;
  String cityName;
  String stateName;
  List<VendorImage> vendorImage;

  List<SubCategory> subCategory;

  factory GetVendorByIdResponseData.fromJson(String str) => GetVendorByIdResponseData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetVendorByIdResponseData.fromMap(Map<String, dynamic> json) => GetVendorByIdResponseData(
        id: json["id"],
        categoryType: json["category_type"],
        name: json["name"],
        commission: json["commission"],
        address: json["address"],
        landmark: json["landmark"],
        city: json["city"],
        state: json["state"],
        pin: json["pin"],
        lat: json["lat"] == null ? "" : json["lat"],
        lng: json["lng"] == null ? "" : json["lat"],
        ownerName: json["owner_name"] == null ? "" : json["owner_name"],
        ownerMobile: json["owner_mobile"] == null ? "" : json["owner_mobile"],
        ownerSign: json["owner_sign"],
        ownerIdProof: json["owner_id_proof"] == null ? "" : json["owner_id_proof"].toString(),
        openingTime: json["opening_time"] == null ? "" : json["opening_time"],
        closingTime: json["closing_time"] == null ? "" : json["closing_time"],
        openingDays: json["opening_days"] == null ? "" : json["opening_days"],
        isActive: json["is_active"] == null ? "" : json["is_active"],
        customField: json["custom_field"] == null ? "" : json["custom_field"],
        cityName: json["city_name"],
        stateName: json["state_name"],
        vendorImage: json["vendor_image"] == null
            ? []
            : List<VendorImage>.from(json["vendor_image"].map((x) => VendorImage.fromMap(x))),
        subCategory: List<SubCategory>.from(json["sub_category"].map((x) => SubCategory.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "category_type": categoryType,
        "name": name,
        "commission": commission,
        "address": address,
        "landmark": landmark,
        "city": city,
        "state": state,
        "pin": pin,
        "lat": lat,
        "lng": lng,
        "owner_name": ownerName,
        "owner_mobile": ownerMobile,
        "owner_sign": ownerSign,
        "owner_id_proof": ownerIdProof == null ? null : ownerIdProof,
        "opening_time": openingTime == null ? null : openingTime,
        "closing_time": closingTime == null ? null : closingTime,
        "opening_days": openingDays == null ? null : openingDays,
        "is_active": isActive == null ? null : isActive,
        "custom_field": customField == null ? null : customField,
        "city_name": cityName,
        "state_name": stateName,
        "vendor_image": vendorImage,
        "sub_category": List<dynamic>.from(subCategory.map((x) => x.toMap())),
      };
}

class SubCategory {
  SubCategory({
    required this.catId,
    required this.commission,
    required this.commissionStatus,
  });

  String catId;
  String commission;
  int commissionStatus;

  factory SubCategory.fromJson(String str) => SubCategory.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SubCategory.fromMap(Map<String, dynamic> json) => SubCategory(
        catId: json["cat_id"],
        commission: json["commission"],
        commissionStatus: json["commission_status"],
      );

  Map<String, dynamic> toMap() => {
        "cat_id": catId,
        "commission": commission,
        "commission_status": commissionStatus,
      };
}

class VendorImage {
  VendorImage({
    required this.image,
  });

  String image;

  factory VendorImage.fromJson(String str) => VendorImage.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory VendorImage.fromMap(Map<String, dynamic> json) => VendorImage(
        image: json["image"] == null ? null : json["image"],
      );

  Map<String, dynamic> toMap() => {
        "image": image == null ? null : image,
      };
}
