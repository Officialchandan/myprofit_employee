// To parse this JSON data, do
//
//     final categoriesResponse = categoriesResponseFromMap(jsonString);

import 'dart:convert';

class CategoriesResponse {
  CategoriesResponse({
    required this.success,
    required this.message,
    this.data,
  });

  bool success;
  String message;
  List<CategoriesResponseData>? data;

  factory CategoriesResponse.fromJson(String str) => CategoriesResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CategoriesResponse.fromMap(Map<String, dynamic> json) => CategoriesResponse(
        success: json["success"],
        message: json["message"],
        data: List<CategoriesResponseData>.from(json["data"].map((x) => CategoriesResponseData.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toMap())),
      };
}

class CategoriesResponseData {
  CategoriesResponseData({
    required this.id,
    required this.categoryName,
    required this.categoryImage,
  });

  int id;
  String categoryName;
  String categoryImage;

  factory CategoriesResponseData.fromJson(String str) => CategoriesResponseData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CategoriesResponseData.fromMap(Map<String, dynamic> json) => CategoriesResponseData(
        id: json["id"] == null ? null : json["id"],
        categoryName: json["category_name"] == null ? "" : json["category_name"],
        categoryImage: json["category_image"] == null ? "" : json["category_image"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "category_name": categoryName,
        "category_image": categoryImage,
      };
}
