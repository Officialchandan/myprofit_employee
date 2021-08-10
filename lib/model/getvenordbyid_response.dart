// To parse this JSON data, do
//
//     final getVendorByIdResponse = getVendorByIdResponseFromMap(jsonString);

import 'dart:convert';

import 'package:flutter/material.dart';

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
        "data":  List<dynamic>.from(data!.map((x) => x.toMap())),
      };
}

class GetVendorByIdResponseData {
  GetVendorByIdResponseData({
    required this.id,
    required this.categoryType,
    required this.name,
    required this.commission,
    required this.address,
    required this.lat,
    required this.lng,
    required this.ownerName,
    required this.ownerMobile,
    required this.ownerSign,
    required this.subCategory,
  });

  int id;
  int categoryType;
  String name;
  String commission;
  String address;
  dynamic lat;
  dynamic lng;
  String ownerName;
  String ownerMobile;
  String ownerSign;
  List<SubCategory> subCategory;

  factory GetVendorByIdResponseData.fromJson(String str) =>
      GetVendorByIdResponseData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetVendorByIdResponseData.fromMap(Map<String, dynamic> json) =>
      GetVendorByIdResponseData(
        id: json["id"],
        categoryType: json["category_type"],
        name: json["name"],
        commission: json["commission"],
        address: json["address"],
        lat: json["lat"],
        lng: json["lng"],
        ownerName: json["owner_name"],
        ownerMobile: json["owner_mobile"],
        ownerSign: json["owner_sign"],
        subCategory: List<SubCategory>.from(json["sub_category"].map((x) => SubCategory.fromMap(x))),
 );

  Map<String, dynamic> toMap() => {
        "id": id,
        "category_type": categoryType,
        "name": name,
        "commission": commission,
        "address": address,
        "lat": lat,
        "lng": lng,
        "owner_name": ownerName,
        "owner_mobile": ownerMobile,
        "owner_sign": ownerSign,
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
TextEditingController subController = TextEditingController();

  factory SubCategory.fromJson(String str) =>
      SubCategory.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SubCategory.fromMap(Map<String, dynamic> json) => SubCategory(
        catId: json["cat_id"],
        commission: json["commission"],
        commissionStatus: json["commission_status"] ,
      );

  Map<String, dynamic> toMap() => {
        "cat_id": catId,
        "commission": commission,
        "commission_status": commissionStatus,
      };
}
