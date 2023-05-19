// To parse this JSON data, do
//
//     final busSeatLayoutResponse = busSeatLayoutResponseFromJson(jsonString);

import 'dart:convert';

BusSeatLayoutResponse busSeatLayoutResponseFromJson(String str) => BusSeatLayoutResponse.fromJson(json.decode(str));

String busSeatLayoutResponseToJson(BusSeatLayoutResponse data) => json.encode(data.toJson());

class BusSeatLayoutResponse {
  GetBusSeatLayOutResult? getBusSeatLayOutResult;

  BusSeatLayoutResponse({
    this.getBusSeatLayOutResult,
  });

  factory BusSeatLayoutResponse.fromJson(Map<String, dynamic> json) => BusSeatLayoutResponse(
    getBusSeatLayOutResult: GetBusSeatLayOutResult.fromJson(json["GetBusSeatLayOutResult"]),
  );

  Map<String, dynamic> toJson() => {
    "GetBusSeatLayOutResult": getBusSeatLayOutResult!.toJson(),
  };
}

class GetBusSeatLayOutResult {
  int? responseStatus;
  Error? error;
  String? traceId;
  SeatLayoutDetails? seatLayoutDetails;

  GetBusSeatLayOutResult({
    this.responseStatus,
    this.error,
    this.traceId,
    this.seatLayoutDetails,
  });

  factory GetBusSeatLayOutResult.fromJson(Map<String, dynamic> json) => GetBusSeatLayOutResult(
    responseStatus: json["ResponseStatus"],
    error: Error.fromJson(json["Error"]),
    traceId: json["TraceId"],
    seatLayoutDetails: SeatLayoutDetails.fromJson(json["SeatLayoutDetails"]),
  );

  Map<String, dynamic> toJson() => {
    "ResponseStatus": responseStatus,
    "Error": error!.toJson(),
    "TraceId": traceId,
    "SeatLayoutDetails": seatLayoutDetails!.toJson(),
  };
}

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

class SeatLayoutDetails {
  String? availableSeats;
  String? htmlLayout;
  SeatLayout?  seatLayout;

  SeatLayoutDetails({
    this.availableSeats,
    this.htmlLayout,
    this.seatLayout,
  });

  factory SeatLayoutDetails.fromJson(Map<String, dynamic> json) => SeatLayoutDetails(
    availableSeats: json["AvailableSeats"],
    htmlLayout: json["HTMLLayout"],
    seatLayout: SeatLayout.fromJson(json["SeatLayout"]),
  );

  Map<String, dynamic> toJson() => {
    "AvailableSeats": availableSeats,
    "HTMLLayout": htmlLayout,
    "SeatLayout": seatLayout!.toJson(),
  };
}

class SeatLayout {
  int? noOfColumns;
  int? noOfRows;
  List<List<SeatDetail>>? seatDetails;

  SeatLayout({
    this.noOfColumns,
    this.noOfRows,
    this.seatDetails,
  });

  factory SeatLayout.fromJson(Map<String, dynamic> json) => SeatLayout(
    noOfColumns: json["NoOfColumns"],
    noOfRows: json["NoOfRows"],
    seatDetails: List<List<SeatDetail>>.from(json["SeatDetails"].map((x) => List<SeatDetail>.from(x.map((x) => SeatDetail.fromJson(x))))),
  );

  Map<String, dynamic> toJson() => {
    "NoOfColumns": noOfColumns,
    "NoOfRows": noOfRows,
    "SeatDetails": List<dynamic>.from(seatDetails!.map((x) => List<dynamic>.from(x.map((x) => x.toJson())))),
  };
}

class SeatDetail {
  String? columnNo;
  int? height;
  bool? isLadiesSeat;
  bool? isMalesSeat;
  bool? isUpper;
  String? rowNo;
  double? seatFare;
  int? seatIndex;
  String? seatName;
  bool? seatStatus;
  int? seatType;
  int? width;
  Price? price;

  SeatDetail({
    this.columnNo,
    this.height,
    this.isLadiesSeat,
    this.isMalesSeat,
    this.isUpper,
    this.rowNo,
    this.seatFare,
    this.seatIndex,
    this.seatName,
    this.seatStatus,
    this.seatType,
    this.width,
    this.price,
  });

  factory SeatDetail.fromJson(Map<String, dynamic> json) => SeatDetail(
    columnNo: json["ColumnNo"],
    height: json["Height"],
    isLadiesSeat: json["IsLadiesSeat"],
    isMalesSeat: json["IsMalesSeat"],
    isUpper: json["IsUpper"],
    rowNo: json["RowNo"],
    seatFare: json["SeatFare"].toDouble(),
    seatIndex: json["SeatIndex"],
    seatName: json["SeatName"],
    seatStatus: json["SeatStatus"],
    seatType: json["SeatType"],
    width: json["Width"],
    price: Price.fromJson(json["Price"]),
  );

  Map<String, dynamic> toJson() => {
    "ColumnNo": columnNo,
    "Height": height,
    "IsLadiesSeat": isLadiesSeat,
    "IsMalesSeat": isMalesSeat,
    "IsUpper": isUpper,
    "RowNo": rowNo,
    "SeatFare": seatFare,
    "SeatIndex": seatIndex,
    "SeatName": seatName,
    "SeatStatus": seatStatus,
    "SeatType": seatType,
    "Width": width,
    "Price": price!.toJson(),
  };
}

class Price {
  CurrencyCode? currencyCode;
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

  Price({
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

  factory Price.fromJson(Map<String, dynamic> json) => Price(
    currencyCode: currencyCodeValues.map[json["CurrencyCode"]],
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
    "CurrencyCode": currencyCodeValues.reverse[currencyCode],
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

enum CurrencyCode { INR }

final currencyCodeValues = EnumValues({
  "INR": CurrencyCode.INR
});

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

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
