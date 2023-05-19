import 'dart:convert';

import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:parry_trip2/constants/ApiBaseHelper.dart';
import 'package:parry_trip2/constants/app_colors.dart';
import 'package:parry_trip2/constants/constant.dart';
import 'package:parry_trip2/model/bus_model/bus_client_auth_response.dart';
import 'package:parry_trip2/screens/Bus/BusSearch.dart';
import 'package:parry_trip2/screens/Bus/search_city.dart';
import 'package:parry_trip2/widgets/AppBtn.dart';
import 'package:http/http.dart' as http;

class BusHomeScreen extends StatefulWidget {
  const BusHomeScreen({Key? key}) : super(key: key);

  @override
  State<BusHomeScreen> createState() => _BusHomeScreenState();
}

class _BusHomeScreenState extends State<BusHomeScreen> {
  final fromController = TextEditingController();
  final toController = TextEditingController();

  String? date;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    clientAuth();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 4.3,
              width: MediaQuery.of(context).size.width / 1,
              child: Stack(
                children: [
                  Positioned(
                      height: MediaQuery.of(context).size.height / 4.0,
                      width: MediaQuery.of(context).size.width / 1,
                      child: Container(
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/images/loginbg.png'),
                                fit: BoxFit.fill)),
                      )),
                  /* Positioned(
                              height: MediaQuery.of(context).size.height / 5.0,
                              width: MediaQuery.of(context).size.width / 1,
                              child: Image.asset(
                                "assets/images/airplane.png",
                                height: 50,
                                width: 50,
                              )),*/
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("From"),
                      TextFormField(
                        readOnly: true,
                        controller: fromController,
                        onTap: () {
                          Get.to(const SearchCityScreen(
                            isFrom: true,
                          ))?.then((value) {
                            if (value != null) {
                              print("_______${value[0]}_______");
                              print("_______${value[1]}_______");

                              fromController.text = value[0].cityName;
                              setState(() {});
                            }
                          });
                          /*var result = ShowListForm();
                    if (result != "" ||
                        result != null) {
                      fromcitycontroller =
                          TextEditingController(
                              text: result
                                  .toString());*/
                          //}
                        },
                        textAlign: TextAlign.left,
                        decoration: InputDecoration(
                            hintText: 'City',
                            hintStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: colors.black54.withOpacity(0.4))),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: RotatedBox(
                      quarterTurns: 45,
                      child: Icon(
                        Icons.compare_arrows_rounded,
                        color: colors.black54.withOpacity(0.4),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("To"),
                      TextFormField(
                        readOnly: true,
                        controller: toController,
                        onTap: () {
                          Get.to(SearchCityScreen(
                            isFrom: false,
                          ))?.then((value) {
                            if (value != null) {
                              print("_______${value[0].cityName}_______");
                              toController.text = value[0].cityName;
                              setState(() {});
                            }
                          });
                          /*var result1 = ShowListTo();
                    if (result1 != "" ||
                        result1 != null) {
                      tocityecontroller =
                          TextEditingController(
                              text: result1
                                  .toString());*/
                          //}
                        },
                        textAlign: TextAlign.left,
                        decoration: InputDecoration(
                            hintText: 'Select',
                            hintStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: colors.black54.withOpacity(0.4))),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Journey Date"),
                      DateTimeFormField(
                        decoration: const InputDecoration(
                          hintText: 'Select Date of journey ',
                          enabledBorder: InputBorder.none,
                          hintStyle: TextStyle(color: Colors.black45),
                          errorStyle: TextStyle(
                              color: Colors.redAccent,
                              fontWeight: FontWeight.bold),
                          border: OutlineInputBorder(),
                          suffixIcon: Icon(Icons.event_note),
                          // labelText: 'Only time',
                        ),
                        mode: DateTimeFieldPickerMode.date,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (e) {
                          var date = e?.add(Duration(hours: 23));
                          return (date ?? DateTime.now())
                                  .isBefore(DateTime.now())
                              ? 'Please select date after yesterday'
                              : null;
                        },
                        onDateSelected: (DateTime value) {
                          print(value);

                          date = DateFormat('yyyy-MM-dd').format(value);
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  BtnSearch1(
                      height: 50,
                      width: 320,
                      title: 'Bus Search',
                      onPress: () {
                        Get.to(BusSearchScreen(
                          dateTime: date,
                        ));
                      }
                      //getFlightSearch();
                      // if (_flightKey.currentState!.validate()) {
                      //
                      // } else {
                      //   const snackBar = SnackBar(
                      //     content: Text('All Fields are required!'),
                      //   );
                      //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      //
                      //
                      //   //Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
                      // }
                      ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> searchCity() async {}

  BusClientAuthResponse? busClientAuthResponse;

  Future<void> clientAuth() async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse('${bustUrl}Authenticate'));
    request.body = json.encode({
      "ClientId": "ApiIntegrationNew",
      "UserName": "Charmingtours",
      "Password": "Charming@12345",
      "EndUserIp": "192.168.11.120"
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finalresult = BusClientAuthResponse.fromJson(jsonDecode(result));

      busClientAuthResponse = finalresult;

      busToken = busClientAuthResponse?.tokenId ?? '';
      print("_______${busToken}_______");
    } else {
      print(response.reasonPhrase);
    }
  }
}
