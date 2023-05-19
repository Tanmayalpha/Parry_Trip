/// searchIds : ["hsid2987581535"]
/// status : {"success":true,"httpStatus":200}

class SearchedHotel {
  SearchedHotel({
      List<String>? searchIds, 
      Status? status,}){
    _searchIds = searchIds;
    _status = status;
}

  SearchedHotel.fromJson(dynamic json) {
    _searchIds = json['searchIds'] != null ? json['searchIds'].cast<String>() : [];
    _status = json['status'] != null ? Status.fromJson(json['status']) : null;
  }
  List<String>? _searchIds;
  Status? _status;
SearchedHotel copyWith({  List<String>? searchIds,
  Status? status,
}) => SearchedHotel(  searchIds: searchIds ?? _searchIds,
  status: status ?? _status,
);
  List<String>? get searchIds => _searchIds;
  Status? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['searchIds'] = _searchIds;
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