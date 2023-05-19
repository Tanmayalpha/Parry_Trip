class SeatModel {
  String? availableSeats;
  SeatLayout? seatLayout;

  SeatModel({this.availableSeats, this.seatLayout});

  SeatModel.fromJson(Map<String, dynamic> json) {
    availableSeats = json['AvailableSeats'];
    seatLayout = json['SeatLayout'] != null
        ? new SeatLayout.fromJson(json['SeatLayout'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['AvailableSeats'] = this.availableSeats;
    if (this.seatLayout != null) {
      data['SeatLayout'] = this.seatLayout!.toJson();
    }
    return data;
  }
}

class SeatLayout {
  int? noOfColumns;
  int? noOfRows;
  List<List<SeatInfoModel>>? upperDetails;
  List<List<SeatInfoModel>>? lowerDetails;
  SeatLayout(
      {this.noOfColumns, this.noOfRows, this.upperDetails, this.lowerDetails});

  SeatLayout.fromJson(Map<String, dynamic> json) {
    noOfColumns = json['NoOfColumns'];
    noOfRows = json['NoOfRows'];
    if (json['SeatDetails'] != null) {
      upperDetails = [];
      lowerDetails = [];
      json['SeatDetails'].forEach((v) {
        List<SeatInfoModel> upperList = <SeatInfoModel>[];
        List<SeatInfoModel> lowerList = <SeatInfoModel>[];
        if (v.isNotEmpty && v[0]['IsUpper']) {
          v.forEach((element) {
            upperList.add(SeatInfoModel.fromJson(element));
          });
          upperDetails!.add(upperList.toList());
        } else {
          v.forEach((element) {
            lowerList.add(SeatInfoModel.fromJson(element));
          });
          lowerDetails!.add(lowerList.toList());
        }
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['NoOfColumns'] = this.noOfColumns;
    data['NoOfRows'] = this.noOfRows;
    if (this.lowerDetails != null) {
      data['SeatDetails'] = this.lowerDetails!.map((v) => v).toList();
    }
    return data;
  }
}

class SeatInfoModel {
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
  bool? selected;
  SeatInfoModel(
      {this.columnNo,
      this.height,
      this.isLadiesSeat,
      this.isMalesSeat,
      this.isUpper,
      this.selected,
      this.rowNo,
      this.seatFare,
      this.seatIndex,
      this.seatName,
      this.seatStatus,
      this.seatType,
      this.width,
      this.price});

  SeatInfoModel.fromJson(Map<String, dynamic> json) {
    columnNo = json['ColumnNo'];
    height = json['Height'];
    isLadiesSeat = json['IsLadiesSeat'];
    isMalesSeat = json['IsMalesSeat'];
    isUpper = json['IsUpper'];
    rowNo = json['RowNo'];
    selected = false;
    seatFare = json['SeatFare'];
    seatIndex = json['SeatIndex'];
    seatName = json['SeatName'];
    seatStatus = json['SeatStatus'];
    seatType = json['SeatType'];
    width = json['Width'];
    price = json['Price'] != null ? new Price.fromJson(json['Price']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ColumnNo'] = this.columnNo;
    data['Height'] = this.height;
    data['IsLadiesSeat'] = this.isLadiesSeat;
    data['IsMalesSeat'] = this.isMalesSeat;
    data['IsUpper'] = this.isUpper;
    data['RowNo'] = this.rowNo;
    data['SeatFare'] = this.seatFare;
    data['SeatIndex'] = this.seatIndex;
    data['SeatName'] = this.seatName;
    data['SeatStatus'] = this.seatStatus;
    data['SeatType'] = this.seatType;
    data['Width'] = this.width;
    if (this.price != null) {
      data['Price'] = this.price!.toJson();
    }
    return data;
  }
}

class Price {
  String? currencyCode;
  double? basePrice;
  double? tax;
  double? otherCharges;
  double? discount;
  double? publishedPrice;
  double? publishedPriceRoundedOff;
  double? offeredPrice;
  double? offeredPriceRoundedOff;
  double? agentCommission;
  double? agentMarkUp;
  double? tDS;
  GST? gST;

  Price(
      {this.currencyCode,
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
      this.tDS,
      this.gST});

  Price.fromJson(Map<String, dynamic> json) {
    currencyCode = json['CurrencyCode'];
    basePrice = double.parse(json['BasePrice'].toString());
    tax = double.parse(json['Tax'].toString());
    otherCharges = double.parse(json['OtherCharges'].toString());
    discount = double.parse(json['Discount'].toString());
    publishedPrice = double.parse(json['PublishedPrice'].toString());
    publishedPriceRoundedOff =
        double.parse(json['PublishedPriceRoundedOff'].toString());
    offeredPrice = double.parse(json['OfferedPrice'].toString());
    offeredPriceRoundedOff =
        double.parse(json['OfferedPriceRoundedOff'].toString());
    agentCommission = double.parse(json['AgentCommission'].toString());
    agentMarkUp = double.parse(json['AgentMarkUp'].toString());
    tDS = double.parse(json['TDS'].toString());
    gST = json['GST'] != null ? new GST.fromJson(json['GST']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CurrencyCode'] = this.currencyCode;
    data['BasePrice'] = this.basePrice;
    data['Tax'] = this.tax;
    data['OtherCharges'] = this.otherCharges;
    data['Discount'] = this.discount;
    data['PublishedPrice'] = this.publishedPrice;
    data['PublishedPriceRoundedOff'] = this.publishedPriceRoundedOff;
    data['OfferedPrice'] = this.offeredPrice;
    data['OfferedPriceRoundedOff'] = this.offeredPriceRoundedOff;
    data['AgentCommission'] = this.agentCommission;
    data['AgentMarkUp'] = this.agentMarkUp;
    data['TDS'] = this.tDS;
    if (this.gST != null) {
      data['GST'] = this.gST!.toJson();
    }
    return data;
  }
}

class GST {
  double? cGSTAmount;
  double? cGSTRate;
  double? cessAmount;
  double? cessRate;
  double? iGSTAmount;
  double? iGSTRate;
  double? sGSTAmount;
  double? sGSTRate;
  double? taxableAmount;

  GST(
      {this.cGSTAmount,
      this.cGSTRate,
      this.cessAmount,
      this.cessRate,
      this.iGSTAmount,
      this.iGSTRate,
      this.sGSTAmount,
      this.sGSTRate,
      this.taxableAmount});

  GST.fromJson(Map<String, dynamic> json) {
    cGSTAmount = double.parse(json['CGSTAmount'].toString());
    cGSTRate = double.parse(json['CGSTRate'].toString());
    cessAmount = double.parse(json['CessAmount'].toString());
    cessRate = double.parse(json['CessRate'].toString());
    iGSTAmount = double.parse(json['IGSTAmount'].toString());
    iGSTRate = double.parse(json['IGSTRate'].toString());
    sGSTAmount = double.parse(json['SGSTAmount'].toString());
    sGSTRate = double.parse(json['SGSTRate'].toString());
    taxableAmount = double.parse(json['TaxableAmount'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CGSTAmount'] = this.cGSTAmount;
    data['CGSTRate'] = this.cGSTRate;
    data['CessAmount'] = this.cessAmount;
    data['CessRate'] = this.cessRate;
    data['IGSTAmount'] = this.iGSTAmount;
    data['IGSTRate'] = this.iGSTRate;
    data['SGSTAmount'] = this.sGSTAmount;
    data['SGSTRate'] = this.sGSTRate;
    data['TaxableAmount'] = this.taxableAmount;
    return data;
  }
}
