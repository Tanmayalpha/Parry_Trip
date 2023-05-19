import 'dart:convert';
import 'dart:core';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:parry_trip2/constants/app_colors.dart';
import 'package:parry_trip2/constants/constant.dart';
import 'package:parry_trip2/model/fare_rule_model.dart';

import 'package:parry_trip2/model/flight_model.dart';
import 'package:parry_trip2/screens/FLight/checkout_screen.dart';

class FlightList extends StatefulWidget {
  const FlightList(
      {Key? key,
      this.tocity,
      this.date,
      this.adults,
      this.child,
      this.formCity,
      this.seniur,
      this.toClass, this.roundTripList,this.isRoundTrip, this.isMultiCity})
      : super(key: key);
  final String? tocity, formCity, date, adults, seniur, child, toClass;
  final List <Map>? roundTripList ;
  final bool? isRoundTrip;
  final bool? isMultiCity;

  @override
  State<FlightList> createState() => _FlightListState();
}

class _FlightListState extends State<FlightList> with SingleTickerProviderStateMixin{
  List<FlightModel> flightList1 = [];
  List<FlightModel> flightList2 = [];
  List<FlightModel> flightList3 = [];
  List<List<FlightModel>> multiCityflightList = [];
  List<FlightModel> finalFlightDetailData = [];
  bool loading = true;
  double firstFare = 0;
  double finalFare = 0;

  getFlightSearch() async {
    setState(() {
      loading = true;
    });
    var headers = {
      'Content-Type': 'application/json',
      'apikey': '812146ac5e380f-ed6f-4a76-a035-314f4255eddb'
    };
    var request =
        http.Request('POST', Uri.parse('${flightUrl}fms/v1/air-search-all'));
    request.body = json.encode({
      "searchQuery": {
        "cabinClass": widget.toClass.toString(),
        "paxInfo": {
          "ADULT": widget.adults.toString(),
          "CHILD": widget.child.toString(),
          "INFANT": widget.seniur.toString()
        },
        "routeInfos": widget.isRoundTrip ?? false ? widget.roundTripList : widget.isMultiCity ?? false ? widget.roundTripList :  [
          {
            "fromCityOrAirport": {"code": widget.formCity.toString()},
            "toCityOrAirport": {"code": widget.tocity.toString()},
            "travelDate": widget.date.toString()
          }
        ],
        "searchModifiers": {"isDirectFlight": true, "isConnectingFlight": false}
      }
    });
    print("thiis body=========>${request.body}");
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    flightList1.clear();

    print("this is ===========>${response.statusCode}");
    if (response.statusCode == 200) {
      final finalResult = await response.stream.bytesToString();
      log(finalResult);
      setState(() {
        loading = false;
      });
      Map data = jsonDecode(finalResult);
      if (data['searchResult'] != null &&
          data['searchResult']['tripInfos'] != null &&
          data['searchResult']['tripInfos']['ONWARD'] != null) {
        for (var v in data['searchResult']['tripInfos']['ONWARD']) {
          setState(() {
            flightList1.add(FlightModel.fromJson(v));
          });
        }
      }

      if (data['searchResult'] != null &&
          data['searchResult']['tripInfos'] != null &&
          data['searchResult']['tripInfos']['RETURN'] != null){

        for (var v in data['searchResult']['tripInfos']['RETURN']) {
          setState(() {
            flightList2.add(FlightModel.fromJson(v));
          });
        }



      }

      if(widget.isMultiCity ??  false) {
        widget.roundTripList!.forEach((element) {
          int index = widget.roundTripList!.indexOf(element);

          if (data['searchResult'] != null &&
              data['searchResult']['tripInfos'] != null &&
              data['searchResult']['tripInfos']['${index}'] != null){



            for (var v in data['searchResult']['tripInfos']['${index}']) {
          setState(() {
            flightList2.add(FlightModel.fromJson(v));

          });
        }

          }

        });

      }




      /*final finalFlightResponse =
          FlightListModel.fromJson(json.decode(finalResult));
      setState(() {
        flightListModel = finalFlightResponse;
        // flightList = finalFlightResponce.searchResult!.tripInfos!.oNWARD!;
      });*/
      /*print("this is result flight list =======>>>>>> ${flightList.length}");
      Navigator.push(context,
          MaterialPageRoute(builder: (context) =>FlightList()));*/
    } else {
      print(response.reasonPhrase);
    }
  }

  getFlightSearch2(int index) async {
    setState(() {
      loading = true;
    });
    var headers = {
      'Content-Type': 'application/json',
      'apikey': '812146ac5e380f-ed6f-4a76-a035-314f4255eddb'
    };
    var request =
    http.Request('POST', Uri.parse('${flightUrl}fms/v1/air-search-all'));
    request.body = json.encode({
      "searchQuery": {
        "cabinClass": widget.toClass.toString(),
        "paxInfo": {
          "ADULT": widget.adults.toString(),
          "CHILD": widget.child.toString(),
          "INFANT": widget.seniur.toString()
        },
        "routeInfos": widget.roundTripList,

        "searchModifiers": {"isDirectFlight": true, "isConnectingFlight": false}
      }
    });
    print("thiis body=========>${request.body}");
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    flightList1.clear();

    print("this is ===========>${response.statusCode}");
    if (response.statusCode == 200) {
      final finalResult = await response.stream.bytesToString();
      log(finalResult);
      setState(() {
        loading = false;
      });
      Map data = jsonDecode(finalResult);
      flightList3.clear();

      print("_______${widget.roundTripList?.length}___roundtrip____");

      for (var element in widget.roundTripList!) {


        int i = widget.roundTripList!.indexOf(element);
        print("_______${i}___roundtripINDEX____");



        if (data['searchResult'] != null &&
            data['searchResult']['tripInfos'] != null &&
            data['searchResult']['tripInfos']['${i}'] != null){

          List<FlightModel> flightList3 = [];

          for (var v in data['searchResult']['tripInfos']['${i}']) {

            setState(() {
              flightList3.add(FlightModel.fromJson(v));

            });

          }


          multiCityflightList.add(flightList3);
        }


      }


      //print("_______${multiCityflightList.first.first.sI?.first.aa?.city}___231____");

      /*final finalFlightResponse =
          FlightListModel.fromJson(json.decode(finalResult));
      setState(() {
        flightListModel = finalFlightResponse;
        // flightList = finalFlightResponce.searchResult!.tripInfos!.oNWARD!;
      });*/
      /*print("this is result flight list =======>>>>>> ${flightList.length}");
      Navigator.push(context,
          MaterialPageRoute(builder: (context) =>FlightList()));*/
    } else {
      print(response.reasonPhrase);
    }
  }

  // int minutes = 175;
  String formattedTime = '';
  String totalFare = "0";
  String convertTime(int? totalMinutes) {
    int hours = totalMinutes! ~/ 60;
    int minutes = totalMinutes % 60;
    formattedTime = '$hours hours $minutes mins';
    return formattedTime;
  }
  TabController? tabController;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.isMultiCity ?? false) {
      getFlightSearch2(0);
    }else {
      getFlightSearch();
    }
    // double hours = minutes / 60;
    String date = an.substring(11, 16);
    print("aaaaaaaaaaaaa====>${date}");
    if(widget.isRoundTrip ?? false){
    tabController = TabController(length: 2, vsync: this);
    }else{
      tabController = TabController(length: widget.roundTripList!.length, vsync: this);
    }

  }

  int selectedIndex = -1;
  int selectedIndex2 = -1;
  String an = '2022-03-24T23:59:59.000+00:00';
  Future<void> refreshList() async {
    setState(() {
      selectedIndex = -1;
      loading = true;
    });
    await getFlightSearch();
  }

  @override
  Widget build(BuildContext context) {
    // double hours = minutes / 60;
    return Scaffold(
        bottomNavigationBar: Container(
            color: colors.whiteTemp,
            height: 70,
            width: MediaQuery.of(context).size.width / 1.0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [Text("TOTAL FARE"), finalFare==0 ? Text("₹${firstFare}") : Text("₹${finalFare}")],
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () async {

                            if (!(widget.isRoundTrip ?? false) && selectedIndex != -1) {


                              finalFlightDetailData.add(flightList1[selectedIndex]);


                              var result = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CheckOutScreen(
                                          flightList1[selectedIndex],
                                          widget.adults,
                                          widget.child,
                                          widget.seniur, finalFlightDetailData)));
                              if (result != null) {
                                refreshList();
                              }

                            }
                            else if((widget.isRoundTrip ?? false) && (selectedIndex != -1 ||selectedIndex2 != -1) ) {

                              finalFlightDetailData.add(flightList1[selectedIndex]);
                              finalFlightDetailData.add(flightList2[selectedIndex2]);

                              var result = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CheckOutScreen(
                                          flightList1[selectedIndex],
                                          widget.adults,
                                          widget.child,
                                          widget.seniur, finalFlightDetailData)));
                              if (result != null) {
                                refreshList();
                              }
                            }else if( widget.isMultiCity ?? false){
                              for(int i = 0 ; i<multiCityflightList.length ; i++){
                                multiCityflightList[i].forEach((element) {
                                  if(element.selected ?? false){
                                    finalFlightDetailData.add(element);
                                  }
                                });
                              }


                              var result = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CheckOutScreen(
                                          flightList1.isEmpty ? FlightModel() : flightList1[selectedIndex],
                                          widget.adults,
                                          widget.child,
                                          widget.seniur, finalFlightDetailData)));
                              if (result != null) {
                                refreshList();
                              }


                            } else{
                              Fluttertoast.showToast(
                                  msg: "Please select flight");
                              return;
                            }
                          },
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: colors.secondary),
                            child: Center(
                                child: Text(
                              "Continue",
                              style: TextStyle(color: colors.whiteTemp),
                            )),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            )),
        backgroundColor: colors.whiteTemp,
        body: !loading
            ? RefreshIndicator(
                onRefresh: refreshList,
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
                                        image: AssetImage(
                                            'assets/images/loginbg.png'),
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

                   widget.isRoundTrip ?? false
                       ? TabBar(
                      isScrollable: true,
                      controller: tabController!,

                      onTap: (int index) {
                        if(tabController?.previousIndex==1){
                          flightList1.forEach((element) {
                            element.selected = false ;
                          });
                          flightList2.forEach((element) {
                            element.selected = false ;
                          });
                          finalFare =0;
                          firstFare =0;
                          setState(() {

                          });
                        }
                        /*if (index == 1) {
                          bool validate = true;

                          if (!validate) {
                            tabController!.animateTo(index - 1);
                            return;
                          }
                        }
                        tabController!.animateTo(index);
                        setState(() {

                        });*/
                      },
                      indicatorColor: Colors.deepOrange,
                      tabs:  [
                        Tab(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    flightList1.first.sI![0].da!
                                        .city
                                        .toString()
                                        .toString(),
                                    style: TextStyle(
                                        fontWeight:
                                        FontWeight
                                            .w700,
                                        fontSize:
                                        16.0, color: Colors.black),
                                  ),
                                  Icon(Icons
                                      .arrow_forward,color: Colors.black),
                                  Text(
                                    flightList1.first.sI![0].aa!
                                        .city
                                        .toString(),
                                    style: TextStyle(
                                        fontWeight:
                                        FontWeight
                                            .w700,
                                        fontSize:
                                        16.0, color: Colors.black),
                                  ),


                                ],
                              ),
                              Text(
                                DateFormat
                                    .yMMMEd()
                                    .format(DateTime
                                    .parse(flightList1.first
                                    .sI![0]
                                    .dt
                                    .toString())),
                                style: TextStyle(
                                    fontWeight:
                                    FontWeight
                                        .w700,
                                    color: Colors
                                        .black54,
                                    fontSize:
                                    16.0),
                              ),
                            ],
                          ),
                        ),
                        Tab(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    flightList2.first.sI![0].da!
                                        .city
                                        .toString()
                                        .toString(),
                                    style: TextStyle(
                                        fontWeight:
                                        FontWeight
                                            .w700,
                                        fontSize:
                                        16.0, color: Colors.black),
                                  ),
                                  Icon(Icons
                                      .arrow_forward,color: Colors.black),
                                  Text(
                                    flightList2.first.sI![0].aa!
                                        .city
                                        .toString(),
                                    style: TextStyle(
                                        fontWeight:
                                        FontWeight
                                            .w700,
                                        fontSize:
                                        16.0,color: Colors.black),
                                  ),


                                ],
                              ),
                              Text(
                                DateFormat
                                    .yMMMEd()
                                    .format(DateTime
                                    .parse(flightList2.first
                                    .sI![0]
                                    .dt
                                    .toString())),
                                style: TextStyle(
                                    fontWeight:
                                    FontWeight
                                        .w700,
                                    color: Colors
                                        .black54,
                                    fontSize:
                                    16.0),
                              ),
                            ],
                          ),
                        ),

                      ],
                    )
                       : widget.isMultiCity ?? false ?
                       TabBar(
                         controller: tabController,
                         isScrollable:true,
                         onTap: (int index){
                           tabController?.animateTo(index);
                           setState(() {
                             
                           });
                         },
                           tabs: List.generate(multiCityflightList.length, (index) {

                             return Tab(
                               child: Column(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [
                                   Row(
                                     children: [
                                       Text(
                                         multiCityflightList[index].first.sI![0].da!
                                             .city
                                             .toString()
                                             .toString(),
                                         style: TextStyle(
                                             fontWeight:
                                             FontWeight
                                                 .w700,
                                             fontSize:
                                             16.0, color: Colors.black),
                                       ),
                                       Icon(Icons
                                           .arrow_forward,color: Colors.black),
                                       Text(
                                         multiCityflightList[index].first.sI![0].aa!
                                             .city
                                             .toString(),
                                         style: TextStyle(
                                             fontWeight:
                                             FontWeight
                                                 .w700,
                                             fontSize:
                                             16.0,color: Colors.black),
                                       ),


                                     ],
                                   ),
                                   Text(
                                     DateFormat
                                         .yMMMEd()
                                         .format(DateTime
                                         .parse(multiCityflightList[index].first
                                         .sI![0]
                                         .dt
                                         .toString())),
                                     style: TextStyle(
                                         fontWeight:
                                         FontWeight
                                             .w700,
                                         color: Colors
                                             .black54,
                                         fontSize:
                                         16.0),
                                   ),
                                 ],
                               ),
                             );
                           }))
                       : const SizedBox.shrink(),

                    widget.isRoundTrip ?? false ? SizedBox(
                      height: MediaQuery.of(context).size.height/1.65,
                      child: TabBarView(
                        controller: tabController,
                          physics: const NeverScrollableScrollPhysics(),
                          children: [
                        flightList1.length > 0
                            ? getFlightListView(flightList1)
                            : const Text('Flight is not available on this rout!'),
                            flightList2.length > 0
                            ? getFlightListView2(flightList2)
                                :const Text('Flight is not available on this rout!'),
                      ]),
                    )
                        : widget.isMultiCity ?? false ? SizedBox(
                        height:MediaQuery.of(context).size.height/1.65,
                      child: TabBarView(
                        controller: tabController,

                        children: [
                          getFlightListView3(multiCityflightList[tabController!.index])],),
                    )
                        : flightList1.length > 0
                        ? getFlightListView(flightList1)
                        : const Text('Flight is not available on this rout!'),


                  ],
                ),
              )
            : const Center(
                child: CircularProgressIndicator(),
              ));
  }

  getFlightListView ( List <FlightModel> flightList){

    return Expanded(
      child:  ListView.separated(
          separatorBuilder: (context, index) =>
              SizedBox(),
          // Divider(thickness: 1,color: colors.blackTemp.withOpacity(0.2),
          // ),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          padding: const EdgeInsets.all(8),
          itemCount: flightList.length,
          itemBuilder: (BuildContext context, int index) {
            FlightModel model = flightList[index];
            bool isSelected = model.selected!;
            return getSeat(model.totalPriceList![0].fd!) >
                0
                ? Container(
              margin: EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                  BorderRadius.circular(5.0),
                  border: Border.all(
                      color: Colors.grey)),
              child: ExpansionTile(
                leading: IconButton(
                  icon: Icon(
                    flightList[index].selected!
                        ? Icons.radio_button_checked
                        : Icons
                        .radio_button_unchecked,
                    color: Colors.deepOrange,
                  ),
                  onPressed: () {

                    setState(() {
                      flightList
                          .forEach((element) {
                        element.selected = false;
                      });
                      selectedIndex = index;
                      flightList[index].selected =
                      true;
                      if(flightList[index].selected ?? false){

                      }
                      totalFare = getPrice(model
                          .totalPriceList![0].fd!);
                     // print(totalFare);
                      firstFare = double.parse(totalFare);
                    });
                  },
                ),
                title: Text(
                  model.sI![0].fD!.aI!.name
                      .toString(),
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                subtitle: Text(
                  "${model.sI![0].fD!.aI!.code}-${model.sI![0].fD!.fN}",
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.black54,
                  ),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InkWell(
                      onTap: () async {


                        if(flightList[index].selected ?? false){

                          tabController?.animateTo(1);

                        }else{
                          Fluttertoast.showToast(msg: 'select a flight first');
                        }

                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.deepOrange,
                          borderRadius:
                          BorderRadius.circular(
                              5.0),
                        ),
                        padding:
                        const EdgeInsets.all(
                            10),
                        child: Text(
                          "BOOK ₹${getPrice(model.totalPriceList![0].fd!)}",
                          style: TextStyle(
                            fontWeight:
                            FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Icon(
                      Icons
                          .keyboard_arrow_down_outlined,
                      size: 24,
                    ),
                  ],
                ),
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              model.activeTab =
                              "Details";
                            });
                          },
                          child: Container(
                            padding:
                            EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text(
                                  "Details",
                                  style: TextStyle(
                                    fontWeight:
                                    FontWeight
                                        .w700,
                                    color: model.activeTab ==
                                        "Details"
                                        ? Colors
                                        .deepOrange
                                        : Colors
                                        .black,
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Divider(
                                  thickness: 3,
                                  height: 5,
                                  color: model.activeTab ==
                                      "Details"
                                      ? Colors
                                      .deepOrange
                                      : Colors
                                      .black,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              model.activeTab =
                              "Prices";
                            });
                          },
                          child: Container(
                            padding:
                            EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text(
                                  "Prices",
                                  style: TextStyle(
                                    fontWeight:
                                    FontWeight
                                        .w700,
                                    color: model.activeTab ==
                                        "Prices"
                                        ? Colors
                                        .deepOrange
                                        : Colors
                                        .black,
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Divider(
                                  thickness: 3,
                                  height: 5,
                                  color: model.activeTab ==
                                      "Prices"
                                      ? Colors
                                      .deepOrange
                                      : Colors
                                      .black,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              model.activeTab =
                              "Rules";
                            });
                            getRule(model
                                .totalPriceList![0]
                                .id
                                .toString());
                          },
                          child: Container(
                            padding:
                            EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text(
                                  "Rules",
                                  style: TextStyle(
                                    fontWeight:
                                    FontWeight
                                        .w700,
                                    color: model.activeTab ==
                                        "Rules"
                                        ? Colors
                                        .deepOrange
                                        : Colors
                                        .black,
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Divider(
                                  thickness: 3,
                                  height: 5,
                                  color: model.activeTab ==
                                      "Rules"
                                      ? Colors
                                      .deepOrange
                                      : Colors
                                      .black,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              model.activeTab =
                              "Baggage";
                            });
                          },
                          child: Container(
                            padding:
                            EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text(
                                  "Baggage",
                                  style: TextStyle(
                                    fontWeight:
                                    FontWeight
                                        .w700,
                                    color: model.activeTab ==
                                        "Baggage"
                                        ? Colors
                                        .deepOrange
                                        : Colors
                                        .black,
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Divider(
                                  thickness: 3,
                                  height: 5,
                                  color: model.activeTab ==
                                      "Baggage"
                                      ? Colors
                                      .deepOrange
                                      : Colors
                                      .black,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Divider(),
                  model.activeTab == "Details"
                      ? Container(
                    padding:
                    EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              model.sI![0].da!
                                  .city
                                  .toString()
                                  .toString(),
                              style: TextStyle(
                                  fontWeight:
                                  FontWeight
                                      .w700,
                                  fontSize:
                                  16.0),
                            ),
                            Icon(Icons
                                .arrow_forward),
                            Text(
                              model.sI![0].aa!
                                  .city
                                  .toString(),
                              style: TextStyle(
                                  fontWeight:
                                  FontWeight
                                      .w700,
                                  fontSize:
                                  16.0),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              DateFormat
                                  .yMMMEd()
                                  .format(DateTime
                                  .parse(model
                                  .sI![0]
                                  .dt
                                  .toString())),
                              style: TextStyle(
                                  fontWeight:
                                  FontWeight
                                      .w700,
                                  color: Colors
                                      .black54,
                                  fontSize:
                                  16.0),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    getDateFormat(model
                                        .sI![
                                    0]
                                        .dt
                                        .toString()),
                                    style: TextStyle(
                                        fontWeight: FontWeight
                                            .w700,
                                        fontSize:
                                        12.0),
                                  ),
                                  Text(
                                    "${model.sI![0].da!.city.toString()},${model.sI![0].da!.country.toString()}",
                                    style: TextStyle(
                                        fontWeight: FontWeight
                                            .w700,
                                        color: Colors
                                            .black54,
                                        fontSize:
                                        12.0),
                                  ),
                                  Text(
                                    model
                                        .sI![
                                    0]
                                        .da!
                                        .name
                                        .toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight
                                            .w700,
                                        color: Colors
                                            .black54,
                                        fontSize:
                                        12.0),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                Icon(Icons
                                    .arrow_forward),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  durationToString(int.parse(model
                                      .sI![0]
                                      .duration
                                      .toString())),
                                  style: TextStyle(
                                      fontWeight:
                                      FontWeight
                                          .w700,
                                      fontSize:
                                      12.0),
                                ),
                              ],
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    getDateFormat(model
                                        .sI![
                                    0]
                                        .at
                                        .toString()),
                                    style: TextStyle(
                                        fontWeight: FontWeight
                                            .w700,
                                        fontSize:
                                        12.0),
                                  ),
                                  Text(
                                    "${model.sI![0].aa!.city.toString()},${model.sI![0].aa!.country.toString()}",
                                    style: TextStyle(
                                        fontWeight: FontWeight
                                            .w700,
                                        color: Colors
                                            .black54,
                                        fontSize:
                                        12.0),
                                  ),
                                  Text(
                                    model
                                        .sI![
                                    0]
                                        .aa!
                                        .name
                                        .toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight
                                            .w700,
                                        color: Colors
                                            .black54,
                                        fontSize:
                                        12.0),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "${getSeat(model.totalPriceList![0].fd!)} seat(s) left",
                                style: TextStyle(
                                    fontWeight:
                                    FontWeight
                                        .w700,
                                    color: Colors
                                        .orange,
                                    fontSize:
                                    16.0),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                getClass(model
                                    .totalPriceList![
                                0]
                                    .fd!),
                                textAlign:
                                TextAlign
                                    .end,
                                style: TextStyle(
                                    fontWeight:
                                    FontWeight
                                        .w700,
                                    color: Colors
                                        .orange,
                                    fontSize:
                                    16.0),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                      : SizedBox(),
                  model.activeTab == "Prices"
                      ? Container(
                    padding:
                    EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Text(
                                "TYPE",
                                style: TextStyle(
                                    fontWeight:
                                    FontWeight
                                        .w700,
                                    fontSize:
                                    16.0),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                "FARE",
                                style: TextStyle(
                                    fontWeight:
                                    FontWeight
                                        .w700,
                                    fontSize:
                                    16.0),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                "TOTAL",
                                textAlign:
                                TextAlign
                                    .end,
                                style: TextStyle(
                                    fontWeight:
                                    FontWeight
                                        .w700,
                                    fontSize:
                                    16.0),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        model.totalPriceList![0]
                            .fd!.aDULT !=
                            null
                            ? Column(
                          crossAxisAlignment:
                          CrossAxisAlignment
                              .start,
                          children: [
                            Text(
                              "Fare Details for Adult",
                              style: TextStyle(
                                  fontWeight: FontWeight
                                      .w500,
                                  color: Colors
                                      .black54,
                                  fontSize:
                                  14.0),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  flex:
                                  2,
                                  child:
                                  Text(
                                    "Base Price",
                                    style:
                                    TextStyle(fontWeight: FontWeight.w700, fontSize: 14.0),
                                  ),
                                ),
                                Expanded(
                                  child:
                                  Text(
                                    "₹${getBasePrice(model.totalPriceList![0].fd!, 0)}x${widget.adults}",
                                    style:
                                    TextStyle(fontWeight: FontWeight.w700, fontSize: 14.0),
                                  ),
                                ),
                                Expanded(
                                  child:
                                  Text(
                                    "₹${getBasePrice(model.totalPriceList![0].fd!, 0) * double.parse(widget.adults!)}",
                                    textAlign:
                                    TextAlign.end,
                                    style:
                                    TextStyle(fontWeight: FontWeight.w700, fontSize: 14.0),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  flex:
                                  2,
                                  child:
                                  Text(
                                    "Taxes and Fees",
                                    style:
                                    TextStyle(fontWeight: FontWeight.w700, fontSize: 14.0),
                                  ),
                                ),
                                Expanded(
                                  child:
                                  Text(
                                    "₹${getTax(model.totalPriceList![0].fd!, 0)}x${widget.adults}",
                                    style:
                                    TextStyle(fontWeight: FontWeight.w700, fontSize: 14.0),
                                  ),
                                ),
                                Expanded(
                                  child:
                                  Text(
                                    "₹${getTax(model.totalPriceList![0].fd!, 0) * double.parse(widget.adults!)}",
                                    textAlign:
                                    TextAlign.end,
                                    style:
                                    TextStyle(fontWeight: FontWeight.w700, fontSize: 14.0),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                            : SizedBox(),
                        SizedBox(
                          height: 10,
                        ),
                        model.totalPriceList![0]
                            .fd!.child !=
                            null
                            ? Column(
                          crossAxisAlignment:
                          CrossAxisAlignment
                              .start,
                          children: [
                            Text(
                              "Fare Details for Child",
                              style: TextStyle(
                                  fontWeight: FontWeight
                                      .w500,
                                  color: Colors
                                      .black54,
                                  fontSize:
                                  14.0),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  flex:
                                  2,
                                  child:
                                  Text(
                                    "Base Price",
                                    style:
                                    TextStyle(fontWeight: FontWeight.w700, fontSize: 14.0),
                                  ),
                                ),
                                Expanded(
                                  child:
                                  Text(
                                    "₹${getBasePrice(model.totalPriceList![0].fd!, 2)}x${widget.child}",
                                    style:
                                    TextStyle(fontWeight: FontWeight.w700, fontSize: 14.0),
                                  ),
                                ),
                                Expanded(
                                  child:
                                  Text(
                                    "₹${getBasePrice(model.totalPriceList![0].fd!, 2) * double.parse(widget.child!)}",
                                    textAlign:
                                    TextAlign.end,
                                    style:
                                    TextStyle(fontWeight: FontWeight.w700, fontSize: 14.0),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  flex:
                                  2,
                                  child:
                                  Text(
                                    "Taxes and Fees",
                                    style:
                                    TextStyle(fontWeight: FontWeight.w700, fontSize: 14.0),
                                  ),
                                ),
                                Expanded(
                                  child:
                                  Text(
                                    "₹${getTax(model.totalPriceList![0].fd!, 2)}x${widget.child}",
                                    style:
                                    TextStyle(fontWeight: FontWeight.w700, fontSize: 14.0),
                                  ),
                                ),
                                Expanded(
                                  child:
                                  Text(
                                    "₹${getTax(model.totalPriceList![0].fd!, 2) * double.parse(widget.child!)}",
                                    textAlign:
                                    TextAlign.end,
                                    style:
                                    TextStyle(fontWeight: FontWeight.w700, fontSize: 14.0),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                            : SizedBox(),
                        SizedBox(
                          height: 10,
                        ),
                        model.totalPriceList![0].fd!
                            .infant !=
                            null
                            ? Column(
                          crossAxisAlignment:
                          CrossAxisAlignment
                              .start,
                          children: [
                            Text(
                              "Fare Details for Infant",
                              style: TextStyle(
                                  fontWeight: FontWeight
                                      .w500,
                                  color: Colors
                                      .black54,
                                  fontSize:
                                  14.0),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  flex:
                                  2,
                                  child:
                                  Text(
                                    "Base Price",
                                    style:
                                    TextStyle(fontWeight: FontWeight.w700, fontSize: 14.0),
                                  ),
                                ),
                                Expanded(
                                  child:
                                  Text(
                                    "₹${getBasePrice(model.totalPriceList![0].fd!, 1)}x${widget.seniur}",
                                    style:
                                    TextStyle(fontWeight: FontWeight.w700, fontSize: 14.0),
                                  ),
                                ),
                                Expanded(
                                  child:
                                  Text(
                                    "₹${getBasePrice(model.totalPriceList![0].fd!, 1) * double.parse(widget.seniur!)}",
                                    textAlign:
                                    TextAlign.end,
                                    style:
                                    TextStyle(fontWeight: FontWeight.w700, fontSize: 14.0),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  flex:
                                  2,
                                  child:
                                  Text(
                                    "Taxes and Fees",
                                    style:
                                    TextStyle(fontWeight: FontWeight.w700, fontSize: 14.0),
                                  ),
                                ),
                                Expanded(
                                  child:
                                  Text(
                                    "₹${getTax(model.totalPriceList![0].fd!, 1)}x${widget.seniur}",
                                    style:
                                    TextStyle(fontWeight: FontWeight.w700, fontSize: 14.0),
                                  ),
                                ),
                                Expanded(
                                  child:
                                  Text(
                                    "₹${getTax(model.totalPriceList![0].fd!, 1) * double.parse(widget.seniur!)}",
                                    textAlign:
                                    TextAlign.end,
                                    style:
                                    TextStyle(fontWeight: FontWeight.w700, fontSize: 14.0),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                            : SizedBox(),
                        Divider(),
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Text(
                                "Total",
                                style: TextStyle(
                                    fontWeight:
                                    FontWeight
                                        .w700,
                                    fontSize:
                                    14.0),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                "₹${getPrice(model.totalPriceList![0].fd!)}",
                                textAlign:
                                TextAlign
                                    .end,
                                style: TextStyle(
                                    fontWeight:
                                    FontWeight
                                        .w700,
                                    fontSize:
                                    14.0),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                      : SizedBox(),
                  model.activeTab == "Rules" &&
                      rules != null
                      ? Container(
                    padding:
                    EdgeInsets.all(10),
                    child: Column(
                      children: [
                        rules!.cANCELLATION !=
                            null
                            ? Column(
                          crossAxisAlignment:
                          CrossAxisAlignment
                              .start,
                          children: [
                            Text(
                              "Cancellation Fee",
                              style: TextStyle(
                                  fontWeight: FontWeight
                                      .w700,
                                  color: Colors
                                      .black,
                                  fontSize:
                                  14.0),
                            ),
                            SizedBox(
                              height:
                              10,
                            ),
                            Text(
                              rules!
                                  .cANCELLATION!
                                  .dEFAULT!
                                  .policyInfo!,
                              style: TextStyle(
                                  fontWeight: FontWeight
                                      .w500,
                                  color: Colors
                                      .black54,
                                  fontSize:
                                  14.0),
                            ),
                          ],
                        )
                            : SizedBox(),
                        SizedBox(
                          height: 10,
                        ),
                        rules!.dATECHANGE !=
                            null
                            ? Column(
                          crossAxisAlignment:
                          CrossAxisAlignment
                              .start,
                          children: [
                            Text(
                              "Date Change Fee",
                              style: TextStyle(
                                  fontWeight: FontWeight
                                      .w700,
                                  color: Colors
                                      .black,
                                  fontSize:
                                  14.0),
                            ),
                            SizedBox(
                              height:
                              10,
                            ),
                            Text(
                              rules!
                                  .dATECHANGE!
                                  .dEFAULT!
                                  .policyInfo!,
                              style: TextStyle(
                                  fontWeight: FontWeight
                                      .w500,
                                  color: Colors
                                      .black54,
                                  fontSize:
                                  14.0),
                            ),
                          ],
                        )
                            : SizedBox(),
                        SizedBox(
                          height: 10,
                        ),
                        rules!.noShow != null
                            ? Column(
                          crossAxisAlignment:
                          CrossAxisAlignment
                              .start,
                          children: [
                            Text(
                              "No Show",
                              style: TextStyle(
                                  fontWeight: FontWeight
                                      .w700,
                                  color: Colors
                                      .black,
                                  fontSize:
                                  14.0),
                            ),
                            SizedBox(
                              height:
                              10,
                            ),
                            Text(
                              rules!
                                  .noShow!
                                  .dEFAULT!
                                  .policyInfo!,
                              style: TextStyle(
                                  fontWeight: FontWeight
                                      .w500,
                                  color: Colors
                                      .black54,
                                  fontSize:
                                  14.0),
                            ),
                          ],
                        )
                            : SizedBox(),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  )
                      : SizedBox(),
                  model.activeTab == "Baggage"
                      ? Container(
                    padding:
                    EdgeInsets.all(10),
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment
                          .start,
                      children: [
                        Text(
                          "CHECKIN",
                          style: TextStyle(
                              fontWeight:
                              FontWeight
                                  .w700,
                              color: Colors
                                  .black,
                              fontSize: 14.0),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          getBaggage(
                              model
                                  .totalPriceList![
                              0]
                                  .fd!,
                              0),
                          style: TextStyle(
                              fontWeight:
                              FontWeight
                                  .w500,
                              color: Colors
                                  .black54,
                              fontSize: 14.0),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "CABIN",
                          style: TextStyle(
                              fontWeight:
                              FontWeight
                                  .w700,
                              color: Colors
                                  .black,
                              fontSize: 14.0),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          getBaggage(
                              model
                                  .totalPriceList![
                              0]
                                  .fd!,
                              1),
                          style: TextStyle(
                              fontWeight:
                              FontWeight
                                  .w500,
                              color: Colors
                                  .black54,
                              fontSize: 14.0),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  )
                      : SizedBox(),
                ],
              ),
            )
                : SizedBox();

            return InkWell(
              onTap: () {
                setState(() {
                  flightList1?.forEach((element) {
                    element.selected = false;
                  });
                  flightList1[index].selected = true;
                  totalFare = model.totalPriceList![0].fd!
                      .aDULT!.fC!.bF
                      .toString();
                });
              },
              child: Card(
                color: isSelected
                    ? colors.secondary.withOpacity(0.0)
                    : colors.whiteTemp,
                elevation: 2,
                child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          Text(
                              '${model.sI![0].fD!.aI!.name}'),
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment
                                .spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    '${model.sI![0].dt?.substring(11, 16)}',
                                    style: TextStyle(
                                        color:
                                        colors.blackTemp,
                                        fontWeight:
                                        FontWeight.bold),
                                  ),
                                  Text(
                                      '${model.sI![0].da!.code}'),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(convertTime(
                                      model.sI![0].duration)),
                                  SizedBox(
                                    width: 3,
                                  ),
                                  SizedBox(
                                      width: 80,
                                      child: Divider(
                                        thickness: 1,
                                        color: colors.black54,
                                      )),
                                  SizedBox(
                                    width: 3,
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    '${model.sI![0].at?.substring(11, 16)}',
                                    style: TextStyle(
                                        color:
                                        colors.blackTemp,
                                        fontWeight:
                                        FontWeight.bold),
                                  ),
                                  Text(
                                      '${model.sI![0].aa!.code}'),
                                ],
                              ),
                              Text(
                                  '₹${model.totalPriceList![0].fd!.aDULT!.fC!.bF.toString()}'),

                              // SizedBox(width: 2,),
                              // Text('(${model.sI![0].da!.terminal})'),
                              // SizedBox(width: 3,),
                              // SizedBox(width: 10,
                              //     child: Divider(thickness: 1,color: colors.black54,)),
                              // SizedBox(width: 3,),
                              // Text('${model.sI![0].aa!.code}'),
                              // SizedBox(width: 2,),
                              // Text('(${model.sI![0].aa!.terminal})'),
                            ],
                          ),
                        ],
                      ),
                    )),
              ),
            );
          }),
    );


  }

  getFlightListView2 ( List <FlightModel> flightList){

    return Expanded(
      child: ListView.separated(
          separatorBuilder: (context, index) =>
              SizedBox(),
          // Divider(thickness: 1,color: colors.blackTemp.withOpacity(0.2),
          // ),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          padding: const EdgeInsets.all(8),
          itemCount: flightList.length,
          itemBuilder: (BuildContext context, int index) {
            FlightModel model = flightList[index];
            bool isSelected = model.selected!;
            return getSeat(model.totalPriceList![0].fd!) >
                0
                ? Container(
              margin: EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                  BorderRadius.circular(5.0),
                  border: Border.all(
                      color: Colors.grey)),
              child: ExpansionTile(
                leading: IconButton(
                  icon: Icon(
                    flightList[index].selected!
                        ? Icons.radio_button_checked
                        : Icons
                        .radio_button_unchecked,
                    color: Colors.deepOrange,
                  ),
                  onPressed: () {
                    finalFlightDetailData.clear();

                    setState(() {
                      flightList
                          .forEach((element) {
                        element.selected = false;
                      });
                      selectedIndex2 = index;
                      flightList[index].selected =
                      true;
                      if(flightList[index].selected ?? false){

                      }
                      totalFare = getPrice(model
                          .totalPriceList![0].fd!);
                      // print(totalFare);

                      finalFare = double.parse(totalFare)+firstFare;

                    });
                  },
                ),
                title: Text(
                  model.sI![0].fD!.aI!.name
                      .toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                subtitle: Text(
                  "${model.sI![0].fD!.aI!.code}-${model.sI![0].fD!.fN}",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.black54,
                  ),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InkWell(


                      onTap: () async {

                        if(flightList[index].selected ?? false){
                          Fluttertoast.showToast(msg: 'Press continue button');
                        }else{
                          Fluttertoast.showToast(msg: 'select a flight');
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.deepOrange,
                          borderRadius:
                          BorderRadius.circular(
                              5.0),
                        ),
                        padding:
                        const EdgeInsets.all(
                            10),
                        child: Text(
                          "BOOK ₹${getPrice(model.totalPriceList![0].fd!)}",
                          style: TextStyle(
                            fontWeight:
                            FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Icon(
                      Icons
                          .keyboard_arrow_down_outlined,
                      size: 24,
                    ),
                  ],
                ),
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              model.activeTab =
                              "Details";
                            });
                          },
                          child: Container(
                            padding:
                            EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text(
                                  "Details",
                                  style: TextStyle(
                                    fontWeight:
                                    FontWeight
                                        .w700,
                                    color: model.activeTab ==
                                        "Details"
                                        ? Colors
                                        .deepOrange
                                        : Colors
                                        .black,
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Divider(
                                  thickness: 3,
                                  height: 5,
                                  color: model.activeTab ==
                                      "Details"
                                      ? Colors
                                      .deepOrange
                                      : Colors
                                      .black,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              model.activeTab =
                              "Prices";
                            });
                          },
                          child: Container(
                            padding:
                            EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text(
                                  "Prices",
                                  style: TextStyle(
                                    fontWeight:
                                    FontWeight
                                        .w700,
                                    color: model.activeTab ==
                                        "Prices"
                                        ? Colors
                                        .deepOrange
                                        : Colors
                                        .black,
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Divider(
                                  thickness: 3,
                                  height: 5,
                                  color: model.activeTab ==
                                      "Prices"
                                      ? Colors
                                      .deepOrange
                                      : Colors
                                      .black,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              model.activeTab =
                              "Rules";
                            });
                            getRule(model
                                .totalPriceList![0]
                                .id
                                .toString());
                          },
                          child: Container(
                            padding:
                            EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text(
                                  "Rules",
                                  style: TextStyle(
                                    fontWeight:
                                    FontWeight
                                        .w700,
                                    color: model.activeTab ==
                                        "Rules"
                                        ? Colors
                                        .deepOrange
                                        : Colors
                                        .black,
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Divider(
                                  thickness: 3,
                                  height: 5,
                                  color: model.activeTab ==
                                      "Rules"
                                      ? Colors
                                      .deepOrange
                                      : Colors
                                      .black,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              model.activeTab =
                              "Baggage";
                            });
                          },
                          child: Container(
                            padding:
                            EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text(
                                  "Baggage",
                                  style: TextStyle(
                                    fontWeight:
                                    FontWeight
                                        .w700,
                                    color: model.activeTab ==
                                        "Baggage"
                                        ? Colors
                                        .deepOrange
                                        : Colors
                                        .black,
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Divider(
                                  thickness: 3,
                                  height: 5,
                                  color: model.activeTab ==
                                      "Baggage"
                                      ? Colors
                                      .deepOrange
                                      : Colors
                                      .black,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Divider(),
                  model.activeTab == "Details"
                      ? Container(
                    padding:
                    EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              model.sI![0].da!
                                  .city
                                  .toString()
                                  .toString(),
                              style: TextStyle(
                                  fontWeight:
                                  FontWeight
                                      .w700,
                                  fontSize:
                                  16.0),
                            ),
                            Icon(Icons
                                .arrow_forward),
                            Text(
                              model.sI![0].aa!
                                  .city
                                  .toString(),
                              style: TextStyle(
                                  fontWeight:
                                  FontWeight
                                      .w700,
                                  fontSize:
                                  16.0),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              DateFormat
                                  .yMMMEd()
                                  .format(DateTime
                                  .parse(model
                                  .sI![0]
                                  .dt
                                  .toString())),
                              style: TextStyle(
                                  fontWeight:
                                  FontWeight
                                      .w700,
                                  color: Colors
                                      .black54,
                                  fontSize:
                                  16.0),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    getDateFormat(model
                                        .sI![
                                    0]
                                        .dt
                                        .toString()),
                                    style: TextStyle(
                                        fontWeight: FontWeight
                                            .w700,
                                        fontSize:
                                        12.0),
                                  ),
                                  Text(
                                    "${model.sI![0].da!.city.toString()},${model.sI![0].da!.country.toString()}",
                                    style: TextStyle(
                                        fontWeight: FontWeight
                                            .w700,
                                        color: Colors
                                            .black54,
                                        fontSize:
                                        12.0),
                                  ),
                                  Text(
                                    model
                                        .sI![
                                    0]
                                        .da!
                                        .name
                                        .toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight
                                            .w700,
                                        color: Colors
                                            .black54,
                                        fontSize:
                                        12.0),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                Icon(Icons
                                    .arrow_forward),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  durationToString(int.parse(model
                                      .sI![0]
                                      .duration
                                      .toString())),
                                  style: TextStyle(
                                      fontWeight:
                                      FontWeight
                                          .w700,
                                      fontSize:
                                      12.0),
                                ),
                              ],
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    getDateFormat(model
                                        .sI![
                                    0]
                                        .at
                                        .toString()),
                                    style: TextStyle(
                                        fontWeight: FontWeight
                                            .w700,
                                        fontSize:
                                        12.0),
                                  ),
                                  Text(
                                    "${model.sI![0].aa!.city.toString()},${model.sI![0].aa!.country.toString()}",
                                    style: TextStyle(
                                        fontWeight: FontWeight
                                            .w700,
                                        color: Colors
                                            .black54,
                                        fontSize:
                                        12.0),
                                  ),
                                  Text(
                                    model
                                        .sI![
                                    0]
                                        .aa!
                                        .name
                                        .toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight
                                            .w700,
                                        color: Colors
                                            .black54,
                                        fontSize:
                                        12.0),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "${getSeat(model.totalPriceList![0].fd!)} seat(s) left",
                                style: TextStyle(
                                    fontWeight:
                                    FontWeight
                                        .w700,
                                    color: Colors
                                        .orange,
                                    fontSize:
                                    16.0),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                getClass(model
                                    .totalPriceList![
                                0]
                                    .fd!),
                                textAlign:
                                TextAlign
                                    .end,
                                style: TextStyle(
                                    fontWeight:
                                    FontWeight
                                        .w700,
                                    color: Colors
                                        .orange,
                                    fontSize:
                                    16.0),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                      : SizedBox(),
                  if (model.activeTab == "Prices") Container(
                    padding:
                    EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Text(
                                "TYPE",
                                style: TextStyle(
                                    fontWeight:
                                    FontWeight
                                        .w700,
                                    fontSize:
                                    16.0),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                "FARE",
                                style: TextStyle(
                                    fontWeight:
                                    FontWeight
                                        .w700,
                                    fontSize:
                                    16.0),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                "TOTAL",
                                textAlign:
                                TextAlign
                                    .end,
                                style: TextStyle(
                                    fontWeight:
                                    FontWeight
                                        .w700,
                                    fontSize:
                                    16.0),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        model.totalPriceList![0]
                            .fd!.aDULT !=
                            null
                            ? Column(
                          crossAxisAlignment:
                          CrossAxisAlignment
                              .start,
                          children: [
                            Text(
                              "Fare Details for Adult",
                              style: TextStyle(
                                  fontWeight: FontWeight
                                      .w500,
                                  color: Colors
                                      .black54,
                                  fontSize:
                                  14.0),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  flex:
                                  2,
                                  child:
                                  Text(
                                    "Base Price",
                                    style:
                                    TextStyle(fontWeight: FontWeight.w700, fontSize: 14.0),
                                  ),
                                ),
                                Expanded(
                                  child:
                                  Text(
                                    "₹${getBasePrice(model.totalPriceList![0].fd!, 0)}x${widget.adults}",
                                    style:
                                    TextStyle(fontWeight: FontWeight.w700, fontSize: 14.0),
                                  ),
                                ),
                                Expanded(
                                  child:
                                  Text(
                                    "₹${getBasePrice(model.totalPriceList![0].fd!, 0) * double.parse(widget.adults!)}",
                                    textAlign:
                                    TextAlign.end,
                                    style:
                                    TextStyle(fontWeight: FontWeight.w700, fontSize: 14.0),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  flex:
                                  2,
                                  child:
                                  Text(
                                    "Taxes and Fees",
                                    style:
                                    TextStyle(fontWeight: FontWeight.w700, fontSize: 14.0),
                                  ),
                                ),
                                Expanded(
                                  child:
                                  Text(
                                    "₹${getTax(model.totalPriceList![0].fd!, 0)}x${widget.adults}",
                                    style:
                                    TextStyle(fontWeight: FontWeight.w700, fontSize: 14.0),
                                  ),
                                ),
                                Expanded(
                                  child:
                                  Text(
                                    "₹${getTax(model.totalPriceList![0].fd!, 0) * double.parse(widget.adults!)}",
                                    textAlign:
                                    TextAlign.end,
                                    style:
                                    TextStyle(fontWeight: FontWeight.w700, fontSize: 14.0),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                            : SizedBox(),
                        SizedBox(
                          height: 10,
                        ),
                        model.totalPriceList![0]
                            .fd!.child !=
                            null
                            ? Column(
                          crossAxisAlignment:
                          CrossAxisAlignment
                              .start,
                          children: [
                            Text(
                              "Fare Details for Child",
                              style: TextStyle(
                                  fontWeight: FontWeight
                                      .w500,
                                  color: Colors
                                      .black54,
                                  fontSize:
                                  14.0),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  flex:
                                  2,
                                  child:
                                  Text(
                                    "Base Price",
                                    style:
                                    TextStyle(fontWeight: FontWeight.w700, fontSize: 14.0),
                                  ),
                                ),
                                Expanded(
                                  child:
                                  Text(
                                    "₹${getBasePrice(model.totalPriceList![0].fd!, 2)}x${widget.child}",
                                    style:
                                    TextStyle(fontWeight: FontWeight.w700, fontSize: 14.0),
                                  ),
                                ),
                                Expanded(
                                  child:
                                  Text(
                                    "₹${getBasePrice(model.totalPriceList![0].fd!, 2) * double.parse(widget.child!)}",
                                    textAlign:
                                    TextAlign.end,
                                    style:
                                    TextStyle(fontWeight: FontWeight.w700, fontSize: 14.0),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  flex:
                                  2,
                                  child:
                                  Text(
                                    "Taxes and Fees",
                                    style:
                                    TextStyle(fontWeight: FontWeight.w700, fontSize: 14.0),
                                  ),
                                ),
                                Expanded(
                                  child:
                                  Text(
                                    "₹${getTax(model.totalPriceList![0].fd!, 2)}x${widget.child}",
                                    style:
                                    TextStyle(fontWeight: FontWeight.w700, fontSize: 14.0),
                                  ),
                                ),
                                Expanded(
                                  child:
                                  Text(
                                    "₹${getTax(model.totalPriceList![0].fd!, 2) * double.parse(widget.child!)}",
                                    textAlign:
                                    TextAlign.end,
                                    style:
                                    TextStyle(fontWeight: FontWeight.w700, fontSize: 14.0),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                            : const SizedBox(),
                        SizedBox(
                          height: 10,
                        ),
                        model.totalPriceList![0].fd!
                            .infant !=
                            null
                            ? Column(
                          crossAxisAlignment:
                          CrossAxisAlignment
                              .start,
                          children: [
                            Text(
                              "Fare Details for Infant",
                              style: TextStyle(
                                  fontWeight: FontWeight
                                      .w500,
                                  color: Colors
                                      .black54,
                                  fontSize:
                                  14.0),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  flex:
                                  2,
                                  child:
                                  Text(
                                    "Base Price",
                                    style:
                                    TextStyle(fontWeight: FontWeight.w700, fontSize: 14.0),
                                  ),
                                ),
                                Expanded(
                                  child:
                                  Text(
                                    "₹${getBasePrice(model.totalPriceList![0].fd!, 1)}x${widget.seniur}",
                                    style:
                                    TextStyle(fontWeight: FontWeight.w700, fontSize: 14.0),
                                  ),
                                ),
                                Expanded(
                                  child:
                                  Text(
                                    "₹${getBasePrice(model.totalPriceList![0].fd!, 1) * double.parse(widget.seniur!)}",
                                    textAlign:
                                    TextAlign.end,
                                    style:
                                    TextStyle(fontWeight: FontWeight.w700, fontSize: 14.0),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  flex:
                                  2,
                                  child:
                                  Text(
                                    "Taxes and Fees",
                                    style:
                                    TextStyle(fontWeight: FontWeight.w700, fontSize: 14.0),
                                  ),
                                ),
                                Expanded(
                                  child:
                                  Text(
                                    "₹${getTax(model.totalPriceList![0].fd!, 1)}x${widget.seniur}",
                                    style:
                                    TextStyle(fontWeight: FontWeight.w700, fontSize: 14.0),
                                  ),
                                ),
                                Expanded(
                                  child:
                                  Text(
                                    "₹${getTax(model.totalPriceList![0].fd!, 1) * double.parse(widget.seniur!)}",
                                    textAlign:
                                    TextAlign.end,
                                    style:
                                    TextStyle(fontWeight: FontWeight.w700, fontSize: 14.0),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                            : SizedBox(),
                        Divider(),
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Text(
                                "Total",
                                style: TextStyle(
                                    fontWeight:
                                    FontWeight
                                        .w700,
                                    fontSize:
                                    14.0),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                "₹${getPrice(model.totalPriceList![0].fd!)}",
                                textAlign:
                                TextAlign
                                    .end,
                                style: TextStyle(
                                    fontWeight:
                                    FontWeight
                                        .w700,
                                    fontSize:
                                    14.0),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ) else SizedBox(),
                  model.activeTab == "Rules" &&
                      rules != null
                      ? Container(
                    padding:
                    EdgeInsets.all(10),
                    child: Column(
                      children: [
                        rules!.cANCELLATION !=
                            null
                            ? Column(
                          crossAxisAlignment:
                          CrossAxisAlignment
                              .start,
                          children: [
                            Text(
                              "Cancellation Fee",
                              style: TextStyle(
                                  fontWeight: FontWeight
                                      .w700,
                                  color: Colors
                                      .black,
                                  fontSize:
                                  14.0),
                            ),
                            SizedBox(
                              height:
                              10,
                            ),
                            Text(
                              rules!
                                  .cANCELLATION!
                                  .dEFAULT!
                                  .policyInfo!,
                              style: TextStyle(
                                  fontWeight: FontWeight
                                      .w500,
                                  color: Colors
                                      .black54,
                                  fontSize:
                                  14.0),
                            ),
                          ],
                        )
                            : SizedBox(),
                        SizedBox(
                          height: 10,
                        ),
                        rules!.dATECHANGE !=
                            null
                            ? Column(
                          crossAxisAlignment:
                          CrossAxisAlignment
                              .start,
                          children: [
                            Text(
                              "Date Change Fee",
                              style: TextStyle(
                                  fontWeight: FontWeight
                                      .w700,
                                  color: Colors
                                      .black,
                                  fontSize:
                                  14.0),
                            ),
                            SizedBox(
                              height:
                              10,
                            ),
                            Text(
                              rules!
                                  .dATECHANGE!
                                  .dEFAULT!
                                  .policyInfo!,
                              style: TextStyle(
                                  fontWeight: FontWeight
                                      .w500,
                                  color: Colors
                                      .black54,
                                  fontSize:
                                  14.0),
                            ),
                          ],
                        )
                            : SizedBox(),
                        SizedBox(
                          height: 10,
                        ),
                        rules!.noShow != null
                            ? Column(
                          crossAxisAlignment:
                          CrossAxisAlignment
                              .start,
                          children: [
                            const Text(
                              "No Show",
                              style: TextStyle(
                                  fontWeight: FontWeight
                                      .w700,
                                  color: Colors
                                      .black,
                                  fontSize:
                                  14.0),
                            ),
                            const SizedBox(
                              height:
                              10,
                            ),
                            Text(
                              rules!
                                  .noShow!
                                  .dEFAULT!
                                  .policyInfo!,
                              style: TextStyle(
                                  fontWeight: FontWeight
                                      .w500,
                                  color: Colors
                                      .black54,
                                  fontSize:
                                  14.0),
                            ),
                          ],
                        )
                            : SizedBox(),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  )
                      : SizedBox(),
                  model.activeTab == "Baggage"
                      ? Container(
                    padding:
                    EdgeInsets.all(10),
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment
                          .start,
                      children: [
                        Text(
                          "CHECKIN",
                          style: TextStyle(
                              fontWeight:
                              FontWeight
                                  .w700,
                              color: Colors
                                  .black,
                              fontSize: 14.0),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          getBaggage(
                              model
                                  .totalPriceList![
                              0]
                                  .fd!,
                              0),
                          style: TextStyle(
                              fontWeight:
                              FontWeight
                                  .w500,
                              color: Colors
                                  .black54,
                              fontSize: 14.0),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "CABIN",
                          style: TextStyle(
                              fontWeight:
                              FontWeight
                                  .w700,
                              color: Colors
                                  .black,
                              fontSize: 14.0),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          getBaggage(
                              model
                                  .totalPriceList![
                              0]
                                  .fd!,
                              1),
                          style: TextStyle(
                              fontWeight:
                              FontWeight
                                  .w500,
                              color: Colors
                                  .black54,
                              fontSize: 14.0),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  )
                      : SizedBox(),
                ],
              ),
            )
                : SizedBox();

            return InkWell(
              onTap: () {
                setState(() {
                  flightList1?.forEach((element) {
                    element.selected = false;
                  });
                  flightList1[index].selected = true;
                  totalFare = model.totalPriceList![0].fd!
                      .aDULT!.fC!.bF
                      .toString();
                });
              },
              child: Card(
                color: isSelected
                    ? colors.secondary.withOpacity(0.0)
                    : colors.whiteTemp,
                elevation: 2,
                child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          Text(
                              '${model.sI![0].fD!.aI!.name}'),
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment
                                .spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    '${model.sI![0].dt?.substring(11, 16)}',
                                    style: TextStyle(
                                        color:
                                        colors.blackTemp,
                                        fontWeight:
                                        FontWeight.bold),
                                  ),
                                  Text(
                                      '${model.sI![0].da!.code}'),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(convertTime(
                                      model.sI![0].duration)),
                                  SizedBox(
                                    width: 3,
                                  ),
                                  SizedBox(
                                      width: 80,
                                      child: Divider(
                                        thickness: 1,
                                        color: colors.black54,
                                      )),
                                  SizedBox(
                                    width: 3,
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    '${model.sI![0].at?.substring(11, 16)}',
                                    style: TextStyle(
                                        color:
                                        colors.blackTemp,
                                        fontWeight:
                                        FontWeight.bold),
                                  ),
                                  Text(
                                      '${model.sI![0].aa!.code}'),
                                ],
                              ),
                              Text(
                                  '₹${model.totalPriceList![0].fd!.aDULT!.fC!.bF.toString()}'),

                              // SizedBox(width: 2,),
                              // Text('(${model.sI![0].da!.terminal})'),
                              // SizedBox(width: 3,),
                              // SizedBox(width: 10,
                              //     child: Divider(thickness: 1,color: colors.black54,)),
                              // SizedBox(width: 3,),
                              // Text('${model.sI![0].aa!.code}'),
                              // SizedBox(width: 2,),
                              // Text('(${model.sI![0].aa!.terminal})'),
                            ],
                          ),
                        ],
                      ),
                    )),
              ),
            );
          }),
    );


  }

  getFlightListView3 (List <FlightModel> flightList){

    //print('${flightList.first.sI?.first.id}_______');

    return Expanded(
      child: ListView.separated(
          separatorBuilder: (context, index) =>
              SizedBox(),
          // Divider(thickness: 1,color: colors.blackTemp.withOpacity(0.2),
          // ),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          padding: const EdgeInsets.all(8),
          itemCount: flightList.length,
          itemBuilder: (BuildContext context, int index) {
            FlightModel model = flightList[index];
            bool isSelected = model.selected!;
            if (getSeat(model.totalPriceList![0].fd!) >
                0) {
              return Container(
              margin: EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                  BorderRadius.circular(5.0),
                  border: Border.all(
                      color: Colors.grey)),
              child: ExpansionTile(
                leading: IconButton(
                  icon: Icon(
                    flightList[index].selected!
                        ? Icons.radio_button_checked
                        : Icons
                        .radio_button_unchecked,
                    color: Colors.deepOrange,
                  ),
                  onPressed: () {
                    finalFlightDetailData.clear();

                    setState(() {
                      flightList
                          .forEach((element) {
                        element.selected = false;
                      });
                      selectedIndex2 = index;
                      flightList[index].selected =
                      true;
                      if(flightList[index].selected ?? false){

                      }
                      
                      totalFare = getPrice(model
                          .totalPriceList![0].fd!);
                      // print(totalFare);

                      finalFare = double.parse(totalFare);

                    });
                  },
                ),
                title: Text(
                  model.sI![0].fD!.aI!.name
                      .toString(),
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                subtitle: Text(
                  "${model.sI![0].fD!.aI!.code}-${model.sI![0].fD!.fN}",
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.black54,
                  ),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InkWell(


                      onTap: () async {

                        if(flightList[index].selected ?? false){
                          if(tabController!.index+1 < tabController!.length)
                            {
                              tabController?.animateTo((tabController!.index + 1));
                              setState(() {

                              });
                            }else {
                            Fluttertoast.showToast(msg: 'Press continue button');
                          }

                         //
                        }else{
                          Fluttertoast.showToast(msg: 'select a flight');
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.deepOrange,
                          borderRadius:
                          BorderRadius.circular(
                              5.0),
                        ),
                        padding:
                        const EdgeInsets.all(
                            10),
                        child: Text(
                          "BOOK ₹${getPrice(model.totalPriceList![0].fd!)}",
                          style: const TextStyle(
                            fontWeight:
                            FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const Icon(
                      Icons
                          .keyboard_arrow_down_outlined,
                      size: 24,
                    ),
                  ],
                ),
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              model.activeTab =
                              "Details";
                            });
                          },
                          child: Container(
                            padding:
                            EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text(
                                  "Details",
                                  style: TextStyle(
                                    fontWeight:
                                    FontWeight
                                        .w700,
                                    color: model.activeTab ==
                                        "Details"
                                        ? Colors
                                        .deepOrange
                                        : Colors
                                        .black,
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Divider(
                                  thickness: 3,
                                  height: 5,
                                  color: model.activeTab ==
                                      "Details"
                                      ? Colors
                                      .deepOrange
                                      : Colors
                                      .black,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              model.activeTab =
                              "Prices";
                            });
                          },
                          child: Container(
                            padding:
                            EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text(
                                  "Prices",
                                  style: TextStyle(
                                    fontWeight:
                                    FontWeight
                                        .w700,
                                    color: model.activeTab ==
                                        "Prices"
                                        ? Colors
                                        .deepOrange
                                        : Colors
                                        .black,
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Divider(
                                  thickness: 3,
                                  height: 5,
                                  color: model.activeTab ==
                                      "Prices"
                                      ? Colors
                                      .deepOrange
                                      : Colors
                                      .black,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              model.activeTab =
                              "Rules";
                            });
                            getRule(model
                                .totalPriceList![0]
                                .id
                                .toString());
                          },
                          child: Container(
                            padding:
                            EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text(
                                  "Rules",
                                  style: TextStyle(
                                    fontWeight:
                                    FontWeight
                                        .w700,
                                    color: model.activeTab ==
                                        "Rules"
                                        ? Colors
                                        .deepOrange
                                        : Colors
                                        .black,
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Divider(
                                  thickness: 3,
                                  height: 5,
                                  color: model.activeTab ==
                                      "Rules"
                                      ? Colors
                                      .deepOrange
                                      : Colors
                                      .black,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              model.activeTab =
                              "Baggage";
                            });
                          },
                          child: Container(
                            padding:
                            EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text(
                                  "Baggage",
                                  style: TextStyle(
                                    fontWeight:
                                    FontWeight
                                        .w700,
                                    color: model.activeTab ==
                                        "Baggage"
                                        ? Colors
                                        .deepOrange
                                        : Colors
                                        .black,
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Divider(
                                  thickness: 3,
                                  height: 5,
                                  color: model.activeTab ==
                                      "Baggage"
                                      ? Colors
                                      .deepOrange
                                      : Colors
                                      .black,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Divider(),
                  model.activeTab == "Details"
                      ? Container(
                    padding:
                    EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              model.sI![0].da!
                                  .city
                                  .toString()
                                  .toString(),
                              style: TextStyle(
                                  fontWeight:
                                  FontWeight
                                      .w700,
                                  fontSize:
                                  16.0),
                            ),
                            Icon(Icons
                                .arrow_forward),
                            Text(
                              model.sI![0].aa!
                                  .city
                                  .toString(),
                              style: TextStyle(
                                  fontWeight:
                                  FontWeight
                                      .w700,
                                  fontSize:
                                  16.0),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              DateFormat
                                  .yMMMEd()
                                  .format(DateTime
                                  .parse(model
                                  .sI![0]
                                  .dt
                                  .toString())),
                              style: TextStyle(
                                  fontWeight:
                                  FontWeight
                                      .w700,
                                  color: Colors
                                      .black54,
                                  fontSize:
                                  16.0),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    getDateFormat(model
                                        .sI![
                                    0]
                                        .dt
                                        .toString()),
                                    style: TextStyle(
                                        fontWeight: FontWeight
                                            .w700,
                                        fontSize:
                                        12.0),
                                  ),
                                  Text(
                                    "${model.sI![0].da!.city.toString()},${model.sI![0].da!.country.toString()}",
                                    style: TextStyle(
                                        fontWeight: FontWeight
                                            .w700,
                                        color: Colors
                                            .black54,
                                        fontSize:
                                        12.0),
                                  ),
                                  Text(
                                    model
                                        .sI![
                                    0]
                                        .da!
                                        .name
                                        .toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight
                                            .w700,
                                        color: Colors
                                            .black54,
                                        fontSize:
                                        12.0),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                Icon(Icons
                                    .arrow_forward),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  durationToString(int.parse(model
                                      .sI![0]
                                      .duration
                                      .toString())),
                                  style: TextStyle(
                                      fontWeight:
                                      FontWeight
                                          .w700,
                                      fontSize:
                                      12.0),
                                ),
                              ],
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    getDateFormat(model
                                        .sI![
                                    0]
                                        .at
                                        .toString()),
                                    style: TextStyle(
                                        fontWeight: FontWeight
                                            .w700,
                                        fontSize:
                                        12.0),
                                  ),
                                  Text(
                                    "${model.sI![0].aa!.city.toString()},${model.sI![0].aa!.country.toString()}",
                                    style: TextStyle(
                                        fontWeight: FontWeight
                                            .w700,
                                        color: Colors
                                            .black54,
                                        fontSize:
                                        12.0),
                                  ),
                                  Text(
                                    model
                                        .sI![
                                    0]
                                        .aa!
                                        .name
                                        .toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight
                                            .w700,
                                        color: Colors
                                            .black54,
                                        fontSize:
                                        12.0),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "${getSeat(model.totalPriceList![0].fd!)} seat(s) left",
                                style: TextStyle(
                                    fontWeight:
                                    FontWeight
                                        .w700,
                                    color: Colors
                                        .orange,
                                    fontSize:
                                    16.0),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                getClass(model
                                    .totalPriceList![
                                0]
                                    .fd!),
                                textAlign:
                                TextAlign
                                    .end,
                                style: TextStyle(
                                    fontWeight:
                                    FontWeight
                                        .w700,
                                    color: Colors
                                        .orange,
                                    fontSize:
                                    16.0),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                      : SizedBox(),
                  if (model.activeTab == "Prices") Container(
                    padding:
                    EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Text(
                                "TYPE",
                                style: TextStyle(
                                    fontWeight:
                                    FontWeight
                                        .w700,
                                    fontSize:
                                    16.0),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                "FARE",
                                style: TextStyle(
                                    fontWeight:
                                    FontWeight
                                        .w700,
                                    fontSize:
                                    16.0),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                "TOTAL",
                                textAlign:
                                TextAlign
                                    .end,
                                style: TextStyle(
                                    fontWeight:
                                    FontWeight
                                        .w700,
                                    fontSize:
                                    16.0),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        model.totalPriceList![0]
                            .fd!.aDULT !=
                            null
                            ? Column(
                          crossAxisAlignment:
                          CrossAxisAlignment
                              .start,
                          children: [
                            Text(
                              "Fare Details for Adult",
                              style: TextStyle(
                                  fontWeight: FontWeight
                                      .w500,
                                  color: Colors
                                      .black54,
                                  fontSize:
                                  14.0),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  flex:
                                  2,
                                  child:
                                  Text(
                                    "Base Price",
                                    style:
                                    TextStyle(fontWeight: FontWeight.w700, fontSize: 14.0),
                                  ),
                                ),
                                Expanded(
                                  child:
                                  Text(
                                    "₹${getBasePrice(model.totalPriceList![0].fd!, 0)}x${widget.adults}",
                                    style:
                                    TextStyle(fontWeight: FontWeight.w700, fontSize: 14.0),
                                  ),
                                ),
                                Expanded(
                                  child:
                                  Text(
                                    "₹${getBasePrice(model.totalPriceList![0].fd!, 0) * double.parse(widget.adults!)}",
                                    textAlign:
                                    TextAlign.end,
                                    style:
                                    TextStyle(fontWeight: FontWeight.w700, fontSize: 14.0),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  flex:
                                  2,
                                  child:
                                  Text(
                                    "Taxes and Fees",
                                    style:
                                    TextStyle(fontWeight: FontWeight.w700, fontSize: 14.0),
                                  ),
                                ),
                                Expanded(
                                  child:
                                  Text(
                                    "₹${getTax(model.totalPriceList![0].fd!, 0)}x${widget.adults}",
                                    style:
                                    TextStyle(fontWeight: FontWeight.w700, fontSize: 14.0),
                                  ),
                                ),
                                Expanded(
                                  child:
                                  Text(
                                    "₹${getTax(model.totalPriceList![0].fd!, 0) * double.parse(widget.adults!)}",
                                    textAlign:
                                    TextAlign.end,
                                    style:
                                    TextStyle(fontWeight: FontWeight.w700, fontSize: 14.0),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                            : SizedBox(),
                        SizedBox(
                          height: 10,
                        ),
                        model.totalPriceList![0]
                            .fd!.child !=
                            null
                            ? Column(
                          crossAxisAlignment:
                          CrossAxisAlignment
                              .start,
                          children: [
                            Text(
                              "Fare Details for Child",
                              style: TextStyle(
                                  fontWeight: FontWeight
                                      .w500,
                                  color: Colors
                                      .black54,
                                  fontSize:
                                  14.0),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  flex:
                                  2,
                                  child:
                                  Text(
                                    "Base Price",
                                    style:
                                    TextStyle(fontWeight: FontWeight.w700, fontSize: 14.0),
                                  ),
                                ),
                                Expanded(
                                  child:
                                  Text(
                                    "₹${getBasePrice(model.totalPriceList![0].fd!, 2)}x${widget.child}",
                                    style:
                                    TextStyle(fontWeight: FontWeight.w700, fontSize: 14.0),
                                  ),
                                ),
                                Expanded(
                                  child:
                                  Text(
                                    "₹${getBasePrice(model.totalPriceList![0].fd!, 2) * double.parse(widget.child!)}",
                                    textAlign:
                                    TextAlign.end,
                                    style:
                                    TextStyle(fontWeight: FontWeight.w700, fontSize: 14.0),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  flex:
                                  2,
                                  child:
                                  Text(
                                    "Taxes and Fees",
                                    style:
                                    TextStyle(fontWeight: FontWeight.w700, fontSize: 14.0),
                                  ),
                                ),
                                Expanded(
                                  child:
                                  Text(
                                    "₹${getTax(model.totalPriceList![0].fd!, 2)}x${widget.child}",
                                    style:
                                    TextStyle(fontWeight: FontWeight.w700, fontSize: 14.0),
                                  ),
                                ),
                                Expanded(
                                  child:
                                  Text(
                                    "₹${getTax(model.totalPriceList![0].fd!, 2) * double.parse(widget.child!)}",
                                    textAlign:
                                    TextAlign.end,
                                    style:
                                    TextStyle(fontWeight: FontWeight.w700, fontSize: 14.0),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                            : const SizedBox(),
                        SizedBox(
                          height: 10,
                        ),
                        model.totalPriceList![0].fd!
                            .infant !=
                            null
                            ? Column(
                          crossAxisAlignment:
                          CrossAxisAlignment
                              .start,
                          children: [
                            Text(
                              "Fare Details for Infant",
                              style: TextStyle(
                                  fontWeight: FontWeight
                                      .w500,
                                  color: Colors
                                      .black54,
                                  fontSize:
                                  14.0),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  flex:
                                  2,
                                  child:
                                  Text(
                                    "Base Price",
                                    style:
                                    TextStyle(fontWeight: FontWeight.w700, fontSize: 14.0),
                                  ),
                                ),
                                Expanded(
                                  child:
                                  Text(
                                    "₹${getBasePrice(model.totalPriceList![0].fd!, 1)}x${widget.seniur}",
                                    style:
                                    TextStyle(fontWeight: FontWeight.w700, fontSize: 14.0),
                                  ),
                                ),
                                Expanded(
                                  child:
                                  Text(
                                    "₹${getBasePrice(model.totalPriceList![0].fd!, 1) * double.parse(widget.seniur!)}",
                                    textAlign:
                                    TextAlign.end,
                                    style:
                                    TextStyle(fontWeight: FontWeight.w700, fontSize: 14.0),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  flex:
                                  2,
                                  child:
                                  Text(
                                    "Taxes and Fees",
                                    style:
                                    TextStyle(fontWeight: FontWeight.w700, fontSize: 14.0),
                                  ),
                                ),
                                Expanded(
                                  child:
                                  Text(
                                    "₹${getTax(model.totalPriceList![0].fd!, 1)}x${widget.seniur}",
                                    style:
                                    TextStyle(fontWeight: FontWeight.w700, fontSize: 14.0),
                                  ),
                                ),
                                Expanded(
                                  child:
                                  Text(
                                    "₹${getTax(model.totalPriceList![0].fd!, 1) * double.parse(widget.seniur!)}",
                                    textAlign:
                                    TextAlign.end,
                                    style:
                                    TextStyle(fontWeight: FontWeight.w700, fontSize: 14.0),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                            : SizedBox(),
                        Divider(),
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Text(
                                "Total",
                                style: TextStyle(
                                    fontWeight:
                                    FontWeight
                                        .w700,
                                    fontSize:
                                    14.0),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                "₹${getPrice(model.totalPriceList![0].fd!)}",
                                textAlign:
                                TextAlign
                                    .end,
                                style: TextStyle(
                                    fontWeight:
                                    FontWeight
                                        .w700,
                                    fontSize:
                                    14.0),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ) else SizedBox(),
                  model.activeTab == "Rules" &&
                      rules != null
                      ? Container(
                    padding:
                    EdgeInsets.all(10),
                    child: Column(
                      children: [
                        rules!.cANCELLATION !=
                            null
                            ? Column(
                          crossAxisAlignment:
                          CrossAxisAlignment
                              .start,
                          children: [
                            Text(
                              "Cancellation Fee",
                              style: TextStyle(
                                  fontWeight: FontWeight
                                      .w700,
                                  color: Colors
                                      .black,
                                  fontSize:
                                  14.0),
                            ),
                            SizedBox(
                              height:
                              10,
                            ),
                            Text(
                              rules!
                                  .cANCELLATION!
                                  .dEFAULT!
                                  .policyInfo!,
                              style: TextStyle(
                                  fontWeight: FontWeight
                                      .w500,
                                  color: Colors
                                      .black54,
                                  fontSize:
                                  14.0),
                            ),
                          ],
                        )
                            : SizedBox(),
                        SizedBox(
                          height: 10,
                        ),
                        rules!.dATECHANGE !=
                            null
                            ? Column(
                          crossAxisAlignment:
                          CrossAxisAlignment
                              .start,
                          children: [
                            Text(
                              "Date Change Fee",
                              style: TextStyle(
                                  fontWeight: FontWeight
                                      .w700,
                                  color: Colors
                                      .black,
                                  fontSize:
                                  14.0),
                            ),
                            SizedBox(
                              height:
                              10,
                            ),
                            Text(
                              rules!
                                  .dATECHANGE!
                                  .dEFAULT!
                                  .policyInfo!,
                              style: TextStyle(
                                  fontWeight: FontWeight
                                      .w500,
                                  color: Colors
                                      .black54,
                                  fontSize:
                                  14.0),
                            ),
                          ],
                        )
                            : SizedBox(),
                        SizedBox(
                          height: 10,
                        ),
                        rules!.noShow != null
                            ? Column(
                          crossAxisAlignment:
                          CrossAxisAlignment
                              .start,
                          children: [
                            const Text(
                              "No Show",
                              style: TextStyle(
                                  fontWeight: FontWeight
                                      .w700,
                                  color: Colors
                                      .black,
                                  fontSize:
                                  14.0),
                            ),
                            const SizedBox(
                              height:
                              10,
                            ),
                            Text(
                              rules!
                                  .noShow!
                                  .dEFAULT!
                                  .policyInfo!,
                              style: TextStyle(
                                  fontWeight: FontWeight
                                      .w500,
                                  color: Colors
                                      .black54,
                                  fontSize:
                                  14.0),
                            ),
                          ],
                        )
                            : SizedBox(),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  )
                      : SizedBox(),
                  model.activeTab == "Baggage"
                      ? Container(
                    padding:
                    EdgeInsets.all(10),
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment
                          .start,
                      children: [
                        Text(
                          "CHECKIN",
                          style: TextStyle(
                              fontWeight:
                              FontWeight
                                  .w700,
                              color: Colors
                                  .black,
                              fontSize: 14.0),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          getBaggage(
                              model
                                  .totalPriceList![
                              0]
                                  .fd!,
                              0),
                          style: TextStyle(
                              fontWeight:
                              FontWeight
                                  .w500,
                              color: Colors
                                  .black54,
                              fontSize: 14.0),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "CABIN",
                          style: TextStyle(
                              fontWeight:
                              FontWeight
                                  .w700,
                              color: Colors
                                  .black,
                              fontSize: 14.0),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          getBaggage(
                              model
                                  .totalPriceList![
                              0]
                                  .fd!,
                              1),
                          style: TextStyle(
                              fontWeight:
                              FontWeight
                                  .w500,
                              color: Colors
                                  .black54,
                              fontSize: 14.0),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  )
                      : SizedBox(),
                ],
              ),
            );
            } else {
              return SizedBox();
            }

            return InkWell(
              onTap: () {
                setState(() {
                  flightList1?.forEach((element) {
                    element.selected = false;
                  });
                  flightList1[index].selected = true;
                  totalFare = model.totalPriceList![0].fd!
                      .aDULT!.fC!.bF
                      .toString();
                });
              },
              child: Card(
                color: isSelected
                    ? colors.secondary.withOpacity(0.0)
                    : colors.whiteTemp,
                elevation: 2,
                child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          Text(
                              '${model.sI![0].fD!.aI!.name}'),
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment
                                .spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    '${model.sI![0].dt?.substring(11, 16)}',
                                    style: TextStyle(
                                        color:
                                        colors.blackTemp,
                                        fontWeight:
                                        FontWeight.bold),
                                  ),
                                  Text(
                                      '${model.sI![0].da!.code}'),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(convertTime(
                                      model.sI![0].duration)),
                                  SizedBox(
                                    width: 3,
                                  ),
                                  SizedBox(
                                      width: 80,
                                      child: Divider(
                                        thickness: 1,
                                        color: colors.black54,
                                      )),
                                  SizedBox(
                                    width: 3,
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    '${model.sI![0].at?.substring(11, 16)}',
                                    style: TextStyle(
                                        color:
                                        colors.blackTemp,
                                        fontWeight:
                                        FontWeight.bold),
                                  ),
                                  Text(
                                      '${model.sI![0].aa!.code}'),
                                ],
                              ),
                              Text(
                                  '₹${model.totalPriceList![0].fd!.aDULT!.fC!.bF.toString()}'),

                              // SizedBox(width: 2,),
                              // Text('(${model.sI![0].da!.terminal})'),
                              // SizedBox(width: 3,),
                              // SizedBox(width: 10,
                              //     child: Divider(thickness: 1,color: colors.black54,)),
                              // SizedBox(width: 3,),
                              // Text('${model.sI![0].aa!.code}'),
                              // SizedBox(width: 2,),
                              // Text('(${model.sI![0].aa!.terminal})'),
                            ],
                          ),
                        ],
                      ),
                    )),
              ),
            );
          }),
    );


  }



  String getPrice(Fd model) {
    print('${model.aDULT!.fC!.tF}__________');
    double totalPrice = 0;
    if (model.aDULT != null) {
      totalPrice += model.aDULT!.fC!.tF! * double.parse(widget.adults!);
    }
    if (model.infant != null) {
      totalPrice += model.infant!.fC!.tF! * double.parse(widget.seniur!);
    }
    if (model.child != null) {
      totalPrice += model.child!.fC!.tF! * double.parse(widget.child!);
    }
    return "${totalPrice.toStringAsFixed(2)}";
  }

  FareRule? rules;

  void getRule(String id) async {
    setState(() {
      rules = null;
    });
    var headers = {
      'Content-Type': 'application/json',
      'apikey': '812146ac5e380f-ed6f-4a76-a035-314f4255eddb'
    };
    var body = {"id": id, "flowType": "SEARCH"};
    var response = await http.post(Uri.parse('${flightUrl}fms/v1/farerule'),
        body: jsonEncode(body), headers: headers);
    print(response.body);
    Map data = jsonDecode(response.body);
    if (data['status']['httpStatus'] == 200) {
      Map v = data['fareRule'];
      print(v.values.elementAt(0));
      setState(() {
        rules = FareRule.fromJson(v.values.elementAt(0)['fr']);
      });
    } else {}
  }
}

int getSeat(Fd model) {
  int totalSeat = 0;
  if (model.aDULT != null && model.aDULT!.sR != null) {
    print("okayty");
    totalSeat += model.aDULT!.sR!;
  }
  if (model.infant != null && model.infant!.sR != null) {
    totalSeat += model.infant!.sR!;
  }
  if (model.child != null && model.child!.sR != null) {
    totalSeat += model.child!.sR!;
  }
  return totalSeat;
}

String getClass(Fd model) {
  String totalClass = "";
  if (model.aDULT != null && model.aDULT!.sR != null) {
    totalClass += model.aDULT!.cc!;
  }
  if (model.infant != null && model.infant!.sR != null) {
    totalClass = model.infant!.cc!;
  }
  if (model.child != null && model.child!.sR != null) {
    totalClass = model.child!.cc!;
  }
  return "${totalClass.toString()}";
}

String getBaggage(Fd model, int i) {
  String totalClass = "";
  if (model.aDULT != null && model.aDULT!.bI != null) {
    if (i == 0) {
      totalClass += "Adult : ${model.aDULT!.bI!.iB!},\n";
    } else {
      totalClass += "Adult : ${model.aDULT!.bI!.cB!},\n";
    }
  }
  if (model.child != null && model.child!.bI != null) {
    if (i == 0) {
      totalClass += "Child : ${model.child!.bI!.iB!},\n";
    } else {
      totalClass += "Child : ${model.child!.bI!.cB!},\n";
    }
  }
  if (model.infant != null && model.infant!.bI != null) {
    if (i == 0) {
      totalClass += model.infant!.bI!.iB != null
          ? "Infant : ${model.infant!.bI!.iB!},\n"
          : "\n";
    } else {
      totalClass += model.infant!.bI!.cB != null
          ? "Infant : ${model.infant!.bI!.cB!},\n"
          : "\n";
    }
  }

  return "${totalClass.toString()}";
}

double getBasePrice(Fd model, int i) {
  double totalPrice = 0;
  if (i == 0 && model.aDULT != null) {
    totalPrice += model.aDULT!.fC!.bF!;
  }
  if (i == 1 && model.infant != null) {
    totalPrice += model.infant!.fC!.bF!;
  }
  if (i == 2 && model.child != null) {
    totalPrice += model.child!.fC!.bF!;
  }
  return totalPrice;
}

String getDateFormat(String temp) {
  String dateFormat =
      "${DateFormat.MMMEd().format(DateTime.parse(temp))}, ${DateFormat.jm().format(DateTime.parse(temp))}";
  return dateFormat;
}

String durationToString(int minutes) {
  var d = Duration(minutes: minutes);
  List<String> parts = d.toString().split(':');
  return '${parts[0].padLeft(2, '0')}h ${parts[1].padLeft(2, '0')}m';
}

double getTax(Fd model, int i) {
  double totalPrice = 0;
  if (i == 0 && model.aDULT != null && model.aDULT!.sR != null) {
    totalPrice += model.aDULT!.fC!.tAF!;
  }
  if (i == 1 && model.infant != null && model.infant!.sR != null) {
    totalPrice += model.infant!.fC!.tAF!;
  }
  if (i == 2 && model.child != null && model.child!.sR != null) {
    totalPrice += model.child!.fC!.tAF!;
  }
  return totalPrice;
}
