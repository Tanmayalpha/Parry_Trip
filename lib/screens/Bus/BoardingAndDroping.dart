import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:parry_trip2/model/bus_model/bus_search_list_response.dart';

class BoardingDroppingScreen extends StatefulWidget {
  const BoardingDroppingScreen({Key? key, this.boardingList, this.droppingList}) : super(key: key);

 final List <IngPointsDetail>? boardingList;
  final List <IngPointsDetail>? droppingList;

  @override
  State<BoardingDroppingScreen> createState() => _BoardingDroppingScreenState();
}

class _BoardingDroppingScreenState extends State<BoardingDroppingScreen> with SingleTickerProviderStateMixin {
  var _selectedBoardingOption;

  var _selectedDroppingOption;

  late TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(
      vsync: this,
      length: 2,
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: (){
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back, color: Colors.white,)),
        backgroundColor: Colors.red,
        title: Text(
          'Boarding and Dropping Points',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        bottom: TabBar(
          indicatorColor: Colors.white,
          controller: _tabController,
          isScrollable: true,
          tabs: [
            Tab(
              child: SizedBox(
                  width: MediaQuery.of(context).size.width/3,
                  child: Center(child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width/4,
                          child: const Text('Boarding', style: TextStyle(fontSize: 20))),
                      _selectedBoardingOption == null
                          ? const SizedBox.shrink()
                          :SizedBox(
                          width: MediaQuery.of(context).size.width/4,
                            child: Text('${_selectedBoardingOption.cityPointName}',
                            overflow: TextOverflow.ellipsis),
                          ),
                    ],))),
            ),
            Tab(child: SizedBox(
                width: MediaQuery.of(context).size.width/3,
                child: Center(child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                        width: MediaQuery.of(context).size.width/4,
                        child: const Text('Dropping', style: TextStyle(fontSize: 20), )),
                    _selectedDroppingOption == null
                        ? const SizedBox.shrink()
                        :SizedBox(
                        width: MediaQuery.of(context).size.width/4,
                        child: Text('${_selectedDroppingOption.cityPointName}', overflow: TextOverflow.ellipsis,)),
                  ],)))),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildBoardingTab(),
          _buildDroppingTab(),
        ],
      ),
    );
  }

  Widget _buildBoardingTab() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          'Select your boarding point',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      Column(
        children: widget.boardingList!.map((option) {
          return RadioListTile(
            title: Text(option.cityPointName ?? ''),
            value: option,
            groupValue: _selectedBoardingOption,
            onChanged: (value) {
              setState(() {
                _selectedBoardingOption = value;
                _tabController.animateTo(1);
              });
            },
          );
        }).toList(),
      ),
    ]);
  }

  Widget _buildDroppingTab() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          'Select your boarding point',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      Column(
        children: widget.droppingList!.map((option) {
          return RadioListTile(
            title: Text(option.cityPointName ?? ''),
            value: option,
            groupValue: _selectedDroppingOption,
            onChanged: (value) {
              setState(() {
                if (_selectedBoardingOption == null) {
                  Fluttertoast.showToast(msg: 'Pick first Boarding Point ');
                } else {
                  _selectedDroppingOption = value;

                  /*Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PasssengerInformation(
                          amount: widget.amount,
                          seatNoList: widget.seatNoList,
                          travelsName: widget.travelsName,
                          date: widget.date,
                          busId: widget.busId,
                          boarding: _selectedBoardingOption.title.toString(),
                          dropping: _selectedDroppingOption.title.toString(),
                          cityFromAndTo: widget.fromAndToCity,
                          timeFrom: widget.fromTime,
                          timeTo: widget.toTime,

                        ),
                      ));*/
                }
              });
            },
          );
        }).toList(),
      ),
    ]);
  }

}
