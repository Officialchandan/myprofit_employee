import 'dart:convert';

class AddVendorOtpResponse {
  AddVendorOtpResponse({
    required this.success,
    required this.message,
  });

  bool success;
  String message;

  factory AddVendorOtpResponse.fromJson(String str) => AddVendorOtpResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AddVendorOtpResponse.fromMap(Map<String, dynamic> json) => AddVendorOtpResponse(
        success: json["success"] == null ? null : json["success"],
        message: json["message"] == null ? "" : json["message"],
      );

  Map<String, dynamic> toMap() => {
        "success": success == null ? null : success,
        "message": message == null ? null : message,
      };
}
