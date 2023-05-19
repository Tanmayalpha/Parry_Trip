class FlightListModel {
  SearchResult? searchResult;
  Status? status;

  FlightListModel({this.searchResult, this.status});

  FlightListModel.fromJson(Map<String, dynamic> json) {
    searchResult = json['searchResult'] != null ? new SearchResult.fromJson(json['searchResult']) : null;
    status = json['status'] != null ? new Status.fromJson(json['status']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.searchResult != null) {
      data['searchResult'] = this.searchResult!.toJson();
    }
    if (this.status != null) {
      data['status'] = this.status!.toJson();
    }
    return data;
  }
}

class SearchResult {
  TripInfos? tripInfos;

  SearchResult({this.tripInfos});

  SearchResult.fromJson(Map<String, dynamic> json) {
    tripInfos = json['tripInfos'] != null ? new TripInfos.fromJson(json['tripInfos']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.tripInfos != null) {
      data['tripInfos'] = this.tripInfos!.toJson();
    }
    return data;
  }
}

class TripInfos {
  List<ONWARD>? oNWARD;

  TripInfos({this.oNWARD});

  TripInfos.fromJson(Map<String, dynamic> json) {
    if (json['ONWARD'] != null) {
      oNWARD = <ONWARD>[];
      json['ONWARD'].forEach((v) { oNWARD!.add(new ONWARD.fromJson(v)); });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.oNWARD != null) {
      data['ONWARD'] = this.oNWARD!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ONWARD {
  List<SI>? sI;
  List<TotalPriceList>? totalPriceList;
  bool? isSelected;

  ONWARD({this.sI, this.totalPriceList,this.isSelected});

  ONWARD.fromJson(Map<String, dynamic> json) {
    isSelected = false;
    if (json['sI'] != null) {
      sI = <SI>[];
      json['sI'].forEach((v) { sI!.add(new SI.fromJson(v)); });
    }
    if (json['totalPriceList'] != null) {
      totalPriceList = <TotalPriceList>[];
      json['totalPriceList'].forEach((v) { totalPriceList!.add(new TotalPriceList.fromJson(v)); });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.sI != null) {
      data['sI'] = this.sI!.map((v) => v.toJson()).toList();
    }
    if (this.totalPriceList != null) {
      data['totalPriceList'] = this.totalPriceList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SI {
  String? id;
  FD? fD;
  int? stops;
  List<Null>? so;
  int? duration;
  Da? da;
  Da? aa;
  String? dt;
  String? at;
  bool? iand;
  bool? isRs;
  int? sN;

  SI({this.id, this.fD, this.stops, this.so, this.duration, this.da, this.aa, this.dt, this.at, this.iand, this.isRs, this.sN});

  SI.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fD = json['fD'] != null ? new FD.fromJson(json['fD']) : null;
    stops = json['stops'];
    // if (json['so'] != null) {
    //   so = <Null>[];
    //   json['so'].forEach((v) { so!.add(new Null.fromJson(v)); });
    // }
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
    // if (this.so != null) {
    //   data['so'] = this.so!.map((v) => v.toJson()).toList();
    // }
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

  Da({this.code, this.name, this.cityCode, this.city, this.country, this.countryCode, this.terminal});

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

class TotalPriceList {
  Fd? fd;
  String? fareIdentifier;
  String? id;
  List<Null>? msri;
  //Tai? tai;

 // TotalPriceList({this.fd, this.fareIdentifier, this.id, this.msri, this.tai});

  TotalPriceList.fromJson(Map<String, dynamic> json) {
    fd = json['fd'] != null ? new Fd.fromJson(json['fd']) : null;
    fareIdentifier = json['fareIdentifier'];
    id = json['id'];
    // if (json['msri'] != null) {
    //   msri = <Null>[];
    //   json['msri'].forEach((v) { msri!.add(new Null.fromJson(v)); });
    // }
   // tai = json['tai'] != null ? new Tai.fromJson(json['tai']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.fd != null) {
      data['fd'] = this.fd!.toJson();
    }
    data['fareIdentifier'] = this.fareIdentifier;
    data['id'] = this.id;
    // if (this.msri != null) {
    //   data['msri'] = this.msri!.map((v) => v.toJson()).toList();
    // }
    // if (this.tai != null) {
    //   data['tai'] = this.tai!.toJson();
    // }
    return data;
  }
}

class Fd {
  BI? aDULT;
  BI? cHILD;

  Fd({this.aDULT, this.cHILD});

  Fd.fromJson(Map<String, dynamic> json) {
    aDULT = json['ADULT'] != null ? new BI.fromJson(json['ADULT']) : null;
    cHILD = json['CHILD'] != null ? new BI.fromJson(json['CHILD']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.aDULT != null) {
      data['ADULT'] = this.aDULT!.toJson();
    }
    if (this.cHILD != null) {
      data['CHILD'] = this.cHILD!.toJson();
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

  ADULT({this.fC, this.afC, this.sR, this.bI, this.rT, this.cc, this.cB, this.fB, this.mI});

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
  int? bF;
  double? tAF;
  double? tF;
  double? nF;

  FC({this.bF, this.tAF, this.tF, this.nF});

  FC.fromJson(Map<String, dynamic> json) {
    bF = json['BF'];
    tAF = json['TAF'];
    tF = json['TF'];
    nF = json['NF'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['BF'] = this.bF;
    data['TAF'] = this.tAF;
    data['TF'] = this.tF;
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
  int? mF;
  double? mFT;
  int? yQ;
  int? oT;
  int? aGST;
  int? yR;

  TAF({this.mF, this.mFT, this.yQ, this.oT, this.aGST, this.yR});

  TAF.fromJson(Map<String, dynamic> json) {
    mF = json['MF'];
    mFT = json['MFT'];
    yQ = json['YQ'];
    oT = json['OT'];
    aGST = json['AGST'];
    yR = json['YR'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['MF'] = this.mF;
    data['MFT'] = this.mFT;
    data['YQ'] = this.yQ;
    data['OT'] = this.oT;
    data['AGST'] = this.aGST;
    data['YR'] = this.yR;
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

// class Tai {
//   Tbi? tbi;
//
//   Tai({this.tbi});
//
//   Tai.fromJson(Map<String, dynamic> json) {
//     tbi = json['tbi'] != null ? new Tbi.fromJson(json['tbi']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.tbi != null) {
//       data['tbi'] = this.tbi!.toJson();
//     }
//     return data;
//   }
// }

// class Tbi {
//   List<16>? l16;
//   List<112>? l112;
//   List<421>? l421;
//   List<879>? l879;
//   List<196>? l196;
//   List<195>? l195;
//   List<342>? l342;
//   List<381>? l381;
//   List<209>? l209;
//   List<341>? l341;
//   List<66>? l66;
//   List<452>? l452;
//   List<144>? l144;
//   List<503>? l503;
//   List<189>? l189;
//   List<166>? l166;
//   List<541>? l541;
//   List<210>? l210;
//   List<645>? l645;
//   List<25>? l25;
//
//   Tbi({this.l16, this.l112, this.l421, this.l879, this.l196, this.l195, this.l342, this.l381, this.l209, this.l341, this.l66, this.l452, this.l144, this.l503, this.l189, this.l166, this.l541, this.l210, this.l645, this.l25});
//
//   Tbi.fromJson(Map<String, dynamic> json) {
//     if (json['16'] != null) {
//       l16 = <16>[];
//     json['16'].forEach((v) { l16!.add(new 16.fromJson(v)); });
//     }
//     if (json['112'] != null) {
//     l112 = <112>[];
//     json['112'].forEach((v) { l112!.add(new 112.fromJson(v)); });
//     }
//     if (json['421'] != null) {
//     l421 = <421>[];
//     json['421'].forEach((v) { l421!.add(new 421.fromJson(v)); });
//     }
//     if (json['879'] != null) {
//     l879 = <879>[];
//     json['879'].forEach((v) { l879!.add(new 879.fromJson(v)); });
//     }
//     if (json['196'] != null) {
//     l196 = <196>[];
//     json['196'].forEach((v) { l196!.add(new 196.fromJson(v)); });
//     }
//     if (json['195'] != null) {
//     l195 = <195>[];
//     json['195'].forEach((v) { l195!.add(new 195.fromJson(v)); });
//     }
//     if (json['342'] != null) {
//     l342 = <342>[];
//     json['342'].forEach((v) { l342!.add(new 342.fromJson(v)); });
//     }
//     if (json['381'] != null) {
//     l381 = <381>[];
//     json['381'].forEach((v) { l381!.add(new 381.fromJson(v)); });
//     }
//     if (json['209'] != null) {
//     l209 = <209>[];
//     json['209'].forEach((v) { l209!.add(new 209.fromJson(v)); });
//     }
//     if (json['341'] != null) {
//     l341 = <341>[];
//     json['341'].forEach((v) { l341!.add(new 341.fromJson(v)); });
//     }
//     if (json['66'] != null) {
//     l66 = <66>[];
//     json['66'].forEach((v) { l66!.add(new 66.fromJson(v)); });
//     }
//     if (json['452'] != null) {
//     l452 = <452>[];
//     json['452'].forEach((v) { l452!.add(new 452.fromJson(v)); });
//     }
//     if (json['144'] != null) {
//     l144 = <144>[];
//     json['144'].forEach((v) { l144!.add(new 144.fromJson(v)); });
//     }
//     if (json['503'] != null) {
//     l503 = <503>[];
//     json['503'].forEach((v) { l503!.add(new 503.fromJson(v)); });
//     }
//     if (json['189'] != null) {
//     l189 = <189>[];
//     json['189'].forEach((v) { l189!.add(new 189.fromJson(v)); });
//     }
//     if (json['166'] != null) {
//     l166 = <166>[];
//     json['166'].forEach((v) { l166!.add(new 166.fromJson(v)); });
//     }
//     if (json['541'] != null) {
//     l541 = <541>[];
//     json['541'].forEach((v) { l541!.add(new 541.fromJson(v)); });
//     }
//     if (json['210'] != null) {
//     l210 = <210>[];
//     json['210'].forEach((v) { l210!.add(new 210.fromJson(v)); });
//     }
//     if (json['645'] != null) {
//     l645 = <645>[];
//     json['645'].forEach((v) { l645!.add(new 645.fromJson(v)); });
//     }
//     if (json['25'] != null) {
//     l25 = <25>[];
//     json['25'].forEach((v) { l25!.add(new 25.fromJson(v)); });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.l16 != null) {
//       data['16'] = this.l16!.map((v) => v.toJson()).toList();
//     }
//     if (this.l112 != null) {
//       data['112'] = this.l112!.map((v) => v.toJson()).toList();
//     }
//     if (this.l421 != null) {
//       data['421'] = this.l421!.map((v) => v.toJson()).toList();
//     }
//     if (this.l879 != null) {
//       data['879'] = this.l879!.map((v) => v.toJson()).toList();
//     }
//     if (this.l196 != null) {
//       data['196'] = this.l196!.map((v) => v.toJson()).toList();
//     }
//     if (this.l195 != null) {
//       data['195'] = this.l195!.map((v) => v.toJson()).toList();
//     }
//     if (this.l342 != null) {
//       data['342'] = this.l342!.map((v) => v.toJson()).toList();
//     }
//     if (this.l381 != null) {
//       data['381'] = this.l381!.map((v) => v.toJson()).toList();
//     }
//     if (this.l209 != null) {
//       data['209'] = this.l209!.map((v) => v.toJson()).toList();
//     }
//     if (this.l341 != null) {
//       data['341'] = this.l341!.map((v) => v.toJson()).toList();
//     }
//     if (this.l66 != null) {
//       data['66'] = this.l66!.map((v) => v.toJson()).toList();
//     }
//     if (this.l452 != null) {
//       data['452'] = this.l452!.map((v) => v.toJson()).toList();
//     }
//     if (this.l144 != null) {
//       data['144'] = this.l144!.map((v) => v.toJson()).toList();
//     }
//     if (this.l503 != null) {
//       data['503'] = this.l503!.map((v) => v.toJson()).toList();
//     }
//     if (this.l189 != null) {
//       data['189'] = this.l189!.map((v) => v.toJson()).toList();
//     }
//     if (this.l166 != null) {
//       data['166'] = this.l166!.map((v) => v.toJson()).toList();
//     }
//     if (this.l541 != null) {
//       data['541'] = this.l541!.map((v) => v.toJson()).toList();
//     }
//     if (this.l210 != null) {
//       data['210'] = this.l210!.map((v) => v.toJson()).toList();
//     }
//     if (this.l645 != null) {
//       data['645'] = this.l645!.map((v) => v.toJson()).toList();
//     }
//     if (this.l25 != null) {
//       data['25'] = this.l25!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

class Status {
  bool? success;
  int? httpStatus;

  Status({this.success, this.httpStatus});

  Status.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    httpStatus = json['httpStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['httpStatus'] = this.httpStatus;
    return data;
  }
}
//
// class SI {
//   String? id;
//   FD? fD;
//   int? stops;
//   List<Null>? so;
//   int? duration;
//   Da? da;
//   Da? aa;
//   String? dt;
//   String? at;
//   bool? iand;
//   bool? isRs;
//   int? sN;
//
//   SI({this.id, this.fD, this.stops, this.so, this.duration, this.da, this.aa, this.dt, this.at, this.iand, this.isRs, this.sN});
//
//   SI.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     fD = json['fD'] != null ? new FD.fromJson(json['fD']) : null;
//     stops = json['stops'];
//     // if (json['so'] != null) {
//     //   so = <Null>[];
//     //   json['so'].forEach((v) { so!.add(new Null.fromJson(v)); });
//     // }
//     duration = json['duration'];
//     da = json['da'] != null ? new Da.fromJson(json['da']) : null;
//     aa = json['aa'] != null ? new Da.fromJson(json['aa']) : null;
//     dt = json['dt'];
//     at = json['at'];
//     iand = json['iand'];
//     isRs = json['isRs'];
//     sN = json['sN'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     if (this.fD != null) {
//       data['fD'] = this.fD!.toJson();
//     }
//     data['stops'] = this.stops;
//     // if (this.so != null) {
//     //   data['so'] = this.so!.map((v) => v!.toJson()).toList();
//     // }
//     data['duration'] = this.duration;
//     if (this.da != null) {
//       data['da'] = this.da!.toJson();
//     }
//     if (this.aa != null) {
//       data['aa'] = this.aa!.toJson();
//     }
//     data['dt'] = this.dt;
//     data['at'] = this.at;
//     data['iand'] = this.iand;
//     data['isRs'] = this.isRs;
//     data['sN'] = this.sN;
//     return data;
//   }
// }
//
// class Fd {
//   BI? aDULT;
//   BI? cHILD;
//
//   Fd({this.aDULT, this.cHILD});
//
//   Fd.fromJson(Map<String, dynamic> json) {
//     aDULT = json['ADULT'] != null ? new BI.fromJson(json['ADULT']) : null;
//     cHILD = json['CHILD'] != null ? new BI.fromJson(json['CHILD']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.aDULT != null) {
//       data['ADULT'] = this.aDULT!.toJson();
//     }
//     if (this.cHILD != null) {
//       data['CHILD'] = this.cHILD!.toJson();
//     }
//     return data;
//   }
// }
