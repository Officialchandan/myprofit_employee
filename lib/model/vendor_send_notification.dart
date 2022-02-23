// To parse this JSON data, do
//
//     final vendorNotificationResponse = vendorNotificationResponseFromMap(jsonString);

import 'dart:convert';

class VendorNotificationResponse {
  VendorNotificationResponse({
    required this.success,
    required this.message,
    this.data,
  });

  bool success;
  String message;
  List<VendorNotificationData>? data;

  factory VendorNotificationResponse.fromJson(String str) => VendorNotificationResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory VendorNotificationResponse.fromMap(Map<String, dynamic> json) => VendorNotificationResponse(
        success: json["success"] == null ? null : json["success"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null
            ? []
            : List<VendorNotificationData>.from(json["data"].map((x) => VendorNotificationData.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "success": success == null ? null : success,
        "message": message == null ? null : message,
        "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toMap())),
      };
}

class VendorNotificationData {
  VendorNotificationData({
    required this.id,
    required this.notiListId,
    required this.name,
    required this.employeeId,
    required this.isRead,
    required this.createdAt,
    //required this.notificationData,
    required this.notificationDataDetails,
  });

  int id;
  int notiListId;
  String name;
  int employeeId;
  int isRead;
  String createdAt;
  //String notificationData;
  NotificationDataDetails? notificationDataDetails;

  factory VendorNotificationData.fromJson(String str) => VendorNotificationData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory VendorNotificationData.fromMap(Map<String, dynamic> json) => VendorNotificationData(
        id: json["id"] == null ? null : json["id"],
        notiListId: json["noti_list_id"] == null ? null : json["noti_list_id"],
        name: json["name"] == null ? null : json["name"],
        employeeId: json["employee_id"] == null ? null : json["employee_id"],
        isRead: json["is_read"] == null ? null : json["is_read"],
        createdAt: json["created_at"] == null ? "" : json["created_at"].toString(),
        //notificationData: json["notification_data"] == null ? null : json["notification_data"],
        notificationDataDetails: json["notification_data_details"] == null
            ? null
            : NotificationDataDetails.fromMap(json["notification_data_details"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "noti_list_id": notiListId == null ? null : notiListId,
        "name": name == null ? null : name,
        "employee_id": employeeId == null ? null : employeeId,
        "is_read": isRead == null ? null : isRead,
        "created_at": createdAt == null ? null : createdAt,
        //"notification_data": notificationData == null ? null : notificationData,
        "notification_data_details": notificationDataDetails == null ? null : notificationDataDetails!.toMap(),
      };
}

class NotificationDataDetails {
  NotificationDataDetails({
    required this.title,
    required this.body,
    this.data,
  });

  String title;
  String body;
  Details? data;

  factory NotificationDataDetails.fromJson(String str) => NotificationDataDetails.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory NotificationDataDetails.fromMap(Map<String, dynamic> json) => NotificationDataDetails(
        title: json["title"] == null ? null : json["title"],
        body: json["body"] == null ? null : json["body"],
        data: json["data"] == null ? null : Details.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "title": title == null ? null : title,
        "body": body == null ? null : body,
        "data": data == null ? null : data!.toMap(),
      };
}

class Details {
  Details({
    //required this.categoryType,
    required this.shopName,
    required this.ownerName,
    required this.vendorCommission,
    required this.ownerMobile,
    required this.address,
    // required this.subCatId,
    // required this.subCatCommission,
    // required this.lat,
    // required this.lng,
    // required this.landmark,
    // required this.city,
    // required this.state,
    // required this.pin,
    //required this.openingTime,
    //required this.closingTime,
    // required this.openingDays,
    // required this.customField,
    required this.deviceToken,
    //required this.ownerSign,
  });

  // String categoryType;
  String shopName;
  String ownerName;
  String vendorCommission;
  String ownerMobile;
  String address;
  //String subCatId;
  //String subCatCommission;
  //String lat;
  //String lng;
  // String landmark;
  //String city;
  //String state;
  // String pin;
  //String openingTime;
  // closingTime;
  //String openingDays;
  //String customField;
  String deviceToken;
  // OwnerSign? ownerSign;

  factory Details.fromJson(String str) => Details.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Details.fromMap(Map<String, dynamic> json) => Details(
        //  categoryType: json["category_type"] == null ? null : json["category_type"],
        shopName: json["shop_name"] == null ? "" : json["shop_name"],
        ownerName: json["owner_name"] == null ? "" : json["owner_name"],
        vendorCommission: json["vendor_commission"] == null ? "" : json["vendor_commission"],
        ownerMobile: json["owner_mobile"] == null ? "" : json["owner_mobile"],
        address: json["address"] == null ? "" : json["address"],
        // subCatId: json["sub_cat_id"] == null ? null : json["sub_cat_id"],
        // subCatCommission: json["sub_cat_commission"] == null ? null : json["sub_cat_commission"],
        // lat: json["lat"] == null ? null : json["lat"],
        // lng: json["lng"] == null ? null : json["lng"],
        // landmark: json["landmark"] == null ? null : json["landmark"],
        // city: json["city"] == null ? null : json["city"],
        // state: json["state"] == null ? null : json["state"],
        // pin: json["pin"] == null ? null : json["pin"],
        // openingTime: json["opening_time"] == null ? null : json["opening_time"],
        // closingTime: json["closing_time"] == null ? null : json["closing_time"],
        // openingDays: json["opening_days"] == null ? null : json["opening_days"],
        //  customField: json["custom_field"] == null ? null : json["custom_field"],
        deviceToken: json["device_token"] == null ? null : json["device_token"],
        // ownerSign: json["owner_sign"] == null ? null : OwnerSign.fromMap(json["owner_sign"]),
      );

  Map<String, dynamic> toMap() => {
        // "category_type": categoryType == null ? null : categoryType,
        "shop_name": shopName == null ? null : shopName,
        "owner_name": ownerName == null ? null : ownerName,
        "vendor_commission": vendorCommission == null ? null : vendorCommission,
        "owner_mobile": ownerMobile == null ? null : ownerMobile,
        "address": address == null ? null : address,
        // "sub_cat_id": subCatId == null ? null : subCatId,
        // "sub_cat_commission": subCatCommission == null ? null : subCatCommission,
        // "lat": lat == null ? null : lat,
        // "lng": lng == null ? null : lng,
        // "landmark": landmark == null ? null : landmark,
        // "city": city == null ? null : city,
        // "state": state == null ? null : state,
        // "pin": pin == null ? null : pin,
        // "opening_time": openingTime == null ? null : openingTime,
        //"closing_time": closingTime == null ? null : closingTime,
        // "opening_days": openingDays == null ? null : openingDays,
        // "custom_field": customField == null ? null : customField,
        "device_token": deviceToken == null ? null : deviceToken,
        // "owner_sign": ownerSign == null ? null : ownerSign!.toMap(),
      };
}

class OwnerSign {
  OwnerSign();

  factory OwnerSign.fromJson(String str) => OwnerSign.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory OwnerSign.fromMap(Map<String, dynamic> json) => OwnerSign();

  Map<String, dynamic> toMap() => {};
}
