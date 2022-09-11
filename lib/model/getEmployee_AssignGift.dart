// To parse this JSON data, do
//
//     final getEmployeeAssignGiftResponse = getEmployeeAssignGiftResponseFromMap(jsonString);

import 'dart:convert';

class GetEmployeeAssignGiftResponse {
  GetEmployeeAssignGiftResponse({
    required this.success,
    required this.message,
    this.data,
  });

  bool success;
  String message;
  List<GetEmployeeAssignGiftData>? data;

  factory GetEmployeeAssignGiftResponse.fromJson(String str) => GetEmployeeAssignGiftResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetEmployeeAssignGiftResponse.fromMap(Map<String, dynamic> json) => GetEmployeeAssignGiftResponse(
        success: json["success"] == null ? null : json["success"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null
            ? null
            : List<GetEmployeeAssignGiftData>.from(json["data"].map((x) => GetEmployeeAssignGiftData.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "success": success == null ? null : success,
        "message": message == null ? null : message,
        "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toMap())),
      };
}

class GetEmployeeAssignGiftData {
  GetEmployeeAssignGiftData({
    required this.giftId,
    required this.giftName,
    required this.giftImage,
    required this.barcode,
    required this.totalQty,
    required this.givenQty,
    required this.availableQty,
  });

  int giftId;
  String giftName;
  String giftImage;
  String barcode;
  String totalQty;
  String givenQty;
  String availableQty;

  factory GetEmployeeAssignGiftData.fromJson(String str) => GetEmployeeAssignGiftData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetEmployeeAssignGiftData.fromMap(Map<String, dynamic> json) => GetEmployeeAssignGiftData(
        giftId: json["gift_id"] == null ? 0 : json["gift_id"],
        giftName: json["gift_name"] == null ? "0" : json["gift_name"].toString(),
        giftImage: json["gift_image"] == null ? "0" : json["gift_image"].toString(),
        barcode: json["barcode"] == null ? "0" : json["barcode"].toString(),
        totalQty: json["total_qty"] == null ? "0" : json["total_qty"].toString(),
        givenQty: json["given_qty"] == null ? "0" : json["given_qty"].toString(),
        availableQty: json["available_qty"] == null ? "0" : json["available_qty"].toString(),
      );

  Map<String, dynamic> toMap() => {
        "gift_id": giftId == null ? null : giftId,
        "gift_name": giftName == null ? null : giftName,
        "gift_image": giftImage == null ? null : giftImage,
        "barcode": barcode == null ? null : barcode,
        "total_qty": totalQty == null ? null : totalQty,
        "given_qty": givenQty == null ? null : givenQty,
        "available_qty": availableQty == null ? null : availableQty,
      };
}
