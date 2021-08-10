// To parse this JSON data, do
//
//     final updateVendorResponse = updateVendorResponseFromMap(jsonString);

import 'dart:convert';

class UpdateVendorResponse {
  UpdateVendorResponse({
    required this.success,
    required this.message,
  });

  bool success;
  String message;

  factory UpdateVendorResponse.fromJson(String str) =>
      UpdateVendorResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UpdateVendorResponse.fromMap(Map<String, dynamic> json) =>
      UpdateVendorResponse(
        success: json["success"],
        message: json["message"],
      );

  Map<String, dynamic> toMap() => {
        "success": success,
        "message": message,
      };
}
