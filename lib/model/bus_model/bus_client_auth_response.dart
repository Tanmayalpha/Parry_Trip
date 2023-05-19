// To parse this JSON data, do
//
//     final busClientAuthResponse = busClientAuthResponseFromJson(jsonString);

import 'dart:convert';

BusClientAuthResponse busClientAuthResponseFromJson(String str) => BusClientAuthResponse.fromJson(json.decode(str));

String busClientAuthResponseToJson(BusClientAuthResponse data) => json.encode(data.toJson());

class BusClientAuthResponse {
  int? status;
  String? tokenId;
  Error? error;
  Member? member;

  BusClientAuthResponse({
    this.status,
    this.tokenId,
    this.error,
    this.member,
  });

  factory BusClientAuthResponse.fromJson(Map<String, dynamic> json) => BusClientAuthResponse(
    status: json["Status"],
    tokenId: json["TokenId"],
    error: Error.fromJson(json["Error"]),
    member: Member.fromJson(json["Member"]),
  );

  Map<String, dynamic> toJson() => {
    "Status": status,
    "TokenId": tokenId,
    "Error": error!.toJson(),
    "Member": member!.toJson(),
  };
}

class Error {
  int? errorCode;
  String? errorMessage;

  Error({
    this.errorCode,
    this.errorMessage,
  });

  factory Error.fromJson(Map<String, dynamic> json) => Error(
    errorCode: json["ErrorCode"],
    errorMessage: json["ErrorMessage"],
  );

  Map<String, dynamic> toJson() => {
    "ErrorCode": errorCode,
    "ErrorMessage": errorMessage,
  };
}

class Member {
  String? firstName;
  String? lastName;
  String? email;
  int? memberId;
  int? agencyId;
  String? loginName;
  String? loginDetails;
  bool? isPrimaryAgent;

  Member({
    this.firstName,
    this.lastName,
    this.email,
    this.memberId,
    this.agencyId,
    this.loginName,
    this.loginDetails,
    this.isPrimaryAgent,
  });

  factory Member.fromJson(Map<String, dynamic> json) => Member(
    firstName: json["FirstName"],
    lastName: json["LastName"],
    email: json["Email"],
    memberId: json["MemberId"],
    agencyId: json["AgencyId"],
    loginName: json["LoginName"],
    loginDetails: json["LoginDetails"],
    isPrimaryAgent: json["isPrimaryAgent"],
  );

  Map<String, dynamic> toJson() => {
    "FirstName": firstName,
    "LastName": lastName,
    "Email": email,
    "MemberId": memberId,
    "AgencyId": agencyId,
    "LoginName": loginName,
    "LoginDetails": loginDetails,
    "isPrimaryAgent": isPrimaryAgent,
  };
}
