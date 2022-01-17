// To parse this JSON data, do
//
//     final notificationStatus = notificationStatusFromMap(jsonString);

import 'dart:convert';

class UpdateNotificationStatus {
  UpdateNotificationStatus({
    required this.success,
    required this.message,
  });

  bool success;
  String message;

  factory UpdateNotificationStatus.fromJson(String str) =>
      UpdateNotificationStatus.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UpdateNotificationStatus.fromMap(Map<String, dynamic> json) =>
      UpdateNotificationStatus(
        success: json["success"] == null ? null : json["success"],
        message: json["message"] == null ? null : json["message"],
      );

  Map<String, dynamic> toMap() => {
        "success": success == null ? null : success,
        "message": message == null ? null : message,
      };
}
