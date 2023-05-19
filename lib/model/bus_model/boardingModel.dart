class BoardingModel {
  String? cityPointAddress;
  String? cityPointContactNumber;
  int? cityPointIndex;
  String? cityPointLandmark;
  String? cityPointLocation;
  String? cityPointName;
  String? cityPointTime;

  BoardingModel(
      {this.cityPointAddress,
      this.cityPointContactNumber,
      this.cityPointIndex,
      this.cityPointLandmark,
      this.cityPointLocation,
      this.cityPointName,
      this.cityPointTime});

  BoardingModel.fromJson(Map<String, dynamic> json) {
    cityPointAddress = json['CityPointAddress'] ?? "";
    cityPointContactNumber = json['CityPointContactNumber'] ?? "";
    cityPointIndex = json['CityPointIndex'];
    cityPointLandmark = json['CityPointLandmark'] ?? "";
    cityPointLocation = json['CityPointLocation'] ?? "";
    cityPointName = json['CityPointName'] ?? "";
    cityPointTime = json['CityPointTime'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CityPointAddress'] = this.cityPointAddress;
    data['CityPointContactNumber'] = this.cityPointContactNumber;
    data['CityPointIndex'] = this.cityPointIndex;
    data['CityPointLandmark'] = this.cityPointLandmark;
    data['CityPointLocation'] = this.cityPointLocation;
    data['CityPointName'] = this.cityPointName;
    data['CityPointTime'] = this.cityPointTime;
    return data;
  }
}
