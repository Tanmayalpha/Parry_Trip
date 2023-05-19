import 'flight_model.dart';

class ReviewModel {
  List<SI>? sI;
  List<TotalPrice>? totalPriceList;
  FC? fc;
  AfC? afc;
  List<AlertModel>? alerts;
  SearchQueryModel? searchQueryModel;
  ConditionModel? conditionModel;
  String? bookingId;
  ReviewModel(
      {this.sI,
      this.totalPriceList,
      this.alerts,
      this.fc,
      this.afc,
      this.bookingId,
      this.searchQueryModel});

  ReviewModel.fromJson(Map<String, dynamic> json) {
    if (json['tripInfos'].length > 0 && json['tripInfos'][0]['sI'] != null) {
      sI = <SI>[];
      json['tripInfos'][0]['sI'].forEach((v) {
        sI!.add(new SI.fromJson(v));
      });
    }
    if (json['tripInfos'].length > 0 &&
        json['tripInfos'][0]['totalPriceList'] != null) {
      totalPriceList = <TotalPrice>[];
      json['tripInfos'][0]['totalPriceList'].forEach((v) {
        totalPriceList!.add(new TotalPrice.fromJson(v));
      });
    }
    bookingId = json['bookingId'];
    searchQueryModel = json['searchQuery'] != null
        ? SearchQueryModel.fromJson(json['searchQuery'])
        : null;
    fc = json['totalPriceInfo'] != null &&
            json['totalPriceInfo']['totalFareDetail'] != null &&
            json['totalPriceInfo']['totalFareDetail']['fC'] != null
        ? FC.fromJson(json['totalPriceInfo']['totalFareDetail']['fC'])
        : null;
    afc = json['totalPriceInfo'] != null &&
            json['totalPriceInfo']['totalFareDetail'] != null &&
            json['totalPriceInfo']['totalFareDetail']['afC'] != null
        ? AfC.fromJson(json['totalPriceInfo']['totalFareDetail']['afC'])
        : null;
    conditionModel = json['conditions'] != null
        ? ConditionModel.fromJson(json['conditions'])
        : null;

    if (json['alerts'] != null) {
      alerts = <AlertModel>[];
      json['alerts'].forEach((v) {
        alerts!.add(new AlertModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.sI != null) {
      data['sI'] = this.sI!.map((v) => v.toJson()).toList();
    }
    if (this.totalPriceList != null) {
      data['totalPriceList'] =
          this.totalPriceList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ConditionModel {
  List<String>? ffas;
  bool? isa;
  Dob? dob;
  bool? iecr;
  Dc? dc;
  bool? isBA;
  int? st;
  String? sct;
  Gst? gst;

  ConditionModel(
      {this.ffas,
      this.isa,
      this.dob,
      this.iecr,
      this.dc,
      this.isBA,
      this.st,
      this.sct,
      this.gst});

  ConditionModel.fromJson(Map<String, dynamic> json) {
    ffas = json['ffas'].cast<String>();
    isa = json['isa'];
    dob = json['dob'] != null ? new Dob.fromJson(json['dob']) : null;
    iecr = json['iecr'];
    dc = json['dc'] != null ? new Dc.fromJson(json['dc']) : null;
    isBA = json['isBA'];
    st = json['st'];
    sct = json['sct'];
    gst = json['gst'] != null ? new Gst.fromJson(json['gst']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ffas'] = this.ffas;
    data['isa'] = this.isa;
    if (this.dob != null) {
      data['dob'] = this.dob!.toJson();
    }
    data['iecr'] = this.iecr;
    if (this.dc != null) {
      data['dc'] = this.dc!.toJson();
    }
    data['isBA'] = this.isBA;
    data['st'] = this.st;
    data['sct'] = this.sct;
    if (this.gst != null) {
      data['gst'] = this.gst!.toJson();
    }
    return data;
  }
}

class Dob {
  bool? adobr;
  bool? cdobr;
  bool? idobr;

  Dob({this.adobr, this.cdobr, this.idobr});

  Dob.fromJson(Map<String, dynamic> json) {
    adobr = json['adobr'];
    cdobr = json['cdobr'];
    idobr = json['idobr'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['adobr'] = this.adobr;
    data['cdobr'] = this.cdobr;
    data['idobr'] = this.idobr;
    return data;
  }
}

class Dc {
  bool? ida;
  bool? idm;

  Dc({this.ida, this.idm});

  Dc.fromJson(Map<String, dynamic> json) {
    ida = json['ida'];
    idm = json['idm'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ida'] = this.ida;
    data['idm'] = this.idm;
    return data;
  }
}

class Gst {
  bool? gstappl;
  bool? igm;

  Gst({this.gstappl, this.igm});

  Gst.fromJson(Map<String, dynamic> json) {
    gstappl = json['gstappl'];
    igm = json['igm'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['gstappl'] = this.gstappl;
    data['igm'] = this.igm;
    return data;
  }
}

class AlertModel {
  double? oldFare;
  double? newFare;
  int? discount;
  String? type;

  AlertModel({this.oldFare, this.newFare, this.discount, this.type});

  AlertModel.fromJson(Map<String, dynamic> json) {
    oldFare = json['oldFare'];
    newFare = json['newFare'];
    discount = json['discount'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['oldFare'] = this.oldFare;
    data['newFare'] = this.newFare;
    data['discount'] = this.discount;
    data['type'] = this.type;
    return data;
  }
}

class SearchQueryModel {
  List<RouteInfos>? routeInfos;
  String? cabinClass;
  PaxInfo? paxInfo;
  String? requestId;
  String? searchType;
  SearchModifiers? searchModifiers;
  bool? isDomestic;

  SearchQueryModel(
      {this.routeInfos,
      this.cabinClass,
      this.paxInfo,
      this.requestId,
      this.searchType,
      this.searchModifiers,
      this.isDomestic});

  SearchQueryModel.fromJson(Map<String, dynamic> json) {
    if (json['routeInfos'] != null) {
      routeInfos = <RouteInfos>[];
      json['routeInfos'].forEach((v) {
        routeInfos!.add(new RouteInfos.fromJson(v));
      });
    }
    cabinClass = json['cabinClass'];
    paxInfo =
        json['paxInfo'] != null ? new PaxInfo.fromJson(json['paxInfo']) : null;
    requestId = json['requestId'];
    searchType = json['searchType'];
    searchModifiers = json['searchModifiers'] != null
        ? new SearchModifiers.fromJson(json['searchModifiers'])
        : null;
    isDomestic = json['isDomestic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.routeInfos != null) {
      data['routeInfos'] = this.routeInfos!.map((v) => v.toJson()).toList();
    }
    data['cabinClass'] = this.cabinClass;
    if (this.paxInfo != null) {
      data['paxInfo'] = this.paxInfo!.toJson();
    }
    data['requestId'] = this.requestId;
    data['searchType'] = this.searchType;
    if (this.searchModifiers != null) {
      data['searchModifiers'] = this.searchModifiers!.toJson();
    }
    data['isDomestic'] = this.isDomestic;
    return data;
  }
}

class RouteInfos {
  FromCityOrAirport? fromCityOrAirport;
  FromCityOrAirport? toCityOrAirport;
  String? travelDate;

  RouteInfos({this.fromCityOrAirport, this.toCityOrAirport, this.travelDate});

  RouteInfos.fromJson(Map<String, dynamic> json) {
    fromCityOrAirport = json['fromCityOrAirport'] != null
        ? new FromCityOrAirport.fromJson(json['fromCityOrAirport'])
        : null;
    toCityOrAirport = json['toCityOrAirport'] != null
        ? new FromCityOrAirport.fromJson(json['toCityOrAirport'])
        : null;
    travelDate = json['travelDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.fromCityOrAirport != null) {
      data['fromCityOrAirport'] = this.fromCityOrAirport!.toJson();
    }
    if (this.toCityOrAirport != null) {
      data['toCityOrAirport'] = this.toCityOrAirport!.toJson();
    }
    data['travelDate'] = this.travelDate;
    return data;
  }
}

class FromCityOrAirport {
  String? code;
  String? name;
  String? cityCode;
  String? city;
  String? country;
  String? countryCode;

  FromCityOrAirport(
      {this.code,
      this.name,
      this.cityCode,
      this.city,
      this.country,
      this.countryCode});

  FromCityOrAirport.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    name = json['name'];
    cityCode = json['cityCode'];
    city = json['city'];
    country = json['country'];
    countryCode = json['countryCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['name'] = this.name;
    data['cityCode'] = this.cityCode;
    data['city'] = this.city;
    data['country'] = this.country;
    data['countryCode'] = this.countryCode;
    return data;
  }
}

class PaxInfo {
  int? aDULT;
  int? cHILD;
  int? iNFANT;

  PaxInfo({this.aDULT, this.cHILD, this.iNFANT});

  PaxInfo.fromJson(Map<String, dynamic> json) {
    aDULT = json['ADULT'];
    cHILD = json['CHILD'];
    iNFANT = json['INFANT'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ADULT'] = this.aDULT;
    data['CHILD'] = this.cHILD;
    data['INFANT'] = this.iNFANT;
    return data;
  }
}

class SearchModifiers {
  bool? isDirectFlight;
  bool? isConnectingFlight;
  String? pft;

  SearchModifiers({this.isDirectFlight, this.isConnectingFlight, this.pft});

  SearchModifiers.fromJson(Map<String, dynamic> json) {
    isDirectFlight = json['isDirectFlight'];
    isConnectingFlight = json['isConnectingFlight'];
    pft = json['pft'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isDirectFlight'] = this.isDirectFlight;
    data['isConnectingFlight'] = this.isConnectingFlight;
    data['pft'] = this.pft;
    return data;
  }
}

class SeatInfoModel {
  String? code;
  String? desc;
  double? ctds;
  double? amount;
  SeatInfoModel({this.code, this.desc, this.ctds, this.amount});

  SeatInfoModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    desc = json['desc'];
    ctds = json['ctds'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['desc'] = this.desc;
    data['ctds'] = this.ctds;
    data['amount'] = this.amount;
    return data;
  }
}
