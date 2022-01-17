// To parse this JSON data, do
//
//     final notificationList = notificationListFromMap(jsonString);

import 'dart:convert';

class NotificationListResponse {
  NotificationListResponse({
    required this.success,
    required this.message,
    this.data,
  });

  bool success;
  String message;
  List<NotificationListData>? data;

  factory NotificationListResponse.fromJson(String str) =>
      NotificationListResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory NotificationListResponse.fromMap(Map<String, dynamic> json) =>
      NotificationListResponse(
        success: json["success"] == null ? null : json["success"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null
            ? null
            : List<NotificationListData>.from(
                json["data"].map((x) => NotificationListData.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "success": success == null ? null : success,
        "message": message == null ? null : message,
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toMap())),
      };
}

class NotificationListData {
  NotificationListData({
    required this.id,
    required this.name,
  });

  int id;
  String name;

  factory NotificationListData.fromJson(String str) =>
      NotificationListData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory NotificationListData.fromMap(Map<String, dynamic> json) =>
      NotificationListData(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
      };
}
