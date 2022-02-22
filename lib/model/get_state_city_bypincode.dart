import 'dart:convert';

class GetAllStateCityByPincodeResponse {
  GetAllStateCityByPincodeResponse({
    required this.success,
    required this.message,
    this.data,
  });

  bool success;
  String message;
  List<GetAllStateCityByPincodeData>? data;

  factory GetAllStateCityByPincodeResponse.fromJson(String str) =>
      GetAllStateCityByPincodeResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetAllStateCityByPincodeResponse.fromMap(Map<String, dynamic> json) => GetAllStateCityByPincodeResponse(
        success: json["success"] == null ? null : json["success"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null
            ? []
            : List<GetAllStateCityByPincodeData>.from(json["data"].map((x) => GetAllStateCityByPincodeData.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "success": success == null ? null : success,
        "message": message == null ? null : message,
        "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toMap())),
      };
}

class GetAllStateCityByPincodeData {
  GetAllStateCityByPincodeData({
    required this.cityId,
    required this.cityName,
    required this.stateId,
    required this.stateName,
    required this.countryId,
    required this.countryName,
  });

  int cityId;
  String cityName;
  int stateId;
  String stateName;
  int countryId;
  String countryName;

  factory GetAllStateCityByPincodeData.fromJson(String str) => GetAllStateCityByPincodeData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetAllStateCityByPincodeData.fromMap(Map<String, dynamic> json) => GetAllStateCityByPincodeData(
        cityId: json["city_id"] == null ? "" : json["city_id"],
        cityName: json["city_name"] == null ? "" : json["city_name"],
        stateId: json["state_id"] == null ? "" : json["state_id"],
        stateName: json["state_name"] == null ? "" : json["state_name"],
        countryId: json["country_id"] == null ? "" : json["country_id"],
        countryName: json["country_name"] == null ? "" : json["country_name"],
      );

  Map<String, dynamic> toMap() => {
        "city_id": cityId == null ? null : cityId,
        "city_name": cityName == null ? null : cityName,
        "state_id": stateId == null ? null : stateId,
        "state_name": stateName == null ? null : stateName,
        "country_id": countryId == null ? null : countryId,
        "country_name": countryName == null ? null : countryName,
      };
}
