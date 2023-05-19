import 'package:flutter/cupertino.dart';

class PassengerModel {
  String? title;
  String? fName;
  String? lName;
  TextEditingController dob;
  String? type;
  bool dobM;
  PassengerModel(
      {this.title,
      this.fName,
      this.lName,
      required this.dob,
      this.type,
      this.dobM = false});
}

class ServiceModel {
  String? type;
  String? descM, descB;
  double? amountM, amountB;

  ServiceModel({this.type, this.descM, this.descB, this.amountM, this.amountB});
}
