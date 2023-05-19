import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:parry_trip2/constants/ApiBaseHelper.dart';
import 'package:parry_trip2/constants/app_colors.dart';
import 'package:parry_trip2/constants/constant.dart';
import 'package:parry_trip2/model/bus_model/boardingModel.dart';
import 'package:parry_trip2/model/bus_model/bus_search_list_response.dart';
import 'package:parry_trip2/model/bus_model/seats_layout_esponse.dart';
import 'package:parry_trip2/screens/FLight/FlightList.dart';

import '../../model/bus_model/seat_model.dart';

class BusBookPage extends StatefulWidget {
  String? trackId, resultIndex, from, to, boardingIndex, droppingIndex;
  BusResult? busResult;
  List<SeatInfoModel>? selectedSeat;
  BusBookPage(
      {this.busResult,
      this.trackId,
      this.resultIndex,
      this.from,
      this.to,
      this.selectedSeat,
      this.boardingIndex,
      this.droppingIndex});

  @override
  State<BusBookPage> createState() => _BusBookPageState();
}

class _BusBookPageState extends State<BusBookPage>
    with SingleTickerProviderStateMixin {
  TabController? tabController;
  List<List<SeatDetail>> seatLayoutList = [];
  SeatModel? seatModel;
  double pubPrice = 0,
      offerPrice = 0,
      comPrice = 0,
      tdsPrice = 0,
      totalPrice = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 3, vsync: this);
    getAmount();
    // seatLayout();
    boarding();
  }

  getAmount() {
    for (int i = 0; i < widget.selectedSeat!.length; i++) {
      pubPrice += widget.selectedSeat![i].price!.publishedPrice!;
      offerPrice += widget.selectedSeat![i].price!.offeredPrice!;
      tdsPrice += widget.selectedSeat![i].price!.tDS!;
      comPrice += widget.selectedSeat![i].price!.agentCommission!;
    }
    totalPrice = offerPrice + tdsPrice + comPrice;
  }

  String? selectBoarding, selectDrop;
  List<SeatInfoModel> selectedList = [];
  String amount = "0";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bus Details'),
        backgroundColor: colors.activeColor,
        bottom: TabBar(
          isScrollable: true,
          controller: tabController!,
          onTap: (int index) {
            tabController!.animateTo(index);
          },
          indicatorColor: Colors.white,
          tabs: const [
            Tab(
              text: "Seat Details",
            ),
            Tab(
              text: "Canc. Policy",
            ),
            Tab(
              text: "Boarding Point",
            ),
          ],
        ),
      ),
      bottomNavigationBar: !loading
          ? Container(
              padding: EdgeInsets.all(15.0),
              color: Colors.white,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          "Published Price :",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 16.0),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "₹${pubPrice}",
                          textAlign: TextAlign.end,
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 16.0),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          "Offered Price :",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 16.0),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "₹${offerPrice}",
                          textAlign: TextAlign.end,
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 16.0),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          "Comm Earned :",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 16.0),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "₹${comPrice}",
                          textAlign: TextAlign.end,
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 16.0),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          "TDS :",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 16.0),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "₹${tdsPrice}",
                          textAlign: TextAlign.end,
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 16.0),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Divider(),
                  SizedBox(
                    height: 4,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          "Grand Total :",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 16.0),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "₹${totalPrice}",
                          textAlign: TextAlign.end,
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 16.0),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  InkWell(
                    onTap: () {
                      if (selectBoarding == null) {
                        Fluttertoast.showToast(msg: "Select Boarding Point");
                        return;
                      }
                      if (selectDrop == null) {
                        Fluttertoast.showToast(msg: "Select Dropping Point");
                        return;
                      }
                      if (double.parse(amount) < 1) {
                        Fluttertoast.showToast(msg: "Select Seats");
                        return;
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.deepOrange,
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      padding: const EdgeInsets.all(15),
                      child: Center(
                        child: Text(
                          "Book",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 15.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          : SizedBox(),
      body: !loading
          ? Container(
              color: Color(0xfffafafa),
              child: Column(
                children: [
                  Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: colors.activeColor,
                        ),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      margin: const EdgeInsets.all(8.0),
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Travels :",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14.0,
                                        color: colors.activeColor,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      widget.busResult!.travelName!,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Bus Type :",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14.0,
                                        color: colors.activeColor,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      widget.busResult!.busType!,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12.0,
                                      ),
                                    ),
                                  ],
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
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "From :",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14.0,
                                        color: colors.activeColor,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      widget.from!,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "To :",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14.0,
                                        color: colors.activeColor,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      widget.to!,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12.0,
                                      ),
                                    ),
                                  ],
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
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Depart :",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14.0,
                                        color: colors.activeColor,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      getDateFormat(widget
                                          .busResult!.departureTime!
                                          .toString()),
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Arrival :",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14.0,
                                        color: colors.activeColor,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      getDateFormat(widget
                                          .busResult!.arrivalTime!
                                          .toString()),
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      )),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Passenger's Details",
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  BusSeatLayoutResponse? busSeatLayoutResponse;
  ApiBaseHelper apiBaseHelper = ApiBaseHelper();
  bool loading = true;
  List<BoardingModel> boardList = [];
  List<BoardingModel> dropList = [];
  Future<void> seatLayout() async {
    const String url = '${busBookingUrl}GetBusSeatLayOut';
    final Map<String, dynamic> requestBody = {
      "EndUserIp": "192.168.5.37",
      "ResultIndex": resultIndex,
      "TraceId": widget.trackId,
      "TokenId": busToken
    };
    print(requestBody);
    var headers = {'Content-Type': 'application/json'};
    final response = await http.post(Uri.parse(url),
        headers: headers, body: jsonEncode(requestBody));
    if (response.statusCode == 307) {
      final String? redirectedUrl = response.headers['location'];
      // Send another request to the redirected URL
      final redirectedResponse = await http.post(Uri.parse(redirectedUrl ?? ''),
          headers: headers, body: jsonEncode(requestBody));
      // Process the redirected response as needed

      print(redirectedResponse.body);
      var finalResult = jsonDecode(redirectedResponse.body);
      setState(() {
        loading = false;
      });
      if (finalResult['GetBusSeatLayOutResult']['SeatLayoutDetails'] != null) {
        seatModel = SeatModel.fromJson(
            finalResult['GetBusSeatLayOutResult']['SeatLayoutDetails']);
      } else {
        String msg =
            finalResult['GetBusSeatLayOutResult']['Error']['ErrorMessage'];
        Fluttertoast.showToast(msg: msg);
      }
    }
    // var request = http.Request('POST', Uri.parse('http://api.tektravels.com/BookingEngineService_Bus/Busservice.svc/rest/GetBusSeatLayOut'));
  }

  Future<void> boarding() async {
    const String url = '${busBookingUrl}GetBoardingPointDetails';

    final Map<String, dynamic> requestBody = {
      "EndUserIp": "192.168.5.37",
      "ResultIndex": resultIndex,
      "TraceId": widget.trackId,
      "TokenId": busToken
    };
    print(requestBody);
    var headers = {'Content-Type': 'application/json'};
    final response = await http.post(Uri.parse(url),
        headers: headers, body: jsonEncode(requestBody));
    if (response.statusCode == 307) {
      final String? redirectedUrl = response.headers['location'];
      // Send another request to the redirected URL
      final redirectedResponse = await http.post(Uri.parse(redirectedUrl ?? ''),
          headers: headers, body: jsonEncode(requestBody));
      // Process the redirected response as needed

      print(redirectedResponse.body);
      var finalResult = jsonDecode(redirectedResponse.body);

      if (finalResult['GetBusRouteDetailResult']['BoardingPointsDetails'] !=
          null) {
        setState(() {
          loading = false;
          for (var v in finalResult['GetBusRouteDetailResult']
              ['BoardingPointsDetails']) {
            boardList.add(BoardingModel.fromJson(v));
          }
          for (var v in finalResult['GetBusRouteDetailResult']
              ['DroppingPointsDetails']) {
            dropList.add(BoardingModel.fromJson(v));
          }
        });
      } else {
        String msg =
            finalResult['GetBusRouteDetailResult']['Error']['ErrorMessage'];
        Fluttertoast.showToast(msg: msg);
      }
    }
    // var request = http.Request('POST', Uri.parse('http://api.tektravels.com/BookingEngineService_Bus/Busservice.svc/rest/GetBusSeatLayOut'));
  }
}

class SeatItem extends StatelessWidget {
  final String seatName;
  final bool seatStatus;
  final String seatType;

  SeatItem({
    required this.seatName,
    required this.seatStatus,
    required this.seatType,
  });

  @override
  Widget build(BuildContext context) {
    Color seatColor = Colors.green;
    if (!seatStatus) {
      seatColor = Colors.grey;
    } else if (seatType == '2') {
      seatColor = Colors.blue;
    }

    return Container(
      decoration: BoxDecoration(
        color: seatColor,
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Center(
        child: Text(
          seatName,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
