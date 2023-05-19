import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:parry_trip2/constants/app_colors.dart';
import 'package:parry_trip2/constants/constant.dart';
import 'package:parry_trip2/model/RoutInfoModel.dart';
import 'package:parry_trip2/screens/FLight/FlightList.dart';
import 'package:parry_trip2/widgets/AppBtn.dart';
import 'package:parry_trip2/widgets/multiCityWidget.dart';

import '../../model/SearchCityModel.dart';
import '../../model/flightListNewModel.dart';

class FlightBooking extends StatefulWidget {
  const FlightBooking({Key? key}) : super(key: key);

  @override
  State<FlightBooking> createState() => _FlightBookingState();
}

class _FlightBookingState extends State<FlightBooking> {
  final _flightKey = GlobalKey<FormState>();
  TextEditingController citycontroller = TextEditingController();
  TextEditingController toCitycontroller = TextEditingController();
  TextEditingController fromcitycontroller = TextEditingController();
  TextEditingController tocityecontroller = TextEditingController();
  TextEditingController startdatecontroller = TextEditingController();
  TextEditingController enddatecontroller = TextEditingController();
  TextEditingController adultsController = TextEditingController(text: "1");
  TextEditingController seniorController = TextEditingController(text: "0");
  TextEditingController childrenController = TextEditingController(text: "0");
  SearchCityModel? searchCityModel;
  String? cityName;
  String? toCityName;
  String? fromCityCode;
  String? toCityCode;

  List<TextEditingController> fromCityControllerList = [];
  List<TextEditingController> toCityControllerList = [];
  List<TextEditingController> dateControllerList = [];
  List<Widget> multiCityWidgetList = [];
  List<RoutInfoModel> routInfo = [];
  int listIndex = 0;

  int currentIndex = 0;

  getCityList(String value) async {
    var headers = {
      'Cookie':
          'XSRF-TOKEN=eyJpdiI6IjMzUXliZFhlcjcxR2V6YzM2ZkRYUlE9PSIsInZhbHVlIjoiSll2QncvM083MnNaNmFxWmtwV2dtcVFoQVRBcml3c2U1eXVOQ1E3K0NoQzhyb1ppQUU5OEs3MSs1bkNqUDNGREtZU053MGtOY2Q4bWUzb0hnRVVUVzNrdVViVzgrekJLSGM0aDRaUXo1K0hrWmhRbUU2N01jYkREbHh1MWJlMngiLCJtYWMiOiIxNDc2MTEyYTgzN2Y4ZDM3NzJlMjY5ZTJhODYzMmQ4MjBlNThiMjkxODA3OWUzZWY5MjMyOTFlMTRhNDIxY2JlIiwidGFnIjoiIn0%3D; tour_and_travel_session=eyJpdiI6IldSRXlNUnZXMlZzbyt6ckc5RWNUSXc9PSIsInZhbHVlIjoiN0daSkxPV2xwc3dWUm02YmhFN1Ziam4rTWpMTE5GSEF1QUlMZTRjRzk1eEtCcktjU2NmWkt4eFpCTHlOWTg4N2d1TDNZdDZDbms5VENxdHpSWUk2NzdJN1R5RncvakhPMENrOUt3VllLKy8rejBPZ256Q1J1bkQvcWhhcnVMVGciLCJtYWMiOiI5Yzc5OTExYTAyNjhhMDMzMWJiZThmZDVlNzM4ZThkNTMwZmIxYThiY2I2MDBiNTNmYjk4NmVkNzhkM2FkZGQ5IiwidGFnIjoiIn0%3D'
    };
    var request = http.Request(
        'GET',
        Uri.parse(
            'https://tour.alphawizzserver.com/location/search/searchForAirportSelect2?search=$value'));

    request.headers.addAll(headers);
    print(
        "this is request ------>>> https://tour.alphawizzserver.com/location/search/searchForAirportSelect2?search=$value");

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final finalResult = await response.stream.bytesToString();
      final finalResponce = SearchCityModel.fromJson(json.decode(finalResult));
      print("this is a responce===========>${finalResponce}");
      setState(() {
        searchCityModel = finalResponce;
      });
    } else {
      print(response.reasonPhrase);
    }
  }

  FlightListModel? flightListModel;

  getFlightSearch() async {
    var headers = {
      'Content-Type': 'application/json',
      'apikey': '812146ac5e380f-ed6f-4a76-a035-314f4255eddb'
    };
    var request =
        http.Request('POST', Uri.parse('${flightUrl}fms/v1/air-search-all'));
    request.body = json.encode({
      "searchQuery": {
        "cabinClass": "${dropdownClass}",
        "paxInfo": {
          "ADULT": adultsController.text,
          "CHILD": childrenController.text,
          "INFANT": seniorController.text,
        },
        "routeInfos": [
          {
            "fromCityOrAirport": {"code": fromCityCode.toString()},
            "toCityOrAirport": {"code": toCityCode.toString()},
            "travelDate": startdatecontroller.text
          }
        ],
        "searchModifiers": {"isDirectFlight": true, "isConnectingFlight": false}
      }
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print("this is ===========>${response.statusCode}");
      final finalResult = await response.stream.bytesToString();
      final finalFlightResponce =
          FlightListModel.fromJson(json.decode(finalResult));
      print("this is a responce===========>1111111111${finalFlightResponce}");

      setState(() {
        flightListModel = finalFlightResponce;
      });
    } else {
      print(response.reasonPhrase);
    }
  }

  @override
  void initState() {
    super.initState();
    getFlightSearch();
    Future.delayed(Duration(milliseconds: 500), () {
      return getCityList('');
    });
    toCityControllerList = [TextEditingController()];
    fromCityControllerList = [TextEditingController()];
    dateControllerList = [TextEditingController()];
    routInfo.add(RoutInfoModel(
        fromCity: '',
        fromCityName: '',
        onwardDate: '',
        returnDate: '',
        toCity: '',
        toCityName: ''));

    multiCityWidgetList = [
      MultiCityWidget(
          fromController: fromCityControllerList[0],
          dateController: dateControllerList[0],
          toController: toCityControllerList[0])
    ];
  }

  // @override
  // void dispose() {
  //   joindatecontroller.dispose();
  //   super.dispose();
  // }

  String dropdownClass = 'Economy';
  var items = [
    'Economy',
    'Premium Economy',
    'Business',
    'First',
  ];

  int peopleCount = 0;
  int childrenCount = 0;
  int seniorCount = 0;

  String? selectedValue;
  String _dateValue = '';
  var dateFormate;

  String convertDateTimeDisplay(String date) {
    final DateFormat displayFormater = DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
    final DateFormat serverFormater = DateFormat('yyyy-MM-dd');
    final DateTime displayDate = displayFormater.parse(date);
    final String formatted = serverFormater.format(displayDate);
    return formatted;
  }

  Future _selectDate({bool? isFromReturn}) async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2025),
        //firstDate: DateTime.now().subtract(Duration(days: 1)),
        // lastDate: new DateTime(2022),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
                primaryColor: colors.primary,
                accentColor: Colors.black,
                colorScheme: ColorScheme.light(primary: colors.primary),
                // ColorScheme.light(primary: const Color(0xFFEB6C67)),
                buttonTheme:
                    ButtonThemeData(textTheme: ButtonTextTheme.accent)),
            child: child!,
          );
        });
    if (picked != null) {
      setState(() {
        String yourDate = picked.toString();
        if (isFromReturn ?? false) {
          enddatecontroller =
              TextEditingController(text: convertDateTimeDisplay(yourDate));
        } else {
          _dateValue = convertDateTimeDisplay(yourDate);
          print(_dateValue);
          dateFormate =
              DateFormat("dd/MM/yyyy").format(DateTime.parse(_dateValue ?? ""));
          startdatecontroller = TextEditingController(text: _dateValue);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    fromcitycontroller.text = cityName ?? '';
   tocityecontroller.text = toCityName ?? '';

    return Scaffold(
        backgroundColor: colors.whiteTemp,
        body: SafeArea(
          child: Scaffold(
              backgroundColor: colors.whiteTemp,
              body: Form(
                key: _flightKey,
                child: ListView(
                  children: [
                    Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Column(
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height / 5.3,
                              width: MediaQuery.of(context).size.width / 1,
                              child: Stack(
                                children: [
                                  Positioned(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              4.3,
                                      width:
                                          MediaQuery.of(context).size.width / 1,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    'assets/images/loginbg.png'),
                                                fit: BoxFit.fill)),
                                      )),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 15, right: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  currentIndex != 2 ?  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text("From"),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2.5,
                                            child: TextFormField(
                                              readOnly: true,
                                              controller: fromcitycontroller,
                                              onTap: () {
                                                var result = ShowListForm();
                                                if (result != "" ||
                                                    result != null) {
                                                  fromcitycontroller =
                                                      TextEditingController(
                                                          text: result
                                                              .toString());
                                                }
                                              },
                                              textAlign: TextAlign.left,
                                              decoration: const InputDecoration(
                                                hintText: 'city',
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Icon(
                                        Icons.compare_arrows_rounded,
                                        color: colors.black54.withOpacity(0.4),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          const Text("To"),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2.5,
                                            child: TextFormField(
                                              readOnly: true,
                                              controller: tocityecontroller,
                                              onTap: () {
                                                var result1 = ShowListTo();
                                                if (result1 != "" ||
                                                    result1 != null) {
                                                  tocityecontroller =
                                                      TextEditingController(
                                                          text: result1
                                                              .toString());
                                                }
                                              },
                                              textAlign: TextAlign.right,
                                              decoration: InputDecoration(
                                                  hintText: 'Select',
                                                  hintStyle: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20,
                                                      color: colors.black54
                                                          .withOpacity(0.4))),
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ) : SizedBox(),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                   Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            currentIndex = 0;
                                          });
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 5),
                                          decoration: BoxDecoration(
                                              color: currentIndex == 0
                                                  ? colors.yellow
                                                  : Colors.transparent,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all()),
                                          child: Text('ONE WAY'),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            currentIndex = 1;
                                          });
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 5),
                                          decoration: BoxDecoration(
                                              color: currentIndex == 1
                                                  ? colors.yellow
                                                  : Colors.transparent,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all()),
                                          child: Text('ROUND TRIP'),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            currentIndex = 2;
                                          });
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 5),
                                          decoration: BoxDecoration(
                                              color: currentIndex == 2
                                                  ? colors.yellow
                                                  : Colors.transparent,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all()),
                                          child: Text('MULTI CITY'),
                                        ),
                                      ),
                                    ],
                                  ),
                                  currentIndex != 2 ? const SizedBox(
                                    height: 40,
                                  ) : SizedBox(),
                                  currentIndex != 2 ? Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text("Select Date"),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2.5,
                                            child: TextFormField(
                                              readOnly: true,
                                              controller: startdatecontroller,
                                              onTap: () {
                                                _selectDate();
                                              },
                                              textAlign: TextAlign.left,
                                              decoration: const InputDecoration(
                                                hintText: 'Select Date',
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      currentIndex == 1
                                          ? Row(
                                              children: [
                                                Icon(
                                                  Icons.compare_arrows_rounded,
                                                  color: colors.black54
                                                      .withOpacity(0.4),
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    const Text("RETURN"),
                                                    SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              2.5,
                                                      child: TextFormField(
                                                        readOnly: true,
                                                        controller:
                                                            enddatecontroller,
                                                        onTap: () {
                                                          {
                                                            _selectDate(
                                                                isFromReturn:
                                                                    true);
                                                          }
                                                        },
                                                        textAlign:
                                                            TextAlign.right,
                                                        decoration: InputDecoration(
                                                            hintText:
                                                                'Return Date',
                                                            hintStyle: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 15,
                                                                color: colors
                                                                    .black54
                                                                    .withOpacity(
                                                                        0.4))),
                                                      ),
                                                    )
                                                  ],
                                                )
                                              ],
                                            )
                                          : SizedBox.shrink()
                                    ],
                                  ) : const SizedBox(),
                                  const SizedBox(
                                    height: 40,
                                  ),
                                  currentIndex == 2
                                      ? showMultiCity()
                                      : SizedBox(),

                                  /*Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("PASSENGER(s)"),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2.5,
                                            child: TextFormField(
                                              readOnly: true,
                                              // controller: startdatecontroller,
                                              onTap: () {
                                                ShowListPassengerList();
                                              },
                                              textAlign: TextAlign.left,
                                              decoration: InputDecoration(
                                                hintText: 'Passenger select',
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      // Icon(Icons.compare_arrows_rounded,color: colors.black54.withOpacity(0.4),),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text("PAY IN"),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2.5,
                                            child: TextFormField(
                                              //controller: enddatecontroller,
                                              onTap: () {
                                                {
                                                  // _selectDate1();
                                                }
                                              },
                                              textAlign: TextAlign.right,
                                              decoration: InputDecoration(
                                                  hintText: 'Select Currency',
                                                  hintStyle: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 15,
                                                      color: colors.black54
                                                          .withOpacity(0.4))),
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),*/
                                  Text(
                                    "Select PASSENGER".toUpperCase(),
                                    style: const TextStyle(
                                        color: colors.blackTemp,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Adults".toUpperCase(),
                                    style: const TextStyle(
                                        color: colors.blackTemp,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children:
                                        [1, 2, 3, 4, 5, 6, 7, 8, 9].map((e) {
                                      return InkWell(
                                        onTap: () {
                                          setState(() {
                                            adultsController.text =
                                                e.toString();
                                          });
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.grey),
                                              color: adultsController.text ==
                                                      e.toString()
                                                  ? Colors.orange
                                                  : Colors.white),
                                          margin: const EdgeInsets.all(5),
                                          padding: const EdgeInsets.all(5),
                                          child: Text(
                                            e.toString().toUpperCase(),
                                            style: TextStyle(
                                                color: adultsController.text ==
                                                        e.toString()
                                                    ? Colors.white
                                                    : colors.blackTemp,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14),
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Children".toUpperCase(),
                                    style: const TextStyle(
                                        color: colors.blackTemp,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      0,
                                      1,
                                      2,
                                      3,
                                      4,
                                      5,
                                      6,
                                      7,
                                      8,
                                    ].map((e) {
                                      return InkWell(
                                        onTap: () {
                                          setState(() {
                                            childrenController.text =
                                                e.toString();
                                          });
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.grey),
                                              color: childrenController.text ==
                                                      e.toString()
                                                  ? Colors.orange
                                                  : Colors.white),
                                          margin: const EdgeInsets.all(5),
                                          padding: const EdgeInsets.all(5),
                                          child: Text(
                                            e.toString().toUpperCase(),
                                            style: TextStyle(
                                                color:
                                                    childrenController.text ==
                                                            e.toString()
                                                        ? Colors.white
                                                        : colors.blackTemp,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14),
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Infant".toUpperCase(),
                                    style: const TextStyle(
                                        color: colors.blackTemp,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children:
                                        [0, 1, 2, 3, 4, 5, 6, 7, 8].map((e) {
                                      return InkWell(
                                        onTap: () {
                                          setState(() {
                                            seniorController.text =
                                                e.toString();
                                          });
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.grey),
                                              color: seniorController.text ==
                                                      e.toString()
                                                  ? Colors.orange
                                                  : Colors.white),
                                          margin: const EdgeInsets.all(5),
                                          padding: const EdgeInsets.all(5),
                                          child: Text(
                                            e.toString().toUpperCase(),
                                            style: TextStyle(
                                                color: seniorController.text ==
                                                        e.toString()
                                                    ? Colors.white
                                                    : colors.blackTemp,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14),
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                  /* Row(
                                    children: [
                                      Expanded(
                                        child: TextFormField(
                                          keyboardType: TextInputType.phone,
                                          controller: adultsController,
                                          decoration: InputDecoration(
                                              hintText: "Adults"),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: TextFormField(
                                          keyboardType: TextInputType.phone,
                                          controller: seniorController,
                                          decoration: InputDecoration(
                                              hintText: "Senior Citizen(s)"),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: TextFormField(
                                          keyboardType: TextInputType.phone,
                                          controller: childrenController,
                                          decoration: InputDecoration(
                                              hintText: "Children"),
                                        ),
                                      ),
                                    ],
                                  ),*/
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  const Text(
                                    "Select Class",
                                    style: TextStyle(
                                        color: colors.blackTemp,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  DropdownButtonHideUnderline(
                                    child: DropdownButton(
                                      isExpanded: true,
                                      value: dropdownClass,
                                      icon:
                                          const Icon(Icons.keyboard_arrow_down),
                                      items: items.map((String items) {
                                        return DropdownMenuItem(
                                          value: items,
                                          child: Text(
                                            items,
                                            style: const TextStyle(
                                                color: Colors.black),
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          dropdownClass = newValue!;
                                        });
                                      },
                                    ),
                                  ),
                                  const Divider(
                                    thickness: 1,
                                    color: colors.darkgrayColor,
                                  ),
                                  const SizedBox(
                                    height: 40,
                                  ),
                                  BtnSearch(
                                      height: 50,
                                      width: 320,
                                      title: 'Flight Search',
                                      onPress: () {

                                        if(currentIndex==2){
                                          List<Map> mapList = [];


                                          routInfo.forEach((element) {

                                            Map param = {
                                              "fromCityOrAirport": {
                                                "code": element.fromCity
                                              },
                                              "toCityOrAirport": {
                                                "code": element.toCity
                                              },
                                              "travelDate": element.onwardDate
                                            };
                                            print('${param}');

                                            mapList.add(param);

                                          });


                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      FlightList(
                                                        child:
                                                        childrenController
                                                            .text,
                                                        adults:
                                                        adultsController
                                                            .text,
                                                        date:
                                                        startdatecontroller
                                                            .text,
                                                        seniur:
                                                        seniorController
                                                            .text,
                                                        tocity: toCityCode
                                                            .toString(),
                                                        formCity:
                                                        fromCityCode,
                                                        toClass:
                                                        dropdownClass,
                                                        isMultiCity: true,
                                                        roundTripList: mapList,
                                                      )));




                                        }else {
                                          if (startdatecontroller.text == "" ||
                                              toCityCode == null ||
                                              fromCityCode == null ||
                                              dropdownClass == "") {
                                            Fluttertoast.showToast(
                                                msg: "Please fill all fields ");
                                          } else {
                                            List<Map> mapList = [];

                                            if (currentIndex == 1) {
                                              Map param = {
                                                "fromCityOrAirport": {
                                                  "code": fromCityCode
                                                },
                                                "toCityOrAirport": {
                                                  "code": toCityCode
                                                },
                                                "travelDate":
                                                    startdatecontroller.text
                                              };
                                              mapList.add(param);
                                              param = {
                                                "fromCityOrAirport": {
                                                  "code": toCityCode
                                                },
                                                "toCityOrAirport": {
                                                  "code": fromCityCode
                                                },
                                                "travelDate":
                                                    enddatecontroller.text
                                              };

                                              mapList.add(param);

                                              mapList.forEach((element) {
                                                print(element);
                                              });
                                            }

                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        FlightList(
                                                          child:
                                                              childrenController
                                                                  .text,
                                                          adults:
                                                              adultsController
                                                                  .text,
                                                          date:
                                                              startdatecontroller
                                                                  .text,
                                                          seniur:
                                                              seniorController
                                                                  .text,
                                                          tocity: toCityCode
                                                              .toString(),
                                                          formCity:
                                                              fromCityCode,
                                                          toClass:
                                                              dropdownClass,
                                                          isRoundTrip:
                                                              currentIndex == 1
                                                                  ? true
                                                                  : false,
                                                          roundTripList:
                                                              mapList,
                                                        )));
                                          }
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
                                      }),
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              )),
        ));
  }

  showMultiCity() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: List.generate(multiCityWidgetList.length, (index) {
            fromCityControllerList[index].text = routInfo[index].fromCityName ?? '';
            toCityControllerList[index].text = routInfo[index].toCityName ?? '';
            return MultiCityWidget(
              fromController: fromCityControllerList[index],
              dateController: dateControllerList[index],
              toController: toCityControllerList[index],
              tapOnDate: () {
                _selectDate2(index);
              },
              tapOnTo: () {
                listIndex = index ;
                var result1 = ShowListTo2(index);
                if (result1 != "" || result1 != null) {

                }
              },
              tapOnFrom: () {
                var result = ShowListForm2(index);
                if (result != "" || result != null) {
                }
              },
            );
          }),
        ),
        ElevatedButton(
          onPressed: () {
            fromCityControllerList.add(TextEditingController());
            toCityControllerList.add(TextEditingController());
            dateControllerList.add(TextEditingController());

            routInfo.add(RoutInfoModel(
                fromCity: '',
                fromCityName: '',
                onwardDate: '',
                returnDate: '',
                toCity: '',
                toCityName: ''));

            multiCityWidgetList.add(MultiCityWidget());
            setState(() {});
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
          ),
          child: Text('Add one more'),
        ),
      ],
    );
  }

  Widget fromAndToAndDateWidget() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SizedBox(
        height: 20,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("From"),
              SizedBox(
                width: MediaQuery.of(context).size.width / 2.5,
                child: TextFormField(
                  readOnly: true,
                  controller: fromcitycontroller,
                  onTap: () {
                    var result = ShowListForm();
                    if (result != "" || result != null) {
                      fromcitycontroller =
                          TextEditingController(text: result.toString());
                    }
                  },
                  textAlign: TextAlign.left,
                  decoration: const InputDecoration(
                    hintText: 'city',
                  ),
                ),
              ),
            ],
          ),
          Icon(
            Icons.compare_arrows_rounded,
            color: colors.black54.withOpacity(0.4),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text("To"),
              SizedBox(
                width: MediaQuery.of(context).size.width / 2.5,
                child: TextFormField(
                  readOnly: true,
                  controller: tocityecontroller,
                  onTap: () {
                    var result1 = ShowListTo();
                    if (result1 != "" || result1 != null) {
                      tocityecontroller =
                          TextEditingController(text: result1.toString());
                    }
                  },
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                      hintText: 'Select',
                      hintStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: colors.black54.withOpacity(0.4))),
                ),
              )
            ],
          )
        ],
      ),
      const SizedBox(
        height: 20,
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Select Date"),
          SizedBox(
            width: MediaQuery.of(context).size.width / 2.5,
            child: TextFormField(
              readOnly: true,
              controller: startdatecontroller,
              onTap: () {
                _selectDate();
              },
              textAlign: TextAlign.left,
              decoration: const InputDecoration(
                hintText: 'Select Date',
              ),
            ),
          ),
        ],
      ),
    ]);
  }

  ShowListForm() {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: 0.9,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.clear, color: colors.blackTemp)),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Select Arrival Airport/City",
                    style: TextStyle(
                        color: colors.blackTemp,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: colors.yellow.withOpacity(0.1)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextField(
                          controller: citycontroller,
                          onChanged: (String val) {
                            // if(val.length <=3){
                            getCityList(citycontroller.text.toString());
                            // }
                            getCityList(val);
                          },
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Search City',
                              hintStyle: TextStyle(
                                  fontSize: 13,
                                  color: colors.black54.withOpacity(0.4)),
                              prefixIcon: Icon(
                                Icons.search,
                                color: colors.black54.withOpacity(0.4),
                              )),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height,
                    child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        // physics: NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemCount: searchCityModel?.data?.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              setState(() {
                                cityName =
                                    "${searchCityModel?.data?[index].id} - ${searchCityModel?.data?[index].title}";
                                fromCityCode =
                                    "${searchCityModel?.data?[index].id}";
                              });
                              Navigator.pop(context);
                            },
                            child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                          "${searchCityModel?.data?[index].title}"),
                                      Container(
                                        height: 30,
                                        width: 50,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            border: Border.all(
                                                color: colors.black54)),
                                        child: Center(
                                            child: Text(
                                                "${searchCityModel?.data?[index].id}")),
                                      )
                                    ],
                                  ),
                                )),
                          );
                        }),
                  ),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  ShowListTo() {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: 0.9,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.clear, color: colors.blackTemp)),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Select Arrival Airport/City",
                    style: TextStyle(
                        color: colors.blackTemp,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: colors.yellow.withOpacity(0.1)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          onChanged: (String val) {
                            // if(val.length <=3){
                            getCityList(toCitycontroller.text.toString());
                            // }
                            getCityList(val);
                          },
                          controller: toCitycontroller,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Search City',
                              hintStyle: TextStyle(
                                  fontSize: 13,
                                  color: colors.black54.withOpacity(0.4)),
                              prefixIcon: Icon(
                                Icons.search,
                                color: colors.black54.withOpacity(0.4),
                              )),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height,
                    child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        // physics: NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemCount: searchCityModel?.data?.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              setState(() {
                                toCityName =
                                    "${searchCityModel?.data?[index].id} - ${searchCityModel?.data?[index].title}";
                                toCityCode =
                                    "${searchCityModel?.data?[index].id}";
                              });
                              Navigator.pop(context);
                            },
                            child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                          "${searchCityModel?.data?[index].title}"),
                                      Container(
                                        height: 30,
                                        width: 50,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            border: Border.all(
                                                color: colors.black54)),
                                        child: Center(
                                            child: Text(
                                                "${searchCityModel?.data?[index].id}")),
                                      )
                                    ],
                                  ),
                                )),
                          );
                        }),
                  ),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  ShowListForm2(int i) {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: 0.9,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.clear, color: colors.blackTemp)),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Select Arrival Airport/City",
                    style: TextStyle(
                        color: colors.blackTemp,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: colors.yellow.withOpacity(0.1)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextField(
                          controller: citycontroller,
                          onChanged: (String val) {
                            // if(val.length <=3){
                            getCityList(citycontroller.text.toString());
                            // }
                            getCityList(val);
                          },
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Search City',
                              hintStyle: TextStyle(
                                  fontSize: 13,
                                  color: colors.black54.withOpacity(0.4)),
                              prefixIcon: Icon(
                                Icons.search,
                                color: colors.black54.withOpacity(0.4),
                              )),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height,
                    child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        // physics: NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemCount: searchCityModel?.data?.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              setState(() {
                                routInfo[i].fromCityName =
                                    "${searchCityModel?.data?[index].id} - ${searchCityModel?.data?[index].title}";
                                routInfo[i].fromCity =
                                    "${searchCityModel?.data?[index].id}";

                                print('${routInfo[i].fromCityName}___fromtab');
                                print('${i}___fromtab');
                              });
                              Navigator.pop(context);
                            },
                            child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                          "${searchCityModel?.data?[index].title}"),
                                      Container(
                                        height: 30,
                                        width: 50,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            border: Border.all(
                                                color: colors.black54)),
                                        child: Center(
                                            child: Text(
                                                "${searchCityModel?.data?[index].id}")),
                                      )
                                    ],
                                  ),
                                )),
                          );
                        }),
                  ),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  ShowListTo2(int i) {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: 0.9,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.clear, color: colors.blackTemp)),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Select Arrival Airport/City",
                    style: TextStyle(
                        color: colors.blackTemp,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: colors.yellow.withOpacity(0.1)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          onChanged: (String val) {
                            // if(val.length <=3){
                            getCityList(toCitycontroller.text.toString());
                            // }
                            getCityList(val);
                          },
                          controller: toCitycontroller,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Search City',
                              hintStyle: TextStyle(
                                  fontSize: 13,
                                  color: colors.black54.withOpacity(0.4)),
                              prefixIcon: Icon(
                                Icons.search,
                                color: colors.black54.withOpacity(0.4),
                              )),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height,
                    child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        // physics: NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemCount: searchCityModel?.data?.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              setState(() {
                                routInfo[i].toCityName =
                                    "${searchCityModel?.data?[index].id} - ${searchCityModel?.data?[index].title}";
                                routInfo[i].toCity =
                                    "${searchCityModel?.data?[index].id}";

                                print('${routInfo[i].toCityName}___totab');
                                print('${i}___totab');
                              });
                              Navigator.pop(context);
                            },
                            child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                          "${searchCityModel?.data?[index].title}"),
                                      Container(
                                        height: 30,
                                        width: 50,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            border: Border.all(
                                                color: colors.black54)),
                                        child: Center(
                                            child: Text(
                                                "${searchCityModel?.data?[index].id}")),
                                      )
                                    ],
                                  ),
                                )),
                          );
                        }),
                  ),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future _selectDate2(int i) async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2025),
        //firstDate: DateTime.now().subtract(Duration(days: 1)),
        // lastDate: new DateTime(2022),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
                primaryColor: colors.primary,
                accentColor: Colors.black,
                colorScheme: ColorScheme.light(primary: colors.primary),
                // ColorScheme.light(primary: const Color(0xFFEB6C67)),
                buttonTheme:
                ButtonThemeData(textTheme: ButtonTextTheme.accent)),
            child: child!,
          );
        });
    if (picked != null) {
      setState(() {
        String yourDate = picked.toString();

        dateControllerList[i] =
              TextEditingController(text: convertDateTimeDisplay(yourDate));
        routInfo[i].onwardDate = convertDateTimeDisplay(yourDate) ;
      });
    }
  }

  ShowListPassengerList() {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return FractionallySizedBox(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.clear, color: colors.blackTemp)),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Select Passengers ",
                    style: TextStyle(
                        color: colors.blackTemp,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Adults',
                        style: TextStyle(color: colors.blackTemp, fontSize: 18),
                      ),
                      StatefulBuilder(
                        builder: (context, setState) => Row(
                          children: [
                            InkWell(
                                onTap: () {
                                  setState(() {
                                    if (peopleCount > 0) {
                                      peopleCount--;
                                    }
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: colors.darkgrayColor
                                          .withOpacity(0.5)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: Center(
                                        child: Icon(Icons.remove,
                                            color: colors.secondary, size: 18)),
                                  ),
                                )),
                            SizedBox(
                              width: 10,
                            ),
                            Text('${peopleCount}'),
                            const SizedBox(
                              width: 10,
                            ),
                            InkWell(
                                onTap: () {
                                  setState(() {
                                    peopleCount++;
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: colors.darkgrayColor
                                          .withOpacity(0.5)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: Center(
                                        child: Icon(Icons.add,
                                            color: colors.secondary, size: 18)),
                                  ),
                                )),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Senior Citizen(s)',
                        style: TextStyle(color: colors.blackTemp, fontSize: 18),
                      ),
                      StatefulBuilder(
                        builder: (context, setState) => Row(
                          children: [
                            InkWell(
                                onTap: () {
                                  setState(() {
                                    if (childrenCount > 0) {
                                      childrenCount--;
                                    }
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: colors.darkgrayColor
                                          .withOpacity(0.5)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: Center(
                                        child: Icon(Icons.remove,
                                            color: colors.secondary, size: 18)),
                                  ),
                                )),
                            SizedBox(
                              width: 10,
                            ),
                            Text('${childrenCount}'),
                            const SizedBox(
                              width: 10,
                            ),
                            InkWell(
                                onTap: () {
                                  setState(() {
                                    childrenCount++;
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: colors.darkgrayColor
                                          .withOpacity(0.5)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: Center(
                                        child: Icon(Icons.add,
                                            color: colors.secondary, size: 18)),
                                  ),
                                )),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Children',
                        style: TextStyle(color: colors.blackTemp, fontSize: 18),
                      ),
                      StatefulBuilder(
                        builder: (context, setState) => Row(
                          children: [
                            InkWell(
                                onTap: () {
                                  setState(() {
                                    if (seniorCount > 0) {
                                      seniorCount--;
                                    }
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: colors.darkgrayColor
                                          .withOpacity(0.5)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: Center(
                                        child: Icon(Icons.remove,
                                            color: colors.secondary, size: 18)),
                                  ),
                                )),
                            SizedBox(
                              width: 10,
                            ),
                            Text('${seniorCount}'),
                            const SizedBox(
                              width: 10,
                            ),
                            InkWell(
                                onTap: () {
                                  setState(() {
                                    seniorCount++;
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: colors.darkgrayColor
                                          .withOpacity(0.5)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: Center(
                                        child: Icon(
                                      Icons.add,
                                      color: colors.secondary,
                                      size: 18,
                                    )),
                                  ),
                                )),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
