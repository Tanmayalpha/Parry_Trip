import 'package:parry_trip2/model/review_model.dart';

import 'fare_rule_model.dart';

class   FlightModel {
  List<SI>? sI;
  List<TotalPrice>? totalPriceList;
  bool? selected;
  String? activeTab;
  FlightModel({this.sI, this.totalPriceList, this.selected, this.activeTab});

  FlightModel.fromJson(Map<String, dynamic> json) {
    if (json['sI'] != null) {
      sI = <SI>[];
      json['sI'].forEach((v) {
        sI!.add(new SI.fromJson(v));
      });
    }
    selected = false;
    activeTab = "Details";
    if (json['totalPriceList'] != null) {
      totalPriceList = <TotalPrice>[];
      json['totalPriceList'].forEach((v) {
        totalPriceList!.add(new TotalPrice.fromJson(v));
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

class SI {
  String? id;
  FD? fD;
  int? stops;
  List<dynamic>? so;
  int? duration;
  Da? da;
  Da? aa;
  String? dt;
  String? at;
  bool? iand;
  bool? isRs;
  int? sN;
  List<SeatInfoModel>? meal;
  List<SeatInfoModel>? baggage;
  SI(
      {this.id,
        this.fD,
      this.stops,
      this.so,
      this.duration,
      this.baggage,
      this.meal,
      this.da,
      this.aa,
      this.dt,
      this.at,
      this.iand,
      this.isRs,
      this.sN});

  SI.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fD = json['fD'] != null ? new FD.fromJson(json['fD']) : null;
    stops = json['stops'];
    if (json['so'] != null) {
      so = <Null>[];
      json['so'].forEach((v) {
        so!.add(v);
      });
    }
    if (json['ssrInfo'] != null && json['ssrInfo']['MEAL'] != null) {
      meal = <SeatInfoModel>[];
      json['ssrInfo']['MEAL'].forEach((v) {
        meal!.add(SeatInfoModel.fromJson(v));
      });
    } else {
      meal = <SeatInfoModel>[];
    }
    if (json['ssrInfo'] != null && json['ssrInfo']['BAGGAGE'] != null) {
      baggage = <SeatInfoModel>[];
      json['ssrInfo']['BAGGAGE'].forEach((v) {
        baggage!.add(SeatInfoModel.fromJson(v));
      });
    } else {
      baggage = <SeatInfoModel>[];
    }
    duration = json['duration'];
    da = json['da'] != null ? new Da.fromJson(json['da']) : null;
    aa = json['aa'] != null ? new Da.fromJson(json['aa']) : null;
    dt = json['dt'];
    at = json['at'];
    iand = json['iand'];
    isRs = json['isRs'];
    sN = json['sN'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.fD != null) {
      data['fD'] = this.fD!.toJson();
    }
    data['stops'] = this.stops;
    if (this.so != null) {
      data['so'] = this.so!.map((v) => v).toList();
    }
    data['duration'] = this.duration;
    if (this.da != null) {
      data['da'] = this.da!.toJson();
    }
    if (this.aa != null) {
      data['aa'] = this.aa!.toJson();
    }
    data['dt'] = this.dt;
    data['at'] = this.at;
    data['iand'] = this.iand;
    data['isRs'] = this.isRs;
    data['sN'] = this.sN;
    return data;
  }
}

class FD {
  AI? aI;
  String? fN;
  String? eT;

  FD({this.aI, this.fN, this.eT});

  FD.fromJson(Map<String, dynamic> json) {
    aI = json['aI'] != null ? new AI.fromJson(json['aI']) : null;
    fN = json['fN'];
    eT = json['eT'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.aI != null) {
      data['aI'] = this.aI!.toJson();
    }
    data['fN'] = this.fN;
    data['eT'] = this.eT;
    return data;
  }
}

class AI {
  String? code;
  String? name;
  bool? isLcc;

  AI({this.code, this.name, this.isLcc});

  AI.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    name = json['name'];
    isLcc = json['isLcc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['name'] = this.name;
    data['isLcc'] = this.isLcc;
    return data;
  }
}

class Da {
  String? code;
  String? name;
  String? cityCode;
  String? city;
  String? country;
  String? countryCode;
  String? terminal;

  Da(
      {this.code,
      this.name,
      this.cityCode,
      this.city,
      this.country,
      this.countryCode,
      this.terminal});

  Da.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    name = json['name'];
    cityCode = json['cityCode'];
    city = json['city'];
    country = json['country'];
    countryCode = json['countryCode'];
    terminal = json['terminal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['name'] = this.name;
    data['cityCode'] = this.cityCode;
    data['city'] = this.city;
    data['country'] = this.country;
    data['countryCode'] = this.countryCode;
    data['terminal'] = this.terminal;
    return data;
  }
}

class TotalPrice {
  Fd? fd;
  String? fareIdentifier;
  String? id;
 // List<dynamic>? msri;
 // List<dynamic>? messages;
  FareRule? rules;
  TotalPrice(
      {this.fd,
      this.fareIdentifier,
      this.id,
      //this.msri,
     // this.messages,
      this.rules});

  TotalPrice.fromJson(Map<String, dynamic> json) {
    fd = json['fd'] != null ? new Fd.fromJson(json['fd']) : null;
    /*rules = json['fareRuleInformation'] != null &&
            json['fareRuleInformation']['tfr'] != null
        ? new FareRule.fromJson(json['fareRuleInformation']['tfr'])
        : null;*/
    fareIdentifier = json['fareIdentifier'];
    id = json['id'];
    /*if (json['msri'] != null) {
      msri = <Null>[];
      json['msri'].forEach((v) {
        msri!.add(v);
      });
    }*/
    /*if (json['messages'] != null) {
      messages = <Null>[];
      json['messages'].forEach((v) {
        messages!.add(v);
      });
    }*/
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.fd != null) {
      data['fd'] = this.fd!.toJson();
    }
    data['fareIdentifier'] = this.fareIdentifier;
    data['id'] = this.id;
    /*if (this.msri != null) {
      data['msri'] = this.msri!.map((v) => v.toJson()).toList();
    }*/
    /*if (this.messages != null) {
      data['messages'] = this.messages!.map((v) => v.toJson()).toList();
    }*/
    return data;
  }
}

class Fd {
  ADULT? aDULT;
  ADULT? child;
  ADULT? infant;
  Fd({this.aDULT});

  Fd.fromJson(Map<String, dynamic> json) {
    aDULT = json['ADULT'] != null ? new ADULT.fromJson(json['ADULT']) : null;
    child = json['CHILD'] != null ? new ADULT.fromJson(json['CHILD']) : null;
    infant = json['INFANT'] != null ? new ADULT.fromJson(json['INFANT']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.aDULT != null) {
      data['ADULT'] = this.aDULT!.toJson();
    }
    return data;
  }
}

class ADULT {
  FC? fC;
  AfC? afC;
  int? sR;
  BI? bI;
  int? rT;
  String? cc;
  String? cB;
  String? fB;
  bool? mI;

  ADULT(
      {this.fC,
      this.afC,
      this.sR,
      this.bI,
      this.rT,
      this.cc,
      this.cB,
      this.fB,
      this.mI});

  ADULT.fromJson(Map<String, dynamic> json) {
    fC = json['fC'] != null ? new FC.fromJson(json['fC']) : null;
    afC = json['afC'] != null ? new AfC.fromJson(json['afC']) : null;
    sR = json['sR'];
    bI = json['bI'] != null ? new BI.fromJson(json['bI']) : null;
    rT = json['rT'];
    cc = json['cc'];
    cB = json['cB'];
    fB = json['fB'];
    mI = json['mI'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.fC != null) {
      data['fC'] = this.fC!.toJson();
    }
    if (this.afC != null) {
      data['afC'] = this.afC!.toJson();
    }
    data['sR'] = this.sR;
    if (this.bI != null) {
      data['bI'] = this.bI!.toJson();
    }
    data['rT'] = this.rT;
    data['cc'] = this.cc;
    data['cB'] = this.cB;
    data['fB'] = this.fB;
    data['mI'] = this.mI;
    return data;
  }
}

class FC {
  double? bF;
  double? tF;
  double? tAF;
  double? nF;

  FC({this.bF, this.tF, this.tAF, this.nF});

  FC.fromJson(Map<String, dynamic> json) {
    bF = json['BF'];
    tF = json['TF'];
    tAF = json['TAF'];
    nF = json['NF'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['BF'] = this.bF;
    data['TF'] = this.tF;
    data['TAF'] = this.tAF;
    data['NF'] = this.nF;
    return data;
  }
}

class AfC {
  TAF? tAF;

  AfC({this.tAF});

  AfC.fromJson(Map<String, dynamic> json) {
    tAF = json['TAF'] != null ? new TAF.fromJson(json['TAF']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.tAF != null) {
      data['TAF'] = this.tAF!.toJson();
    }
    return data;
  }
}

class TAF {
  double? mF;
  double? oT;
  double? aGST;
  double? mFT;
  double? yQ;

  TAF({this.mF, this.oT, this.aGST, this.mFT, this.yQ});

  TAF.fromJson(Map<String, dynamic> json) {
    mF = json['MF'];
    oT = json['OT'];
    aGST = json['AGST'];
    mFT = json['MFT'];
    yQ = json['YQ'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['MF'] = this.mF;
    data['OT'] = this.oT;
    data['AGST'] = this.aGST;
    data['MFT'] = this.mFT;
    data['YQ'] = this.yQ;
    return data;
  }
}

class BI {
  String? iB;
  String? cB;

  BI({this.iB, this.cB});

  BI.fromJson(Map<String, dynamic> json) {
    iB = json['iB'];
    cB = json['cB'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['iB'] = this.iB;
    data['cB'] = this.cB;
    return data;
  }
}
