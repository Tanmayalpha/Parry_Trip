import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:parry_trip2/constants/ApiBaseHelper.dart';
import 'package:parry_trip2/constants/app_colors.dart';
import 'package:http/http.dart' as http;
import 'package:parry_trip2/model/bus_model/bus_city_list_response.dart';


class SearchCityScreen extends StatefulWidget {
  const SearchCityScreen({Key? key, required this.isFrom}) : super(key: key);

 final bool isFrom;


  @override
  State<SearchCityScreen> createState() => _SearchCityScreenState();
}

class _SearchCityScreenState extends State<SearchCityScreen> {
  final fromController = TextEditingController();
  final toController = TextEditingController();
  bool isLoading = false ;
   List <BusCity> busCity = [] ;

   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getBusCityList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:AppBar(
          backgroundColor: colors.activeColor,
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back, color: Colors.white,),),
          title: const Text("Location", style: TextStyle(color: Colors.white),),
        ),
      body: Container(
          padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(child: Column(children: [
          TextFormField(
            onChanged: (vlaue){
              //getSuggestions(vlaue);
              searchProduct(vlaue) ;
            },
            controller: widget.isFrom ? fromController : toController,
            decoration: InputDecoration(
                hintText: widget.isFrom ? 'From' : 'To'
            ),
          ),
          const SizedBox(height: 20,),
          isLoading ? const Center(child: CircularProgressIndicator(),):
              busCity.isEmpty ? const Text('City not available') :
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount:busCity.length < 150 ? busCity.length :150,
            itemBuilder: (context, index) {
            return InkWell(onTap: (){
              Navigator.pop(context, [busCity[index], widget.isFrom ? true : false]);
            },
              child: ListTile(
                trailing: const Icon(Icons.location_on),
                title: Text(busCity[index].cityName ?? ''),),
            );
          },)
        ],),),
      ),
    );
  }

  Future<void> getBusCityList() async{
    isLoading = true ;
    setState(() {

    });
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse('http://api.tektravels.com/SharedServices/StaticData.svc/rest/GetBusCityList'));
    request.body = json.encode({
      "TokenId": busToken,
      "IpAddress": "192.168.11.120",
      "ClientId": "ApiIntegrationNew"
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
     var result =  await response.stream.bytesToString();
     var finalResult = BusCityListResponse.fromJson(jsonDecode(result));

     busCity = finalResult.busCities ?? [] ;

     print("_______${busCity.length}_______");

     isLoading = false ;
     setState(() {});

    }
    else {
      isLoading = false ;
      setState(() {});
      print(response.reasonPhrase);
    }
  }

  searchProduct(String value) {
    if (value.isEmpty) {
      getBusCityList();
      setState(() {});
    } else {
      final suggestions = busCity.where((element) {
        final productTitle = element.cityName!.toLowerCase();
        final input = value.toLowerCase();
        return productTitle.contains(input);
      }).toList();
      busCity = suggestions;
      setState(() {

      });
    }
  }


}
