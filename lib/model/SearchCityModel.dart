/// data : [{"id":"AGX","title":"Agatti Arodromee"},{"id":"AKD","title":"Akola Airport"},{"id":"IXV","title":"Along Airport"},{"id":"LKO","title":"Amausi Arpt"},{"id":"IXE","title":"Bajpe Arpt"},{"id":"RGH","title":"Balurghat Airport"},{"id":"IXD","title":"Bamrauli Arpt"},{"id":"BAN","title":"Basongo Airport"},{"id":"BEP","title":"Bellary Airport"},{"id":"BLR","title":"Bengaluru Intl Arpt"},{"id":"BUP","title":"Bhatinda Air Force Station"},{"id":"BHU","title":"Bhavnagar Arpt"},{"id":"PAB","title":"Bilaspur Airport"},{"id":"IXR","title":"Birsa Munda Arpt"},{"id":"CBD","title":"Car Nicobar Air Force Base"},{"id":"IXC","title":"Chandigarh Arpt"},{"id":"MAA","title":"Chennai Arpt"},{"id":"BOM","title":"Chhatrapati Shivaji"},{"id":"IXU","title":"Chikkalthana Arpt"},{"id":"COH","title":"Cooch Behar Airport"}]
/// status : 1

class SearchCityModel {
  SearchCityModel({
      List<Data>? data, 
      num? status,}){
    _data = data;
    _status = status;
}

  SearchCityModel.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
    _status = json['status'];
  }
  List<Data>? _data;
  num? _status;
SearchCityModel copyWith({  List<Data>? data,
  num? status,
}) => SearchCityModel(  data: data ?? _data,
  status: status ?? _status,
);
  List<Data>? get data => _data;
  num? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    map['status'] = _status;
    return map;
  }

}

/// id : "AGX"
/// title : "Agatti Arodromee"

class Data {
  Data({
      String? id, 
      String? title,}){
    _id = id;
    _title = title;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
  }
  String? _id;
  String? _title;
Data copyWith({  String? id,
  String? title,
}) => Data(  id: id ?? _id,
  title: title ?? _title,
);
  String? get id => _id;
  String? get title => _title;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    return map;
  }

}