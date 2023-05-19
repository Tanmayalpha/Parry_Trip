import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:parry_trip2/constants/constant.dart';
import 'package:parry_trip2/model/hotel_details_response.dart';
import 'package:parry_trip2/model/hotel_search_list_data.dart';

import '../screens/HomeScreen/Destination/hotel_list_View.dart';

class Api {
  List<His> hotels = [];
  List<Ops> rooms = [];
  bool isLoading = false;
  HotelSearchListData? hotelSearchListData;

  HotelDetailsResponse? hotelDetailsResponse;



  getHotelDetail(String idD) async {
    var headers = {
      'Content-Type': 'application/json',
      'apikey': '812146ac5e380f-ed6f-4a76-a035-314f4255eddb'
    };
    var request = http.Request(
        'POST', Uri.parse('${flightUrl}hms/v1/hotelDetail-search'));
    request.body = json.encode({"id": idD});
    request.headers.addAll(headers);
    print('${request.body}');
    http.StreamedResponse response = await request.send();
    print('${response.statusCode}________status');

    if (response.statusCode == 200) {
      var finalResult = await response.stream.bytesToString();

      final jsonResponse =
          HotelDetailsResponse.fromJson(json.decode(finalResult));

      hotelDetailsResponse = jsonResponse;

      print('${hotelDetailsResponse?.status?.success}________status');
      print('${hotelDetailsResponse?.hotel?.gl?.lt}________lat');
      rooms = hotelDetailsResponse?.hotel?.ops ?? [];
    } else {
      print(response.reasonPhrase);
    }
  }
}
