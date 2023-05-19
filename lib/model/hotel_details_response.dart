class HotelDetailsResponse {
  String? id;
  Hotel? hotel;
  SearchQuery? searchQuery;
  Status? status;

  HotelDetailsResponse({this.id, this.hotel, this.searchQuery, this.status});

  HotelDetailsResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    hotel = json['hotel'] != null ?  Hotel.fromJson(json['hotel']) : null;
    searchQuery = json['searchQuery'] != null ? new SearchQuery.fromJson(json['searchQuery']) : null;
    status = json['status'] != null ? new Status.fromJson(json['status']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['id'] = this.id;
    if (this.hotel != null) {
      data['hotel'] = this.hotel!.toJson();
    }
    if (this.searchQuery != null) {
      data['searchQuery'] = this.searchQuery!.toJson();
    }
    if (this.status != null) {
      data['status'] = this.status!.toJson();
    }
    return data;
  }
}

class Hotel {
  String? id;
  String? name;
  List<Img>? img;
  String? des;
  int? rt;
  Gl? gl;
  Ad? ad;
  List<String>? fl;
  String? pt;
  Statecnt? cnt;
  List<Ops>? ops;
  List<Pops>? pops;
  String? uid;

  Hotel({this.id, this.name, this.img, this.des, this.rt, this.gl, this.ad, this.fl, this.pt, this.cnt, this.ops, this.pops, this.uid});

  Hotel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    if (json['img'] != null) {
      img = <Img>[];
      json['img'].forEach((v) { img!.add(new Img.fromJson(v)); });
    }
    des = json['des'];
    rt = json['rt'];
    gl = json['gl'] != null ?  Gl.fromJson(json['gl']) : null;
    ad = json['ad'] != null ?  Ad.fromJson(json['ad']) : null;
    fl = json['fl'].cast<String>();
    pt = json['pt'];
    cnt = json['cnt'] != null ?  Statecnt.fromJson(json['cnt']) : null;
    if (json['ops'] != null) {
      ops = <Ops>[];
      json['ops'].forEach((v) { ops!.add( Ops.fromJson(v)); });
    }
    if (json['pops'] != null) {
      pops = <Pops>[];
      json['pops'].forEach((v) { pops!.add( Pops.fromJson(v)); });
    }
    uid = json['uid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.img != null) {
      data['img'] = this.img!.map((v) => v.toJson()).toList();
    }
    data['des'] = this.des;
    data['rt'] = this.rt;
    if (this.gl != null) {
      data['gl'] = this.gl!.toJson();
    }
    if (this.ad != null) {
      data['ad'] = this.ad!.toJson();
    }
    data['fl'] = this.fl;
    data['pt'] = this.pt;
    if (this.cnt != null) {
      data['cnt'] = this.cnt!.toJson();
    }
    if (this.ops != null) {
      data['ops'] = this.ops!.map((v) => v.toJson()).toList();
    }
    if (this.pops != null) {
      data['pops'] = this.pops!.map((v) => v.toJson()).toList();
    }
    data['uid'] = this.uid;
    return data;
  }
}

class Img {
  String? tns;
  String? url;

  Img({this.tns, this.url});

  Img.fromJson(Map<String, dynamic> json) {
    tns = json['tns'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tns'] = this.tns;
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
  City? city;
  Statecnt? state;
  City? country;
  String? ctn;
  String? cn;

  Ad({this.adr, this.city, this.state, this.country, this.ctn, this.cn});

  Ad.fromJson(Map<String, dynamic> json) {
    adr = json['adr'];
    city = json['city'] != null ?  City.fromJson(json['city']) : null;
    state = json['state'] != null ?  Statecnt.fromJson(json['state']) : null;
    country = json['country'] != null ?  City.fromJson(json['country']) : null;
    ctn = json['ctn'];
    cn = json['cn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['adr'] = this.adr;
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

class Statecnt {


  Statecnt();

  Statecnt.fromJson(Map<String, dynamic> json) {
}

Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  return data;
}
}

class Ops {
  List<RoomFullInfo>? ris;
  String? id;
  double? tp;
  Oai? oai;
  bool? iopr;
  bool? ipr;
  bool? ipm;
  int? cpb;
  bool? isSelected ;



  Ops({this.ris, this.id, this.tp, this.oai, this.iopr, this.ipr, this.ipm, this.cpb,this.isSelected });

  Ops.fromJson(Map<String, dynamic> json) {
    if (json['ris'] != null) {
      ris = <RoomFullInfo>[];
      json['ris'].forEach((v) { ris!.add( RoomFullInfo.fromJson(v)); });
    }
    id = json['id'];
    tp = json['tp'];
    oai = json['oai'] != null ?  Oai.fromJson(json['oai']) : null;
    iopr = json['iopr'];
    ipr = json['ipr'];
    ipm = json['ipm'];
    cpb = json['cpb'];
    isSelected = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    if (this.ris != null) {
      data['ris'] = this.ris!.map((v) => v.toJson()).toList();
    }
    data['id'] = id;
    data['tp'] = tp;
    if (oai != null) {
      data['oai'] = oai!.toJson();
    }
    data['iopr'] = this.iopr;
    data['ipr'] = this.ipr;
    data['ipm'] = this.ipm;
    data['cpb'] = this.cpb;
    return data;
  }
}

class RoomFullInfo {
  String? des;

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
  List<Imgs>? imgs;
  List<String>? fcs;

  RoomFullInfo({this.id, this.rc, this.rt, this.adt, this.chd, this.mb, this.tp, this.tfcs, this.tafcs, this.pis, this.des,this.fcs });

  RoomFullInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    rc = json['rc'];
    rt = json['rt'];
    adt = json['adt'];
    chd = json['chd'];
    mb = json['mb'];
    tp = json['tp'];
    des = json['des'];
    tfcs = json['tfcs'] != null ?  Tfcs.fromJson(json['tfcs']) : null;
    tafcs = json['tafcs'] != null ?  Tafcs.fromJson(json['tafcs']) : null;
    fcs = json['fcs']!= null ? json['fcs'].cast<String>() : null;
    if (json['pis'] != null) {
      pis = <Pis>[];
      json['pis'].forEach((v) { pis!.add(new Pis.fromJson(v)); });
    }
    if (json['imgs'] != null) {
      imgs = <Imgs>[];
      json['imgs'].forEach((v) { imgs!.add( Imgs.fromJson(v)); });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['id'] = this.id;
    data['rc'] = this.rc;
    data['rt'] = this.rt;
    data['adt'] = this.adt;
    data['chd'] = this.chd;
    data['mb'] = this.mb;
    data['tp'] = this.tp;
    data['des'] = this.des;
    data['fcs'] = this.fcs;
    if (this.tfcs != null) {
      data['tfcs'] = this.tfcs!.toJson();
    }
    if (this.tafcs != null) {
      data['tafcs'] = this.tafcs!.toJson();
    }
    if (this.pis != null) {
      data['pis'] = this.pis!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Tfcs {
  double? tF;
  double? tAF;
  double? bF;
  double? nF;

  Tfcs({this.tF, this.tAF, this.bF, this.nF});

  Tfcs.fromJson(Map<String, dynamic> json) {
    tF = json['TF'];
    tAF = json['TAF'];
    bF = json['BF'];
    nF = json['NF'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['TF'] = this.tF;
    data['TAF'] = this.tAF;
    data['BF'] = this.bF;
    data['NF'] = this.nF;
    return data;
  }
}

class Tafcs {
  TAF? tAF;

  Tafcs({this.tAF});

  Tafcs.fromJson(Map<String, dynamic> json) {
    tAF = json['TAF'] != null ?  TAF.fromJson(json['TAF']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    if (this.tAF != null) {
      data['TAF'] = this.tAF!.toJson();
    }
    return data;
  }
}

class TAF {
  double? sGP;
  double? sNP;
  double? sBP;
  double? mF;
  double? mFT;

  TAF({this.sGP, this.sNP, this.sBP, this.mF, this.mFT});

  TAF.fromJson(Map<String, dynamic> json) {
    sGP = json['SGP'];
    sNP = json['SNP'];
    sBP = json['SBP'];
    mF = json['MF'];
    mFT = json['MFT'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['SGP'] = this.sGP;
    data['SNP'] = this.sNP;
    data['SBP'] = this.sBP;
    data['MF'] = this.mF;
    data['MFT'] = this.mFT;
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
class Imgs {
  String? url;
  String? sz;
  List<dynamic>? rids;

  Imgs({this.url, this.sz,this.rids});

  Imgs.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    sz = json['sz'];
    rids = json['rids'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['sz'] = this.sz;
    data['rids'] = this.rids;

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

class Pops {
  List<String>? fc;
  double? tpc;

  Pops({this.fc, this.tpc});

  Pops.fromJson(Map<String, dynamic> json) {
    fc = json['fc'].cast<String>();
    tpc = json['tpc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fc'] = this.fc;
    data['tpc'] = this.tpc;
    return data;
  }
}

class SearchQuery {
  String? checkinDate;
  String? checkoutDate;
  List<RoomInfo>? roomInfo;
  SearchCriteria? searchCriteria;
  SearchPreferences? searchPreferences;
  String? searchId;
  bool? isSearchCompleted;
  Statecnt? miscInfo;

  SearchQuery({this.checkinDate, this.checkoutDate, this.roomInfo, this.searchCriteria, this.searchPreferences, this.searchId, this.isSearchCompleted, this.miscInfo});

  SearchQuery.fromJson(Map<String, dynamic> json) {
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
    miscInfo = json['miscInfo'] != null ?  Statecnt.fromJson(json['miscInfo']) : null;
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

  RoomInfo({this.numberOfAdults, this.numberOfChild,});

  RoomInfo.fromJson(Map<String, dynamic> json) {
    numberOfAdults = json['numberOfAdults'];
    numberOfChild = json['numberOfChild'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['numberOfAdults'] = this.numberOfAdults;
    data['numberOfChild'] = this.numberOfChild;

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






