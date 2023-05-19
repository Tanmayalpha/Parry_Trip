/// searchResult : {"his":[{"id":"hsid7874557141-16243475","name":"Raga Residency","img":[{"url":"https://i.travelapi.com/hotels/41000000/40200000/40195100/40195014/25266aef_b.jpg"}],"rt":3,"gl":{"ln":"76.50134","lt":"9.171216"},"ad":{"adr":"Puthiyidom Park Junction Road","adr2":"Opposite Govt. Girls' High School","postalCode":"690502","city":{"name":"Karthikappally"},"state":{"code":"KL","name":"Kerala"},"country":{"code":"IN","name":"India"},"ctn":"Karthikappally","cn":"India"},"pt":"HOTEL","pops":[{"fc":["ROOM ONLY"],"tpc":1894.91}],"uid":"16243475","lhc":"101821"}],"size":1}
/// status : {"success":true,"httpStatus":200}

class HotelSearchListData {
  HotelSearchListData({
      SearchResult? searchResult, 
      Status? status,}){
    _searchResult = searchResult;
    _status = status;
}

  HotelSearchListData.fromJson(dynamic json) {
    _searchResult = json['searchResult'] != null ? SearchResult.fromJson(json['searchResult']) : null;
    _status = json['status'] != null ? Status.fromJson(json['status']) : null;
  }
  SearchResult? _searchResult;
  Status? _status;
HotelSearchListData copyWith({  SearchResult? searchResult,
  Status? status,
}) => HotelSearchListData(  searchResult: searchResult ?? _searchResult,
  status: status ?? _status,
);
  SearchResult? get searchResult => _searchResult;
  Status? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_searchResult != null) {
      map['searchResult'] = _searchResult?.toJson();
    }
    if (_status != null) {
      map['status'] = _status?.toJson();
    }
    return map;
  }

}

/// success : true
/// httpStatus : 200

class Status {
  Status({
      bool? success, 
      num? httpStatus,}){
    _success = success;
    _httpStatus = httpStatus;
}

  Status.fromJson(dynamic json) {
    _success = json['success'];
    _httpStatus = json['httpStatus'];
  }
  bool? _success;
  num? _httpStatus;
Status copyWith({  bool? success,
  num? httpStatus,
}) => Status(  success: success ?? _success,
  httpStatus: httpStatus ?? _httpStatus,
);
  bool? get success => _success;
  num? get httpStatus => _httpStatus;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    map['httpStatus'] = _httpStatus;
    return map;
  }

}

/// his : [{"id":"hsid7874557141-16243475","name":"Raga Residency","img":[{"url":"https://i.travelapi.com/hotels/41000000/40200000/40195100/40195014/25266aef_b.jpg"}],"rt":3,"gl":{"ln":"76.50134","lt":"9.171216"},"ad":{"adr":"Puthiyidom Park Junction Road","adr2":"Opposite Govt. Girls' High School","postalCode":"690502","city":{"name":"Karthikappally"},"state":{"code":"KL","name":"Kerala"},"country":{"code":"IN","name":"India"},"ctn":"Karthikappally","cn":"India"},"pt":"HOTEL","pops":[{"fc":["ROOM ONLY"],"tpc":1894.91}],"uid":"16243475","lhc":"101821"}]
/// size : 1

class SearchResult {
  SearchResult({
      List<His>? his, 
      num? size,}){
    _his = his;
    _size = size;
}

  SearchResult.fromJson(dynamic json) {
    if (json['his'] != null) {
      _his = [];
      json['his'].forEach((v) {
        _his?.add(His.fromJson(v));
      });
    }
    _size = json['size'];
  }
  List<His>? _his;
  num? _size;
SearchResult copyWith({  List<His>? his,
  num? size,
}) => SearchResult(  his: his ?? _his,
  size: size ?? _size,
);
  List<His>? get his => _his;
  num? get size => _size;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_his != null) {
      map['his'] = _his?.map((v) => v.toJson()).toList();
    }
    map['size'] = _size;
    return map;
  }

}

/// id : "hsid7874557141-16243475"
/// name : "Raga Residency"
/// img : [{"url":"https://i.travelapi.com/hotels/41000000/40200000/40195100/40195014/25266aef_b.jpg"}]
/// rt : 3
/// gl : {"ln":"76.50134","lt":"9.171216"}
/// ad : {"adr":"Puthiyidom Park Junction Road","adr2":"Opposite Govt. Girls' High School","postalCode":"690502","city":{"name":"Karthikappally"},"state":{"code":"KL","name":"Kerala"},"country":{"code":"IN","name":"India"},"ctn":"Karthikappally","cn":"India"}
/// pt : "HOTEL"
/// pops : [{"fc":["ROOM ONLY"],"tpc":1894.91}]
/// uid : "16243475"
/// lhc : "101821"

class His {
  His({
      String? id, 
      String? name, 
      List<Img>? img, 
      num? rt, 
      Gl? gl, 
      Ad? ad, 
      String? pt, 
      List<Pops>? pops, 
      String? uid, 
      String? lhc,}){
    _id = id;
    _name = name;
    _img = img;
    _rt = rt;
    _gl = gl;
    _ad = ad;
    _pt = pt;
    _pops = pops;
    _uid = uid;
    _lhc = lhc;
}

  His.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    if (json['img'] != null) {
      _img = [];
      json['img'].forEach((v) {
        _img?.add(Img.fromJson(v));
      });
    }
    _rt = json['rt'];
    _gl = json['gl'] != null ? Gl.fromJson(json['gl']) : null;
    _ad = json['ad'] != null ? Ad.fromJson(json['ad']) : null;
    _pt = json['pt'];
    if (json['pops'] != null) {
      _pops = [];
      json['pops'].forEach((v) {
        _pops?.add(Pops.fromJson(v));
      });
    }
    _uid = json['uid'];
    _lhc = json['lhc'];
  }
  String? _id;
  String? _name;
  List<Img>? _img;
  num? _rt;
  Gl? _gl;
  Ad? _ad;
  String? _pt;
  List<Pops>? _pops;
  String? _uid;
  String? _lhc;
His copyWith({  String? id,
  String? name,
  List<Img>? img,
  num? rt,
  Gl? gl,
  Ad? ad,
  String? pt,
  List<Pops>? pops,
  String? uid,
  String? lhc,
}) => His(  id: id ?? _id,
  name: name ?? _name,
  img: img ?? _img,
  rt: rt ?? _rt,
  gl: gl ?? _gl,
  ad: ad ?? _ad,
  pt: pt ?? _pt,
  pops: pops ?? _pops,
  uid: uid ?? _uid,
  lhc: lhc ?? _lhc,
);
  String? get id => _id;
  String? get name => _name;
  List<Img>? get img => _img;
  num? get rt => _rt;
  Gl? get gl => _gl;
  Ad? get ad => _ad;
  String? get pt => _pt;
  List<Pops>? get pops => _pops;
  String? get uid => _uid;
  String? get lhc => _lhc;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    if (_img != null) {
      map['img'] = _img?.map((v) => v.toJson()).toList();
    }
    map['rt'] = _rt;
    if (_gl != null) {
      map['gl'] = _gl?.toJson();
    }
    if (_ad != null) {
      map['ad'] = _ad?.toJson();
    }
    map['pt'] = _pt;
    if (_pops != null) {
      map['pops'] = _pops?.map((v) => v.toJson()).toList();
    }
    map['uid'] = _uid;
    map['lhc'] = _lhc;
    return map;
  }

}

/// fc : ["ROOM ONLY"]
/// tpc : 1894.91

class Pops {
  Pops({
      List<String>? fc, 
      num? tpc,}){
    _fc = fc;
    _tpc = tpc;
}

  Pops.fromJson(dynamic json) {
    _fc = json['fc'] != null ? json['fc'].cast<String>() : [];
    _tpc = json['tpc'];
  }
  List<String>? _fc;
  num? _tpc;
Pops copyWith({  List<String>? fc,
  num? tpc,
}) => Pops(  fc: fc ?? _fc,
  tpc: tpc ?? _tpc,
);
  List<String>? get fc => _fc;
  num? get tpc => _tpc;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['fc'] = _fc;
    map['tpc'] = _tpc;
    return map;
  }

}

/// adr : "Puthiyidom Park Junction Road"
/// adr2 : "Opposite Govt. Girls' High School"
/// postalCode : "690502"
/// city : {"name":"Karthikappally"}
/// state : {"code":"KL","name":"Kerala"}
/// country : {"code":"IN","name":"India"}
/// ctn : "Karthikappally"
/// cn : "India"

class Ad {
  Ad({
      String? adr, 
      String? adr2, 
      String? postalCode, 
      City? city, 
      CityNameState? state,
      Country? country, 
      String? ctn, 
      String? cn,}){
    _adr = adr;
    _adr2 = adr2;
    _postalCode = postalCode;
    _city = city;
    _state = state;
    _country = country;
    _ctn = ctn;
    _cn = cn;
}

  Ad.fromJson(dynamic json) {
    _adr = json['adr'];
    _adr2 = json['adr2'];
    _postalCode = json['postalCode'];
    _city = json['city'] != null ? City.fromJson(json['city']) : null;
    _state = json['state'] != null ? CityNameState.fromJson(json['state']) : null;
    _country = json['country'] != null ? Country.fromJson(json['country']) : null;
    _ctn = json['ctn'];
    _cn = json['cn'];
  }
  String? _adr;
  String? _adr2;
  String? _postalCode;
  City? _city;
  CityNameState? _state;
  Country? _country;
  String? _ctn;
  String? _cn;
Ad copyWith({  String? adr,
  String? adr2,
  String? postalCode,
  City? city,
  CityNameState? state,
  Country? country,
  String? ctn,
  String? cn,
}) => Ad(  adr: adr ?? _adr,
  adr2: adr2 ?? _adr2,
  postalCode: postalCode ?? _postalCode,
  city: city ?? _city,
  state: state ?? _state,
  country: country ?? _country,
  ctn: ctn ?? _ctn,
  cn: cn ?? _cn,
);
  String? get adr => _adr;
  String? get adr2 => _adr2;
  String? get postalCode => _postalCode;
  City? get city => _city;
  CityNameState? get state => _state;
  Country? get country => _country;
  String? get ctn => _ctn;
  String? get cn => _cn;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['adr'] = _adr;
    map['adr2'] = _adr2;
    map['postalCode'] = _postalCode;
    if (_city != null) {
      map['city'] = _city?.toJson();
    }
    if (_state != null) {
      map['state'] = _state?.toJson();
    }
    if (_country != null) {
      map['country'] = _country?.toJson();
    }
    map['ctn'] = _ctn;
    map['cn'] = _cn;
    return map;
  }

}

/// code : "IN"
/// name : "India"

class Country {
  Country({
      String? code, 
      String? name,}){
    _code = code;
    _name = name;
}

  Country.fromJson(dynamic json) {
    _code = json['code'];
    _name = json['name'];
  }
  String? _code;
  String? _name;
Country copyWith({  String? code,
  String? name,
}) => Country(  code: code ?? _code,
  name: name ?? _name,
);
  String? get code => _code;
  String? get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _code;
    map['name'] = _name;
    return map;
  }

}

/// code : "KL"
/// name : "Kerala"

class CityNameState {
  CityNameState({
      String? code, 
      String? name,}){
    _code = code;
    _name = name;
}

  CityNameState.fromJson(dynamic json) {
    _code = json['code'];
    _name = json['name'];
  }
  String? _code;
  String? _name;
CityNameState copyWith({  String? code,
  String? name,
}) => CityNameState(  code: code ?? _code,
  name: name ?? _name,
);
  String? get code => _code;
  String? get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _code;
    map['name'] = _name;
    return map;
  }

}

/// name : "Karthikappally"

class City {
  City({
      String? name,}){
    _name = name;
}

  City.fromJson(dynamic json) {
    _name = json['name'];
  }
  String? _name;
City copyWith({  String? name,
}) => City(  name: name ?? _name,
);
  String? get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    return map;
  }

}

/// ln : "76.50134"
/// lt : "9.171216"

class Gl {
  Gl({
      String? ln, 
      String? lt,}){
    _ln = ln;
    _lt = lt;
}

  Gl.fromJson(dynamic json) {
    _ln = json['ln'];
    _lt = json['lt'];
  }
  String? _ln;
  String? _lt;
Gl copyWith({  String? ln,
  String? lt,
}) => Gl(  ln: ln ?? _ln,
  lt: lt ?? _lt,
);
  String? get ln => _ln;
  String? get lt => _lt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ln'] = _ln;
    map['lt'] = _lt;
    return map;
  }

}

/// url : "https://i.travelapi.com/hotels/41000000/40200000/40195100/40195014/25266aef_b.jpg"

class Img {
  Img({
      String? url,}){
    _url = url;
}

  Img.fromJson(dynamic json) {
    _url = json['url'];
  }
  String? _url;
Img copyWith({  String? url,
}) => Img(  url: url ?? _url,
);
  String? get url => _url;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['url'] = _url;
    return map;
  }

}