import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:parry_trip2/constants/common.dart';

import 'constant.dart';

String token = """""";
String busToken = "";
String resultIndex = "";
String trackId = "";

class ApiBaseHelper {
  Future<dynamic> postAPICall(Uri url, var param) async {
    var responseJson;
    await App.init();
    try {
      if (App.localStorage.getString("token") != null) {
        token = App.localStorage.getString("token")!;
      }
      print("API : $url \n parameter : $param   \n ");
      final response = await post(url, body: param, headers: {
        'Accept': 'application/json',
        'authorization': 'Bearer ${token}'
      }).timeout(Duration(seconds: timeOut));
      print(
          "API : $url \n parameter : $param   \n response:  ${response.body.toString()}yuj ");
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('getTranslated(context, "NO_INTERNET")!');
    } on TimeoutException {
      throw FetchDataException('Something went wrong, try again later');
    }
    return responseJson;
  }

  Future<dynamic> getAPICall(
    Uri url,
  ) async {
    var responseJson;
    await App.init();
    try {
      print("API : $url \n    ");
      if (App.localStorage.getString("token") != null) {
        token = App.localStorage.getString("token")!;
      }
      final response = await get(url, headers: {
        'Accept': 'application/json',
        'authorization': 'Bearer ${token}'
      }).timeout(Duration(seconds: timeOut));
      print("API : $url    \n response:  ${response.body.toString()}yuj ");
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('getTranslated(context, "NO_INTERNET")!');
    } on TimeoutException {
      throw FetchDataException('Something went wrong, try again later');
    }
    return responseJson;
  }

  dynamic _response(Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        return responseJson;
      case 400:
        var responseJson = json.decode(response.body.toString());
        return responseJson;
      case 401:
      case 403:
        var responseJson = json.decode(response.body.toString());
        return responseJson;
      case 500:
      default:
        var responseJson = json.decode(response.body.toString());
        return responseJson;
    }
  }
}

class CustomException implements Exception {
  final _message;
  final _prefix;
  CustomException([this._message, this._prefix]);
  String toString() {
    return "$_prefix$_message";
  }
}

class FetchDataException extends CustomException {
  FetchDataException([message])
      : super(message, "Error During Communication: ");
}

class BadRequestException extends CustomException {
  BadRequestException([message]) : super(message, "Invalid Request: ");
}

class UnauthorisedException extends CustomException {
  UnauthorisedException([message]) : super(message, "Unauthorised: ");
}

class InvalidInputException extends CustomException {
  InvalidInputException([message]) : super(message, "Invalid Input: ");
}
