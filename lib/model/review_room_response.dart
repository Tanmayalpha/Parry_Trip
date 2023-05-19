class ReviewRoomResponse {
  HInfo? hInfo;
  String? bookingId;
  List<Alerts>? alerts;
  Query? query;
  bool? isPriceChanged;
  Status? status;
  List<Errors>? errors;

  ReviewRoomResponse({this.hInfo, this.bookingId, this.alerts, this.query, this.isPriceChanged, this.status, this.errors});

  ReviewRoomResponse.fromJson(Map<String, dynamic> json) {
    hInfo = json['hInfo'] != null ?  HInfo.fromJson(json['hInfo']) : null;
    bookingId = json['bookingId'];
    if (json['alerts'] != null) {
      alerts = <Alerts>[];
      json['alerts'].forEach((v) { alerts!.add(new Alerts.fromJson(v)); });
    }
    query = json['query'] != null ?  Query.fromJson(json['query']) : null;
    isPriceChanged = json['isPriceChanged'];
    status = json['status'] != null ?  Status.fromJson(json['status']) : null;
    if (json['errors'] != null) {
      errors = <Errors>[];
      json['errors'].forEach((v) { errors!.add(new Errors.fromJson(v)); });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    if (this.hInfo != null) {
      data['hInfo'] = this.hInfo!.toJson();
    }
    data['bookingId'] = this.bookingId;
    if (this.alerts != null) {
      data['alerts'] = this.alerts!.map((v) => v.toJson()).toList();
    }
    if (this.query != null) {
      data['query'] = this.query!.toJson();
    }
    data['isPriceChanged'] = this.isPriceChanged;
    if (this.status != null) {
      data['status'] = this.status!.toJson();
    }
    if (this.errors != null) {
      data['errors'] = this.errors!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class HInfo {
  String? id;
  String? name;
  List<Img >? img;
  int? rt;
  Gl? gl;
  Ad? ad;
  List? fl;
  String? pt;
  List<dynamic>? ht;
  List<Ops>? ops;
  String? uid;
  String? lhc;

  HInfo({this.fl,this.id, this.name, this.img, this.rt, this.gl, this.ad, this.pt, this.ht, this.ops, this.uid, this.lhc});

  HInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fl = json['fl'];
    name = json['name'];
    if (json['img'] != null) {
      img = <Img>[];
      json['img'].forEach((v) { img!.add(new Img.fromJson(v)); });
    }
    rt = json['rt'];
    gl = json['gl'] != null ? new Gl.fromJson(json['gl']) : null;
    ad = json['ad'] != null ? new Ad.fromJson(json['ad']) : null;
    pt = json['pt'];
    if (json['ht'] != null) {
      /*ht = <dynamic>[];
      json['ht'].forEach((v) { ht!.add( .fromJson(v)); });*/
    }
    if (json['ops'] != null) {
      ops = <Ops>[];
      json['ops'].forEach((v) { ops!.add(new Ops.fromJson(v)); });
    }
    uid = json['uid'];
    lhc = json['lhc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.img != null) {
      data['img'] = this.img!.map((v) => v.toJson()).toList();
    }
    data['rt'] = this.rt;
    if (this.gl != null) {
      data['gl'] = this.gl!.toJson();
    }
    if (this.ad != null) {
      data['ad'] = this.ad!.toJson();
    }
    data['pt'] = this.pt;
    /*if (this.ht != null) {
      data['ht'] = this.ht!.map((v) => v.toJson()).toList();
    }*/
    if (this.ops != null) {
      data['ops'] = this.ops!.map((v) => v.toJson()).toList();
    }
    data['uid'] = this.uid;
    data['lhc'] = this.lhc;
    return data;
  }
}

class Img {
  String? url;

  Img({this.url});

  Img.fromJson(Map<String, dynamic> json) {
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    return data;
  }
}

class Gl {
  String? ln;
  String? lt;

  Gl({this.ln, this.lt});

  Gl.fromJson(Map<String, dynamic> json) {
    ln = json['ln'];
    lt = json['lt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ln'] = this.ln;
    data['lt'] = this.lt;
    return data;
  }
}

class Ad {
  String? adr;
  String? adr2;
  String? postalCode;
  City? city;
  CountryState? state;
  City? country;
  String? ctn;
  String? cn;

  Ad({this.adr, this.adr2, this.postalCode, this.city, this.state, this.country, this.ctn, this.cn});

  Ad.fromJson(Map<String, dynamic> json) {
    adr = json['adr'];
    adr2 = json['adr2'];
    postalCode = json['postalCode'];
    city = json['city'] != null ?  City.fromJson(json['city']) : null;
    state = json['state'] != null ?  CountryState.fromJson(json['state']) : null;
    country = json['country'] != null ?  City.fromJson(json['country']) : null;
    ctn = json['ctn'];
    cn = json['cn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['adr'] = this.adr;
    data['adr2'] = this.adr2;
    data['postalCode'] = this.postalCode;
    if (this.city != null) {
      data['city'] = this.city!.toJson();
    }
    if (this.state != null) {
      data['state'] = this.state!.toJson();
    }
    if (this.country != null) {
      data['country'] = this.country!.toJson();
    }
    data['ctn'] = this.ctn;
    data['cn'] = this.cn;
    return data;
  }
}

class City {
  String? name;

  City({this.name});

  City.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}

class CountryState {


  CountryState();

CountryState.fromJson(Map<String, dynamic> json) {
}

Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  return data;
}
}

class Ops {
  List<Ris>? ris;
  String? id;
  Cnp? cnp;
  String? ddt;
  Oai? oai;
  bool? ispr;
  bool? ipr;
  bool? ipm;
  int? cpb;
  double? tp;

  Ops({this.ris, this.id, this.tp, this.cnp, this.ddt, this.oai, this.ispr, this.ipr, this.ipm, this.cpb});

  Ops.fromJson(Map<String, dynamic> json) {
    if (json['ris'] != null) {
      ris = <Ris>[];
      json['ris'].forEach((v) { ris!.add(new Ris.fromJson(v)); });
    }
    id = json['id'];
    tp = json['tp'];
    cnp = json['cnp'] != null ? new Cnp.fromJson(json['cnp']) : null;
    ddt = json['ddt'];
    oai = json['oai'] != null ? new Oai.fromJson(json['oai']) : null;
    ispr = json['ispr'];
    ipr = json['ipr'];
    ipm = json['ipm'];
    cpb = json['cpb'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.ris != null) {
      data['ris'] = this.ris!.map((v) => v.toJson()).toList();
    }
    data['id'] = this.id;
    data['tp'] = this.tp;
    if (this.cnp != null) {
      data['cnp'] = this.cnp!.toJson();
    }
    data['ddt'] = this.ddt;
    if (this.oai != null) {
      data['oai'] = this.oai!.toJson();
    }
    data['ispr'] = this.ispr;
    data['ipr'] = this.ipr;
    data['ipm'] = this.ipm;
    data['cpb'] = this.cpb;
    return data;
  }
}

class Ris {
  String? id;
  String? rc;
  String? rt;
  int? adt;
  int? chd;
  String? mb;
  double? tp;
  Tfcs? tfcs;
  Tafcs? tafcs;
  List<Pis>? pis;
  List<String>? fcs;
  Radi? radi;
  String? op;
  Rexb? rexb;

  Ris({this.id, this.rc, this.rt, this.adt, this.chd, this.mb, this.tp, this.tfcs, this.tafcs, this.pis, this.fcs, this.radi, this.op, this.rexb});

  Ris.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    rc = json['rc'];
    rt = json['rt'];
    adt = json['adt'];
    chd = json['chd'];
    mb = json['mb'];
    tp = json['tp'];
    tfcs = json['tfcs'] != null ? new Tfcs.fromJson(json['tfcs']) : null;
    tafcs = json['tafcs'] != null ? new Tafcs.fromJson(json['tafcs']) : null;
    if (json['pis'] != null) {
      pis = <Pis>[];
      json['pis'].forEach((v) { pis!.add(new Pis.fromJson(v)); });
    }
    fcs = json['fcs']!= null ? json['fcs'].cast<String>() : null;
    radi = json['radi'] != null ? new Radi.fromJson(json['radi']) : null;
    op = json['op'];
    rexb = json['rexb'] != null ? new Rexb.fromJson(json['rexb']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['rc'] = this.rc;
    data['rt'] = this.rt;
    data['adt'] = this.adt;
    data['chd'] = this.chd;
    data['mb'] = this.mb;
    data['tp'] = this.tp;
    if (this.tfcs != null) {
      data['tfcs'] = this.tfcs!.toJson();
    }
    if (this.tafcs != null) {
      data['tafcs'] = this.tafcs!.toJson();
    }
    if (this.pis != null) {
      data['pis'] = this.pis!.map((v) => v.toJson()).toList();
    }
    data['fcs'] = this.fcs;
    if (this.radi != null) {
      data['radi'] = this.radi!.toJson();
    }
    data['op'] = this.op;
    if (this.rexb != null) {
      data['rexb'] = this.rexb!.toJson();
    }
    return data;
  }
}

class Tfcs {
  double? bF;
  double? nF;
  double? tF;
  double? cMU;
  double? tAF;

  Tfcs({this.bF, this.nF, this.tF, this.cMU, this.tAF});

  Tfcs.fromJson(Map<String, dynamic> json) {
    bF = json['BF'];
    nF = json['NF'];
    tF = json['TF'];
    cMU = json['CMU'];
    tAF = json['TAF'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['BF'] = this.bF;
    data['NF'] = this.nF;
    data['TF'] = this.tF;
    data['CMU'] = this.cMU;
    data['TAF'] = this.tAF;
    return data;
  }
}

class Tafcs {
  TAF? tAF;

  Tafcs({this.tAF});

  Tafcs.fromJson(Map<String, dynamic> json) {
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
  double? sAC;
  double? sBP;
  double? tTSF;
  double? sNP;
  double? tSF;
  double? sGP;
  int? ePF;
  double? mF;
  double? mFT;
  double? tMF;
  double? sRC;

  TAF({this.sAC, this.sBP, this.tTSF, this.sNP, this.tSF, this.sGP, this.ePF, this.mF, this.mFT, this.tMF, this.sRC});

  TAF.fromJson(Map<String, dynamic> json) {
    sAC = json['SAC'];
    sBP = json['SBP'];
    tTSF = json['TTSF'];
    sNP = json['SNP'];
    tSF = json['TSF'];
    sGP = json['SGP'];
    ePF = json['EPF'];
    mF = json['MF'];
    mFT = json['MFT'];
    tMF = json['TMF'];
    sRC = json['SRC'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['SAC'] = this.sAC;
    data['SBP'] = this.sBP;
    data['TTSF'] = this.tTSF;
    data['SNP'] = this.sNP;
    data['TSF'] = this.tSF;
    data['SGP'] = this.sGP;
    data['EPF'] = this.ePF;
    data['MF'] = this.mF;
    data['MFT'] = this.mFT;
    data['TMF'] = this.tMF;
    data['SRC'] = this.sRC;
    return data;
  }
}

class Pis {
  int? day;
  Tfcs? fc;
  Tafcs? afc;

  Pis({this.day, this.fc, this.afc});

  Pis.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    fc = json['fc'] != null ? new Tfcs.fromJson(json['fc']) : null;
    afc = json['afc'] != null ? new Tafcs.fromJson(json['afc']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['day'] = this.day;
    if (this.fc != null) {
      data['fc'] = this.fc!.toJson();
    }
    if (this.afc != null) {
      data['afc'] = this.afc!.toJson();
    }
    return data;
  }
}

class Radi {
  String? rid;

  Radi({this.rid});

  Radi.fromJson(Map<String, dynamic> json) {
    rid = json['rid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rid'] = this.rid;
    return data;
  }
}

class Rexb {
  List<BENEFIT>? bENEFIT;

  Rexb({this.bENEFIT});

  Rexb.fromJson(Map<String, dynamic> json) {
    if (json['BENEFIT'] != null) {
      bENEFIT = <BENEFIT>[];
      json['BENEFIT'].forEach((v) { bENEFIT!.add(new BENEFIT.fromJson(v)); });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.bENEFIT != null) {
      data['BENEFIT'] = this.bENEFIT!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BENEFIT {
  List<String>? values;

  BENEFIT({this.values});

  BENEFIT.fromJson(Map<String, dynamic> json) {
    values = json['values'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['values'] = this.values;
    return data;
  }
}

class Cnp {
  String? id;
  bool? ifra;
  List<Pd>? pd;

  Cnp({this.id, this.ifra, this.pd});

  Cnp.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ifra = json['ifra'];
    if (json['pd'] != null) {
      pd = <Pd>[];
      json['pd'].forEach((v) { pd!.add(new Pd.fromJson(v)); });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ifra'] = this.ifra;
    if (this.pd != null) {
      data['pd'] = this.pd!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Pd {
  String? fdt;
  String? tdt;
  double? am;

  Pd({this.fdt, this.tdt, this.am});

  Pd.fromJson(Map<String, dynamic> json) {
    fdt = json['fdt'];
    tdt = json['tdt'];
    am = json['am'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fdt'] = this.fdt;
    data['tdt'] = this.tdt;
    data['am'] = this.am;
    return data;
  }
}

class Oai {
  String? sid;

  Oai({this.sid});

  Oai.fromJson(Map<String, dynamic> json) {
    sid = json['sid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sid'] = this.sid;
    return data;
  }
}

class Alerts {
  String? type;
  String? message;

  Alerts({this.type, this.message});

  Alerts.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['message'] = this.message;
    return data;
  }
}

class Query {
  String? checkinDate;
  String? checkoutDate;
  List<RoomInfo>? roomInfo;
  SearchCriteria? searchCriteria;
  SearchPreferences? searchPreferences;
  String? searchId;
  bool? isSearchCompleted;
  CountryState? miscInfo;

  Query({this.checkinDate, this.checkoutDate, this.roomInfo, this.searchCriteria, this.searchPreferences, this.searchId, this.isSearchCompleted, this.miscInfo});

  Query.fromJson(Map<String, dynamic> json) {
    checkinDate = json['checkinDate'];
    checkoutDate = json['checkoutDate'];
    if (json['roomInfo'] != null) {
      roomInfo = <RoomInfo>[];
      json['roomInfo'].forEach((v) { roomInfo!.add(new RoomInfo.fromJson(v)); });
    }
    searchCriteria = json['searchCriteria'] != null ? new SearchCriteria.fromJson(json['searchCriteria']) : null;
    searchPreferences = json['searchPreferences'] != null ? new SearchPreferences.fromJson(json['searchPreferences']) : null;
    searchId = json['searchId'];
    isSearchCompleted = json['isSearchCompleted'];
    miscInfo = json['miscInfo'] != null ? new CountryState.fromJson(json['miscInfo']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['checkinDate'] = this.checkinDate;
    data['checkoutDate'] = this.checkoutDate;
    if (this.roomInfo != null) {
      data['roomInfo'] = this.roomInfo!.map((v) => v.toJson()).toList();
    }
    if (this.searchCriteria != null) {
      data['searchCriteria'] = this.searchCriteria!.toJson();
    }
    if (this.searchPreferences != null) {
      data['searchPreferences'] = this.searchPreferences!.toJson();
    }
    data['searchId'] = this.searchId;
    data['isSearchCompleted'] = this.isSearchCompleted;
    if (this.miscInfo != null) {
      data['miscInfo'] = this.miscInfo!.toJson();
    }
    return data;
  }
}

class RoomInfo {
  int? numberOfAdults;
  int? numberOfChild;
  List<int>? childAge;

  RoomInfo({this.numberOfAdults, this.numberOfChild, this.childAge});

  RoomInfo.fromJson(Map<String, dynamic> json) {
    numberOfAdults = json['numberOfAdults'];
    numberOfChild = json['numberOfChild'];
    childAge = json['childAge'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['numberOfAdults'] = this.numberOfAdults;
    data['numberOfChild'] = this.numberOfChild;
    data['childAge'] = this.childAge;
    return data;
  }
}

class SearchCriteria {
  String? city;
  String? countryName;
  String? cityName;
  String? nationality;

  SearchCriteria({this.city, this.countryName, this.cityName, this.nationality});

  SearchCriteria.fromJson(Map<String, dynamic> json) {
    city = json['city'];
    countryName = json['countryName'];
    cityName = json['cityName'];
    nationality = json['nationality'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['city'] = this.city;
    data['countryName'] = this.countryName;
    data['cityName'] = this.cityName;
    data['nationality'] = this.nationality;
    return data;
  }
}

class SearchPreferences {
  List<int>? ratings;
  String? currency;
  bool? fsc;

  SearchPreferences({this.ratings, this.currency, this.fsc});

  SearchPreferences.fromJson(Map<String, dynamic> json) {
    ratings = json['ratings'].cast<int>();
    currency = json['currency'];
    fsc = json['fsc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ratings'] = this.ratings;
    data['currency'] = this.currency;
    data['fsc'] = this.fsc;
    return data;
  }
}

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

class Errors {
  String? errCode;
  String? message;

  Errors({this.errCode, this.message});

  Errors.fromJson(Map<String, dynamic> json) {
    errCode = json['errCode'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['errCode'] = this.errCode;
    data['message'] = this.message;
    return data;
  }
}






