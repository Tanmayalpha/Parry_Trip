// To parse this JSON data, do
//
//     final busCityListResponse = busCityListResponseFromJson(jsonString);

import 'dart:convert';

BusCityListResponse busCityListResponseFromJson(String str) => BusCityListResponse.fromJson(json.decode(str));

String busCityListResponseToJson(BusCityListResponse data) => json.encode(data.toJson());

class BusCityListResponse {
  String? tokenId;
  int? status;
  dynamic error;
  List<BusCity>? busCities;

  BusCityListResponse({
    this.tokenId,
    this.status,
    this.error,
    this.busCities,
  });

  factory BusCityListResponse.fromJson(Map<String, dynamic> json) => BusCityListResponse(
    tokenId: json["TokenId"],
    status: json["Status"],
    error: json["Error"],
    busCities: List<BusCity>.from(json["BusCities"].map((x) => BusCity.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "TokenId": tokenId,
    "Status": status,
    "Error": error,
    "BusCities": List<dynamic>.from(busCities!.map((x) => x.toJson())),
  };
}

class BusCity {
  int? cityId;
  String? cityName;

  BusCity({
    this.cityId,
    this.cityName,
  });

  factory BusCity.fromJson(Map<String, dynamic> json) => BusCity(
    cityId: json["CityId"],
    cityName: json["CityName"],
  );

  Map<String, dynamic> toJson() => {
    "CityId": cityId,
    "CityName": cityName,
  };
}
