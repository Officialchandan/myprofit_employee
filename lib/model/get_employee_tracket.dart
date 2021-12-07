// To parse this JSON data, do
//
//     final GetEmployeTrackerResponse = GetEmployeTrackerResponseFromMap(jsonString);

import 'dart:convert';

class GetEmployeTrackerResponse {
  GetEmployeTrackerResponse({
    required this.success,
    required this.message,
    this.data,
  });

  bool success;
  String message;
  GetEmployeTrackerData? data;

  factory GetEmployeTrackerResponse.fromJson(String str) =>
      GetEmployeTrackerResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetEmployeTrackerResponse.fromMap(Map<String, dynamic> json) =>
      GetEmployeTrackerResponse(
        success: json["success"] == null ? null : json["success"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null
            ? null
            : GetEmployeTrackerData.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "success": success == null ? null : success,
        "message": message == null ? null : message,
        "data": data == null ? null : data!.toMap(),
      };
}

class GetEmployeTrackerData {
  GetEmployeTrackerData({
    required this.registeredCustomer,
    required this.registeredVendors,
    required this.giftGiven,
    required this.notInterestedCustomer,
  });

  String registeredCustomer;
  String registeredVendors;
  String giftGiven;
  String notInterestedCustomer;

  factory GetEmployeTrackerData.fromJson(String str) =>
      GetEmployeTrackerData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetEmployeTrackerData.fromMap(Map<String, dynamic> json) =>
      GetEmployeTrackerData(
        registeredCustomer: json["Registered_customer"] == null
            ? ""
            : json["Registered_customer"].toString(),
        registeredVendors: json["Registered_vendors"] == null
            ? ""
            : json["Registered_vendors"].toString(),
        giftGiven:
            json["Gift_given"] == null ? "" : json["Gift_given"].toString(),
        notInterestedCustomer: json["Not_Interested_customer"] == null
            ? ""
            : json["Not_Interested_customer"].toString(),
      );

  Map<String, dynamic> toMap() => {
        "Registered_customer":
            registeredCustomer == null ? null : registeredCustomer,
        "Registered_vendors":
            registeredVendors == null ? null : registeredVendors,
        "Gift_given": giftGiven == null ? null : giftGiven,
        "Not_Interested_customer":
            notInterestedCustomer == null ? null : notInterestedCustomer,
      };
}
