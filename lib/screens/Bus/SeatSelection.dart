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
import 'package:parry_trip2/screens/Bus/bus_book_screen.dart';
import 'package:parry_trip2/screens/FLight/FlightList.dart';

import '../../model/bus_model/seat_model.dart';

class SeatSelectionScreen extends StatefulWidget {
  String? trackId, resultIndex, from, to;
  BusResult? busResult;
  SeatSelectionScreen(
      {this.busResult, this.trackId, this.resultIndex, this.from, this.to});

  @override
  State<SeatSelectionScreen> createState() => _SeatSelectionScreenState();
}

class _SeatSelectionScreenState extends State<SeatSelectionScreen>
    with SingleTickerProviderStateMixin {
  TabController? tabController;
  List<List<SeatDetail>> seatLayoutList = [];
  SeatModel? seatModel;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 3, vsync: this);
    seatLayout();
    boarding();
  }

  Widget popupMenu() {
    return PopupMenuButton(
      onSelected: (value) {
        // your logic
      },
      itemBuilder: (BuildContext bc) {
        return [
          PopupMenuItem(
            child: Row(
              children: [
                Container(
                  height: 20,
                  width: 20,
                  color: Colors.black,
                ),
                SizedBox(
                  width: 5.0,
                ),
                Text("Available"),
              ],
            ),
            value: 'Available',
          ),
          PopupMenuItem(
            child: Row(
              children: [
                Container(
                  height: 20,
                  width: 20,
                  color: Colors.pink,
                ),
                SizedBox(
                  width: 5.0,
                ),
                Text("Ladies"),
              ],
            ),
            value: 'Ladies',
          ),
          PopupMenuItem(
            child: Row(
              children: [
                Container(
                  height: 20,
                  width: 20,
                  color: Colors.green,
                ),
                SizedBox(
                  width: 5.0,
                ),
                Text("Selected"),
              ],
            ),
            value: 'Selected',
          ),
          PopupMenuItem(
            child: Row(
              children: [
                Container(
                  height: 20,
                  width: 20,
                  color: Colors.grey,
                ),
                SizedBox(
                  width: 5.0,
                ),
                Text("Booked"),
              ],
            ),
            value: 'Booked',
          ),
        ];
      },
    );
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
      bottomNavigationBar: !loading && seatModel != null
          ? Container(
              padding: EdgeInsets.all(15.0),
              color: Colors.white,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  boardList.isNotEmpty
                      ? Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15.0,
                          ),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5.0),
                              border: Border.all(color: Colors.grey)),
                          child: DropdownButton<String>(
                            focusColor: Colors.white,
                            isExpanded: true,
                            underline: SizedBox(),
                            value: selectBoarding,
                            //elevation: 5,
                            style: TextStyle(color: Colors.white),
                            iconEnabledColor: Colors.black,
                            items: boardList.map<DropdownMenuItem<String>>(
                                (BoardingModel e) {
                              return DropdownMenuItem<String>(
                                value: e.cityPointIndex.toString(),
                                child: Text(
                                  "${e.cityPointName}-${DateFormat.jm().format(DateTime.parse(e.cityPointTime!))}",
                                  style: TextStyle(color: Colors.black),
                                ),
                              );
                            }).toList(),
                            hint: Text(
                              "Select Boarding Point",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500),
                            ),
                            onChanged: (String? value) {
                              setState(() {
                                selectBoarding = value;
                              });
                            },
                          ),
                        )
                      : SizedBox(),
                  SizedBox(
                    height: 8,
                  ),
                  dropList.isNotEmpty
                      ? Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15.0,
                          ),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5.0),
                              border: Border.all(color: Colors.grey)),
                          child: DropdownButton<String>(
                            focusColor: Colors.white,
                            isExpanded: true,
                            underline: SizedBox(),
                            value: selectDrop,
                            //elevation: 5,
                            style: TextStyle(color: Colors.white),
                            iconEnabledColor: Colors.black,
                            items: dropList.map<DropdownMenuItem<String>>(
                                (BoardingModel e) {
                              return DropdownMenuItem<String>(
                                value: e.cityPointIndex.toString(),
                                child: Text(
                                  "${e.cityPointName}-${DateFormat.jm().format(DateTime.parse(e.cityPointTime!))}",
                                  style: TextStyle(color: Colors.black),
                                ),
                              );
                            }).toList(),
                            hint: Text(
                              "Select Dropping Point",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500),
                            ),
                            onChanged: (String? value) {
                              setState(() {
                                selectDrop = value;
                              });
                            },
                          ),
                        )
                      : SizedBox(),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          "Seat(s) :",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 16.0),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "${seatModel!.availableSeats}",
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
                          "Amount :",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 16.0),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "₹${amount}",
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BusBookPage(
                              trackId: widget.trackId,
                              resultIndex: widget.resultIndex,
                              busResult: widget.busResult,
                              from: widget.from,
                              to: widget.to,
                              selectedSeat: selectedList.toList(),
                              boardingIndex: selectBoarding,
                              droppingIndex: selectDrop,
                            ),
                          ));
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
          ? seatModel != null
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                      Expanded(
                          child: TabBarView(
                              physics: NeverScrollableScrollPhysics(),
                              controller: tabController,
                              children: [
                            SingleChildScrollView(
                                child: Container(
                              padding: EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  seatModel!.seatLayout!.upperDetails!.length >
                                          0
                                      ? Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'Upper Seats',
                                                  style: TextStyle(
                                                    fontSize: 14.0,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                popupMenu(),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            ListView.builder(
                                                shrinkWrap: true,
                                                physics:
                                                    NeverScrollableScrollPhysics(),
                                                itemCount: seatModel!
                                                    .seatLayout!
                                                    .upperDetails!
                                                    .length,
                                                itemBuilder: (context, index) {
                                                  List<SeatInfoModel> model =
                                                      seatModel!.seatLayout!
                                                          .upperDetails![index];
                                                  return SingleChildScrollView(
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    child: Container(
                                                      height: 90,
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: model.map(
                                                            (SeatInfoModel e) {
                                                          int i = model.indexWhere(
                                                              (element) =>
                                                                  element
                                                                      .columnNo ==
                                                                  e.columnNo);
                                                          return InkWell(
                                                            onTap: () {
                                                              if (e
                                                                  .seatStatus!) {
                                                                if (e
                                                                    .selected!) {
                                                                  setState(() {
                                                                    seatModel!
                                                                        .seatLayout!
                                                                        .upperDetails![
                                                                            index]
                                                                            [i]
                                                                        .selected = false;
                                                                    amount = (double.parse(amount) -
                                                                            seatModel!.seatLayout!.upperDetails![index][i].seatFare!)
                                                                        .roundToDouble()
                                                                        .toString();
                                                                  });
                                                                  selectedList.removeAt(selectedList.indexWhere(
                                                                      (element) =>
                                                                          element
                                                                              .columnNo ==
                                                                          e.columnNo));
                                                                } else {
                                                                  setState(() {
                                                                    seatModel!
                                                                        .seatLayout!
                                                                        .upperDetails![
                                                                            index]
                                                                            [i]
                                                                        .selected = true;
                                                                    amount = (double.parse(amount) +
                                                                            seatModel!.seatLayout!.upperDetails![index][i].seatFare!)
                                                                        .roundToDouble()
                                                                        .toString();
                                                                  });
                                                                  selectedList
                                                                      .add(e);
                                                                }
                                                              }
                                                            },
                                                            child: Container(
                                                              height: 40.0 *
                                                                  e.width!,
                                                              width: 40.0 *
                                                                  e.height!,
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      right: 8,
                                                                      bottom:
                                                                          8.0),
                                                              decoration:
                                                                  BoxDecoration(
                                                                border:
                                                                    Border.all(
                                                                  color: e.isLadiesSeat!
                                                                      ? Colors
                                                                          .pink
                                                                      : Colors
                                                                          .black,
                                                                ),
                                                                color: e
                                                                        .seatStatus!
                                                                    ? e
                                                                            .selected!
                                                                        ? Colors
                                                                            .green
                                                                        : Colors
                                                                            .transparent
                                                                    : Colors
                                                                        .grey,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5.0),
                                                              ),
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(5.0),
                                                              child: Row(
                                                                mainAxisAlignment: e
                                                                            .height! ==
                                                                        e.width!
                                                                    ? MainAxisAlignment
                                                                        .end
                                                                    : e.height! >
                                                                            e
                                                                                .width!
                                                                        ? MainAxisAlignment
                                                                            .end
                                                                        : MainAxisAlignment
                                                                            .center,
                                                                crossAxisAlignment: e
                                                                            .height! ==
                                                                        e.width!
                                                                    ? CrossAxisAlignment
                                                                        .start
                                                                    : e.height! >
                                                                            e
                                                                                .width!
                                                                        ? CrossAxisAlignment
                                                                            .center
                                                                        : CrossAxisAlignment
                                                                            .start,
                                                                children: [
                                                                  Container(
                                                                    width: e.height! ==
                                                                            e.width!
                                                                        ? 15.0
                                                                        : e.height! > e.width!
                                                                            ? 15.0
                                                                            : 28.0 * e.height!,
                                                                    height: e.height! ==
                                                                            e
                                                                                .width!
                                                                        ? 30.0 *
                                                                            e.width!
                                                                        : e.height! > e.width!
                                                                            ? 30.0 * e.width!
                                                                            : 15.0,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      border:
                                                                          Border
                                                                              .all(
                                                                        color: e.isLadiesSeat!
                                                                            ? Colors.pink
                                                                            : Colors.black,
                                                                      ),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              5.0),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          );
                                                        }).toList(),
                                                      ),
                                                    ),
                                                  );
                                                }),
                                          ],
                                        )
                                      : SizedBox(),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  seatModel!.seatLayout!.lowerDetails!.length >
                                          0
                                      ? Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'Lower Seats',
                                                  style: TextStyle(
                                                    fontSize: 14.0,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                popupMenu(),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            ListView.builder(
                                                shrinkWrap: true,
                                                physics:
                                                    NeverScrollableScrollPhysics(),
                                                itemCount: seatModel!
                                                    .seatLayout!
                                                    .lowerDetails!
                                                    .length,
                                                itemBuilder: (context, index) {
                                                  List<SeatInfoModel> model =
                                                      seatModel!.seatLayout!
                                                          .lowerDetails![index];
                                                  return SingleChildScrollView(
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    child: Container(
                                                      height: 90,
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: model.map(
                                                            (SeatInfoModel e) {
                                                          int i = model.indexWhere(
                                                              (element) =>
                                                                  element
                                                                      .columnNo ==
                                                                  e.columnNo);
                                                          return InkWell(
                                                            onTap: () {
                                                              if (e
                                                                  .seatStatus!) {
                                                                if (e
                                                                    .selected!) {
                                                                  setState(() {
                                                                    seatModel!
                                                                        .seatLayout!
                                                                        .lowerDetails![
                                                                            index]
                                                                            [i]
                                                                        .selected = false;
                                                                    amount = (double.parse(amount) -
                                                                            seatModel!.seatLayout!.lowerDetails![index][i].seatFare!)
                                                                        .roundToDouble()
                                                                        .toString();
                                                                  });
                                                                  selectedList.removeAt(selectedList.indexWhere(
                                                                      (element) =>
                                                                          element
                                                                              .columnNo ==
                                                                          e.columnNo));
                                                                } else {
                                                                  setState(() {
                                                                    seatModel!
                                                                        .seatLayout!
                                                                        .lowerDetails![
                                                                            index]
                                                                            [i]
                                                                        .selected = true;
                                                                    amount = (double.parse(amount) +
                                                                            seatModel!.seatLayout!.lowerDetails![index][i].seatFare!)
                                                                        .roundToDouble()
                                                                        .toString();
                                                                  });
                                                                  selectedList
                                                                      .add(e);
                                                                }
                                                              }
                                                            },
                                                            child: Container(
                                                              height: 40.0 *
                                                                  e.width!,
                                                              width: 40.0 *
                                                                  e.height!,
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      right: 8,
                                                                      bottom:
                                                                          8.0),
                                                              decoration:
                                                                  BoxDecoration(
                                                                border:
                                                                    Border.all(
                                                                  color: e.isLadiesSeat!
                                                                      ? Colors
                                                                          .pink
                                                                      : Colors
                                                                          .black,
                                                                ),
                                                                color: e
                                                                        .seatStatus!
                                                                    ? e
                                                                            .selected!
                                                                        ? Colors
                                                                            .green
                                                                        : Colors
                                                                            .transparent
                                                                    : Colors
                                                                        .grey,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5.0),
                                                              ),
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(5.0),
                                                              child: Row(
                                                                mainAxisAlignment: e
                                                                            .height! ==
                                                                        e.width!
                                                                    ? MainAxisAlignment
                                                                        .end
                                                                    : e.height! >
                                                                            e
                                                                                .width!
                                                                        ? MainAxisAlignment
                                                                            .end
                                                                        : MainAxisAlignment
                                                                            .center,
                                                                crossAxisAlignment: e
                                                                            .height! ==
                                                                        e.width!
                                                                    ? CrossAxisAlignment
                                                                        .start
                                                                    : e.height! >
                                                                            e
                                                                                .width!
                                                                        ? CrossAxisAlignment
                                                                            .center
                                                                        : CrossAxisAlignment
                                                                            .start,
                                                                children: [
                                                                  Container(
                                                                    width: e.height! ==
                                                                            e.width!
                                                                        ? 15.0
                                                                        : e.height! > e.width!
                                                                            ? 15.0
                                                                            : 28.0 * e.height!,
                                                                    height: e.height! ==
                                                                            e
                                                                                .width!
                                                                        ? 30.0 *
                                                                            e.width!
                                                                        : e.height! > e.width!
                                                                            ? 30.0 * e.width!
                                                                            : 15.0,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      border:
                                                                          Border
                                                                              .all(
                                                                        color: e.isLadiesSeat!
                                                                            ? Colors.pink
                                                                            : Colors.black,
                                                                      ),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              5.0),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          );
                                                        }).toList(),
                                                      ),
                                                    ),
                                                  );
                                                }),
                                          ],
                                        )
                                      : SizedBox(),
                                ],
                              ),
                            )),
                            Container(
                              padding: EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Text(
                                    'Cancellation Policy',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Expanded(
                                    child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: widget.busResult!
                                            .cancellationPolicies!.length,
                                        itemBuilder: (context, index) {
                                          CancellationPolicy model = widget
                                              .busResult!
                                              .cancellationPolicies![index];
                                          return Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: colors.activeColor,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                            ),
                                            margin: const EdgeInsets.all(8.0),
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  flex: 3,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "Cancellation time :",
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          fontSize: 14.0,
                                                          color: colors
                                                              .activeColor,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Text(
                                                        model.policyString!,
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 12.0,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "Cancellation charges:",
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          fontSize: 14.0,
                                                          color: colors
                                                              .activeColor,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Text(
                                                        "${model.cancellationCharge.toString()}%",
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 12.0,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        }),
                                  ),
                                ],
                              ),
                            ),
                            SingleChildScrollView(
                              child: Container(
                                padding: EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Text(
                                      'Boarding Details',
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    ListView.builder(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: boardList.length,
                                        itemBuilder: (context, index) {
                                          BoardingModel model =
                                              boardList[index];
                                          return Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: colors.activeColor,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                              ),
                                              margin: const EdgeInsets.all(8.0),
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              "Boarding Point :",
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                fontSize: 14.0,
                                                                color: colors
                                                                    .activeColor,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 5,
                                                            ),
                                                            Text(
                                                              model
                                                                  .cityPointName!,
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 12.0,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              "Landmark :",
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                fontSize: 14.0,
                                                                color: colors
                                                                    .activeColor,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 5,
                                                            ),
                                                            Text(
                                                              model
                                                                  .cityPointLandmark
                                                                  .toString(),
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
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
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              "Address :",
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                fontSize: 14.0,
                                                                color: colors
                                                                    .activeColor,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 5,
                                                            ),
                                                            Text(
                                                              model
                                                                  .cityPointAddress
                                                                  .toString(),
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 12.0,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              "Time :",
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                fontSize: 14.0,
                                                                color: colors
                                                                    .activeColor,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 5,
                                                            ),
                                                            Text(
                                                              getDateFormat(model
                                                                  .cityPointTime
                                                                  .toString()),
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 12.0,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ));
                                        }),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'Dropping Details',
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    ListView.builder(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: dropList.length,
                                        itemBuilder: (context, index) {
                                          BoardingModel model = dropList[index];
                                          return Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: colors.activeColor,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                              ),
                                              margin: const EdgeInsets.all(8.0),
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              "Boarding Point :",
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                fontSize: 14.0,
                                                                color: colors
                                                                    .activeColor,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 5,
                                                            ),
                                                            Text(
                                                              model
                                                                  .cityPointName!,
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 12.0,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              "Landmark :",
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                fontSize: 14.0,
                                                                color: colors
                                                                    .activeColor,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 5,
                                                            ),
                                                            Text(
                                                              model
                                                                  .cityPointLandmark
                                                                  .toString(),
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
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
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              "Address :",
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                fontSize: 14.0,
                                                                color: colors
                                                                    .activeColor,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 5,
                                                            ),
                                                            Text(
                                                              model
                                                                  .cityPointAddress
                                                                  .toString(),
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 12.0,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              "Time :",
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                fontSize: 14.0,
                                                                color: colors
                                                                    .activeColor,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 5,
                                                            ),
                                                            Text(
                                                              getDateFormat(model
                                                                  .cityPointTime
                                                                  .toString()),
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 12.0,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ));
                                        }),
                                  ],
                                ),
                              ),
                            ),
                          ])),
                    ],
                  ),
                )
              : Center(
                  child: Text("No Seats"),
                )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  Widget buildSeatSection(List<SeatDetail> seatLayoutList) {
    List<Widget> seatRows = [];

    for (int i = 0; i < seatLayoutList.length; i++) {
      SeatDetail seat = seatLayoutList[i];

      seatRows.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(),
                  color: seat.seatStatus ?? false ? Colors.green : Colors.red,
                ),
                child: Center(
                  child: Text(
                    seat.seatName ?? '',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Row(children: seatRows);
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
