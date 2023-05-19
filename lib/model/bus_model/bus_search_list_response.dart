// To parse this JSON data, do
//
//     final busSearchListResponse = busSearchListResponseFromJson(jsonString);

import 'dart:convert';

BusSearchListResponse busSearchListResponseFromJson(String str) => BusSearchListResponse.fromJson(json.decode(str));

String busSearchListResponseToJson(BusSearchListResponse data) => json.encode(data.toJson());

class BusSearchListResponse {
  BusSearchResult? busSearchResult;

  BusSearchListResponse({
    this.busSearchResult,
  });

  factory BusSearchListResponse.fromJson(Map<String, dynamic> json) => BusSearchListResponse(
    busSearchResult: BusSearchResult. fromJson(json["BusSearchResult"]),
  );

  Map<String, dynamic> toJson() => {
    "BusSearchResult": busSearchResult!.toJson(),
  };
}

class BusSearchResult {
  int? responseStatus;
  Error? error;
  String? destination;
  String? origin;
  String? traceId;
  List<BusResult>? busResults;

  BusSearchResult({
    this.responseStatus,
    this.error,
    this.destination,
    this.origin,
    this.traceId,
    this.busResults,
  });

  factory BusSearchResult.fromJson(Map<String, dynamic> json) => BusSearchResult(
    responseStatus: json["ResponseStatus"],
    error: Error.fromJson(json["Error"]),
    destination: json["Destination"],
    origin: json["Origin"],
    traceId: json["TraceId"],
    busResults: List<BusResult>.from(json["BusResults"].map((x) => BusResult.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "ResponseStatus": responseStatus,
    "Error": error!.toJson(),
    "Destination": destination,
    "Origin": origin,
    "TraceId": traceId,
    "BusResults": List<dynamic>.from(busResults!.map((x) => x.toJson())),
  };
}

class BusResult {
  int? resultIndex;
  DateTime? arrivalTime;
  int? availableSeats;
  DateTime? departureTime;
  String? routeId;
  String? busType;
  String? serviceName;
  String? travelName;
  bool? idProofRequired;
  bool? isDropPointMandatory;
  bool? liveTrackingAvailable;
  bool? mTicketEnabled;
  int? maxSeatsPerTicket;
  int? operatorId;
  bool? partialCancellationAllowed;
  List<IngPointsDetail>? boardingPointsDetails;
  List<IngPointsDetail>? droppingPointsDetails;
  BusPrice? busPrice;
  List<CancellationPolicy>? cancellationPolicies;

  BusResult({
    this.resultIndex,
    this.arrivalTime,
    this.availableSeats,
    this.departureTime,
    this.routeId,
    this.busType,
    this.serviceName,
    this.travelName,
    this.idProofRequired,
    this.isDropPointMandatory,
    this.liveTrackingAvailable,
    this.mTicketEnabled,
    this.maxSeatsPerTicket,
    this.operatorId,
    this.partialCancellationAllowed,
    this.boardingPointsDetails,
    this.droppingPointsDetails,
    this.busPrice,
    this.cancellationPolicies,
  });

  factory BusResult.fromJson(Map<String, dynamic> json) => BusResult(
    resultIndex: json["ResultIndex"],
    arrivalTime: DateTime.parse(json["ArrivalTime"]),
    availableSeats: json["AvailableSeats"],
    departureTime: DateTime.parse(json["DepartureTime"]),
    routeId: json["RouteId"],
    busType: json["BusType"],
    serviceName: json["ServiceName"],
    travelName: json["TravelName"],
    idProofRequired: json["IdProofRequired"],
    isDropPointMandatory: json["IsDropPointMandatory"],
    liveTrackingAvailable: json["LiveTrackingAvailable"],
    mTicketEnabled: json["MTicketEnabled"],
    maxSeatsPerTicket: json["MaxSeatsPerTicket"],
    operatorId: json["OperatorId"],
    partialCancellationAllowed: json["PartialCancellationAllowed"],
    boardingPointsDetails: List<IngPointsDetail>.from(json["BoardingPointsDetails"].map((x) => IngPointsDetail.fromJson(x))),
    droppingPointsDetails: List<IngPointsDetail>.from(json["DroppingPointsDetails"].map((x) => IngPointsDetail.fromJson(x))),
    busPrice: BusPrice.fromJson(json["BusPrice"]),
    cancellationPolicies: List<CancellationPolicy>.from(json["CancellationPolicies"].map((x) => CancellationPolicy.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "ResultIndex": resultIndex,
    "ArrivalTime": arrivalTime!.toIso8601String(),
    "AvailableSeats": availableSeats,
    "DepartureTime": departureTime!.toIso8601String(),
    "RouteId": routeId,
    "BusType": busType,
    "ServiceName": serviceName,
    "TravelName": travelName,
    "IdProofRequired": idProofRequired,
    "IsDropPointMandatory": isDropPointMandatory,
    "LiveTrackingAvailable": liveTrackingAvailable,
    "MTicketEnabled": mTicketEnabled,
    "MaxSeatsPerTicket": maxSeatsPerTicket,
    "OperatorId": operatorId,
    "PartialCancellationAllowed": partialCancellationAllowed,
    "BoardingPointsDetails": List<dynamic>.from(boardingPointsDetails!.map((x) => x.toJson())),
    "DroppingPointsDetails": List<dynamic>.from(droppingPointsDetails!.map((x) => x.toJson())),
    "BusPrice": busPrice!.toJson(),
    "CancellationPolicies": List<dynamic>.from(cancellationPolicies!.map((x) => x.toJson())),
  };
}

class IngPointsDetail {
  int? cityPointIndex;
  String? cityPointLocation;
  String? cityPointName;
  DateTime? cityPointTime;

  IngPointsDetail({
    this.cityPointIndex,
    this.cityPointLocation,
    this.cityPointName,
    this.cityPointTime,
  });

  factory IngPointsDetail.fromJson(Map<String, dynamic> json) => IngPointsDetail(
    cityPointIndex: json["CityPointIndex"],
    cityPointLocation: json["CityPointLocation"],
    cityPointName: json["CityPointName"],
    cityPointTime: DateTime.parse(json["CityPointTime"]),
  );

  Map<String, dynamic> toJson() => {
    "CityPointIndex": cityPointIndex,
    "CityPointLocation": cityPointLocation,
    "CityPointName": cityPointName,
    "CityPointTime": cityPointTime!.toIso8601String(),
  };
}

class BusPrice {
  String? currencyCode;
  double? basePrice;
  int? tax;
  int? otherCharges;
  int? discount;
  double? publishedPrice;
  int? publishedPriceRoundedOff;
  double? offeredPrice;
  int? offeredPriceRoundedOff;
  double? agentCommission;
  int? agentMarkUp;
  double? tds;
  Gst? gst;

  BusPrice({
    this.currencyCode,
    this.basePrice,
    this.tax,
    this.otherCharges,
    this.discount,
    this.publishedPrice,
    this.publishedPriceRoundedOff,
    this.offeredPrice,
    this.offeredPriceRoundedOff,
    this.agentCommission,
    this.agentMarkUp,
    this.tds,
    this.gst,
  });

  factory BusPrice.fromJson(Map<String, dynamic> json) => BusPrice(
    currencyCode: json["CurrencyCode"],
    basePrice: json["BasePrice"].toDouble(),
    tax: json["Tax"],
    otherCharges: json["OtherCharges"],
    discount: json["Discount"],
    publishedPrice: json["PublishedPrice"].toDouble(),
    publishedPriceRoundedOff: json["PublishedPriceRoundedOff"],
    offeredPrice: json["OfferedPrice"].toDouble(),
    offeredPriceRoundedOff: json["OfferedPriceRoundedOff"],
    agentCommission: json["AgentCommission"],
    agentMarkUp: json["AgentMarkUp"],
    tds: json["TDS"],
    gst: Gst.fromJson(json["GST"]),
  );

  Map<String, dynamic> toJson() => {
    "CurrencyCode": currencyCode,
    "BasePrice": basePrice,
    "Tax": tax,
    "OtherCharges": otherCharges,
    "Discount": discount,
    "PublishedPrice": publishedPrice,
    "PublishedPriceRoundedOff": publishedPriceRoundedOff,
    "OfferedPrice": offeredPrice,
    "OfferedPriceRoundedOff": offeredPriceRoundedOff,
    "AgentCommission": agentCommission,
    "AgentMarkUp": agentMarkUp,
    "TDS": tds,
    "GST": gst!.toJson(),
  };
}

class Gst {
  int? cgstAmount;
  int? cgstRate;
  int? cessAmount;
  int? cessRate;
  int? igstAmount;
  int? igstRate;
  int? sgstAmount;
  int? sgstRate;
  int? taxableAmount;

  Gst({
    this.cgstAmount,
    this.cgstRate,
    this.cessAmount,
    this.cessRate,
    this.igstAmount,
    this.igstRate,
    this.sgstAmount,
    this.sgstRate,
    this.taxableAmount,
  });

  factory Gst.fromJson(Map<String, dynamic> json) => Gst(
    cgstAmount: json["CGSTAmount"],
    cgstRate: json["CGSTRate"],
    cessAmount: json["CessAmount"],
    cessRate: json["CessRate"],
    igstAmount: json["IGSTAmount"],
    igstRate: json["IGSTRate"],
    sgstAmount: json["SGSTAmount"],
    sgstRate: json["SGSTRate"],
    taxableAmount: json["TaxableAmount"],
  );

  Map<String, dynamic> toJson() => {
    "CGSTAmount": cgstAmount,
    "CGSTRate": cgstRate,
    "CessAmount": cessAmount,
    "CessRate": cessRate,
    "IGSTAmount": igstAmount,
    "IGSTRate": igstRate,
    "SGSTAmount": sgstAmount,
    "SGSTRate": sgstRate,
    "TaxableAmount": taxableAmount,
  };
}

class CancellationPolicy {
  int? cancellationCharge;
  int? cancellationChargeType;
  String? policyString;
  TimeBeforeDept? timeBeforeDept;
  DateTime? fromDate;
  DateTime? toDate;

  CancellationPolicy({
    this.cancellationCharge,
    this.cancellationChargeType,
    this.policyString,
    this.timeBeforeDept,
    this.fromDate,
    this.toDate,
  });

  factory CancellationPolicy.fromJson(Map<String, dynamic> json) => CancellationPolicy(
    cancellationCharge: json["CancellationCharge"],
    cancellationChargeType: json["CancellationChargeType"],
    policyString: json["PolicyString"],
    timeBeforeDept: timeBeforeDeptValues.map[json["TimeBeforeDept"]],
    fromDate: DateTime.parse(json["FromDate"]),
    toDate: DateTime.parse(json["ToDate"]),
  );

  Map<String, dynamic> toJson() => {
    "CancellationCharge": cancellationCharge,
    "CancellationChargeType": cancellationChargeType,
    "PolicyString": policyString,
    "TimeBeforeDept": timeBeforeDeptValues.reverse[timeBeforeDept],
    "FromDate": fromDate!.toIso8601String(),
    "ToDate": toDate!.toIso8601String(),
  };
}

enum TimeBeforeDept { THE_291, THE_1729, THE_017 }

final timeBeforeDeptValues = EnumValues({
  "0\u002417": TimeBeforeDept.THE_017,
  "17\u002429": TimeBeforeDept.THE_1729,
  "29\u0024-1": TimeBeforeDept.THE_291
});

class Error {
  int? errorCode;
  String? errorMessage;

  Error({
    this.errorCode,
    this.errorMessage,
  });

  factory Error.fromJson(Map<String, dynamic> json) => Error(
    errorCode: json["ErrorCode"],
    errorMessage: json["ErrorMessage"],
  );

  Map<String, dynamic> toJson() => {
    "ErrorCode": errorCode,
    "ErrorMessage": errorMessage,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
