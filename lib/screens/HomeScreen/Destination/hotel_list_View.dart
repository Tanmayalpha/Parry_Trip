import 'dart:convert';

import 'package:carousel_pro_nullsafety/carousel_pro_nullsafety.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:parry_trip2/Library/rattings.dart';
import 'package:http/http.dart' as http;
import 'package:parry_trip2/constants/constant.dart';
import 'package:parry_trip2/model/hotel_details_response.dart';
import 'package:parry_trip2/model/hotel_search_list_data.dart';
import 'package:parry_trip2/screens/HomeScreen/Hotel/hotel_details_chepter2.dart';
import 'package:parry_trip2/widgets/api.dart';

import '../../../model/searched_hotel.dart';

class AnaheimScreen extends StatefulWidget {
  const AnaheimScreen(
      {Key? key,
      this.title,
      this.userId,
      this.checkIn,
      this.checkOut,
      this.adults,
      this.cityId,
      this.child})
      : super(key: key);
  final String? title, userId;
  final String? checkIn, checkOut, cityId;

  final int? adults, child;

  @override
  State<AnaheimScreen> createState() => _AnaheimScreenState();
}

class _AnaheimScreenState extends State<AnaheimScreen> {
  SearchedHotel? searchedHotel;
  Api api = Api();

  var data;

  @override
  void initState() {
    // TODO: implement initState.
    inIt();

    super.initState();
  }

  inIt() async {
    await getSearchedHotel();
  }

  @override
  Widget build(BuildContext context) {
    var _appBar = PreferredSize(
      preferredSize: Size.fromHeight(45.0),
      child: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(widget.title ?? '',
            style: TextStyle(fontFamily: "Sofia", color: Colors.black)),
      ),
    );

    var _description = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
          child: Text(
            widget.title ?? '',
            style: TextStyle(
                fontFamily: "Sofia",
                fontWeight: FontWeight.w700,
                fontSize: 20.0),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
              left: 20.0, right: 20.0, top: 10.0, bottom: 30.0),
          child: Container(
              width: MediaQuery.of(context).size.width - 10.0,
              child: const Text(
                'anaheimDesc hhrkjwher rwekjrerer hrjrhhr hrhrh hkjrhjkr erjewjr werhwr werwer weriuwr weir wryiw rioroiqr  erwer',
                style: TextStyle(
                    fontFamily: "Sofia",
                    fontWeight: FontWeight.w300,
                    fontSize: 14.5,
                    color: Colors.black45),
                overflow: TextOverflow.clip,
                textAlign: TextAlign.justify,
              )),
        ),
      ],
    );

    var _topAnaheim = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 20.0, top: 30.0, right: 20.0),
          child: Text(
            'topChoice',
            style: TextStyle(
                fontFamily: "Sofia",
                fontSize: 20.0,
                fontWeight: FontWeight.w700),
          ),
        ),
        SizedBox(height: 5.0),
        Container(
            height: 320.0,
            child: card(
                /*dataUser: widget.userId,
            list: snapshot.data.docs,*/
                )),
        SizedBox(
          height: 25.0,
        ),
      ],
    );

    var _recommended = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 22.0, right: 20.0),
          child: Text(
            'Hotel :${widget.title}',
            style: TextStyle(
                fontFamily: "Sofia",
                fontSize: 20.0,
                fontWeight: FontWeight.w700),
          ),
        ),
        isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : hotels.isEmpty
                ? const Center(
                    child: Text('Hotel not available in this city'),
                  )
                : Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: cardList(
                      hotels: hotels,
                    ),
                  ),
        const SizedBox(
          height: 20.0,
        ),
      ],
    );

    return Scaffold(
      appBar: _appBar,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 250,
              child: Carousel(
                boxFit: BoxFit.cover,
                dotColor: Colors.white.withOpacity(0.8),
                dotSize: 5.5,
                dotSpacing: 16.0,
                dotBgColor: Colors.transparent,
                showIndicator: true,
                overlayShadow: true,
                overlayShadowColors: Colors.white.withOpacity(0.9),
                overlayShadowSize: 0.9,
                images: [0, 1, 2].map((i) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: FractionalOffset(0.0, 0.0),
                        end: FractionalOffset(0.0, 1.0),
                        stops: [0.0, 1.0],
                        colors: <Color>[
                          Color(0x00FFFFFF),
                          Color(0xFFFFFFFF),
                        ],
                      ),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 9.0,
                            spreadRadius: 7.0,
                            color: Colors.black12.withOpacity(0.03))
                      ],
                      image: const DecorationImage(
                          image: NetworkImage(
                              'https://media.radissonhotels.net/image/radisson-blu-hotel-indore/guest-room/16256-116514-f64878631_3xl.jpg?'),
                          fit: BoxFit.cover),
                    ),
                  );
                }).toList(),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            _description,
            _recommended,
            //_topAnaheim,
          ],
        ),
      ),
    );
  }

  getSearchedHotel() async {
    isLoading = true;
    try {
      var headers = {
        'Content-Type': 'application/json',
        'apikey': '812146ac5e380f-ed6f-4a76-a035-314f4255eddb'
      };
      var request = http.Request(
          'POST', Uri.parse('${flightUrl}hms/v1/hotel-searchquery-list'));
      request.body = json.encode({
        "searchQuery": {
          "checkinDate": widget.checkIn,
          "checkoutDate": widget.checkOut,
          "roomInfo": [
            {
              "numberOfAdults": widget.adults,
              "numberOfChild": 0,
              "childAge": []
            }
          ],
          "searchCriteria": {
            "city": widget.cityId,
            "nationality": "106",
            "currency": "INR"
          },
          "searchPreferences": {
            "ratings": [3, 4, 5],
            "fsc": true
          }
        },
        "sync": false
      });

      print('${request.body}');
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var finalResult = await response.stream.bytesToString();

        final jsonResponse = SearchedHotel.fromJson(json.decode(finalResult));
        setState(() {
          searchedHotel = jsonResponse;
        });
        print('${searchedHotel?.searchIds?.first}_________searchname');

        searchedHotel?.searchIds?.forEach((element) async {
          await getHotelList(element);
        });

       // await Future.delayed(const Duration(seconds: 20));
        /*setState(() {
          print('_____________');
          isLoading = false;
        });*/

        //print('${api.hotels.first.name}_________name');
      } else {
        print(response.reasonPhrase);
        setState(() {
          print('_____________');
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        print('__${e}___________');
        isLoading = false;
      });
    } finally {
      /*setState(() {
        isLoading = false;
      });*/
    }
  }

  HotelDetailsResponse? hotelDetailsResponse;
  HotelSearchListData? hotelSearchListData;
  List<His> hotels = [];
  bool isLoading = false;




  getHotelList(String element) async {
    var headers = {
      'Content-Type': 'application/json',
      'apikey': '812146ac5e380f-ed6f-4a76-a035-314f4255eddb'
    };
    var request =
    http.Request('POST', Uri.parse('${flightUrl}hms/v1/hotel-search'));
    request.body = json.encode({"searchId": element});
    request.headers.addAll(headers);

    print('${request.body}');

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var finalResult = await response.stream.bytesToString();

      final jsonResponse =
      HotelSearchListData.fromJson(json.decode(finalResult));

      hotelSearchListData = jsonResponse;
      // hotels.clear();

      hotels = hotelSearchListData?.searchResult?.his ?? [];

      print('${hotels.first.name}___________name');
      setState(() {
        isLoading = false;
      });
    } else {
      print(response.reasonPhrase);
    }
  }
}

class card extends StatelessWidget {
  final String? dataUser;
  final List? list;

  card({this.dataUser, this.list});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        primary: false,
        itemCount: 3,
        itemBuilder: (context, i) {
          //List<String> photo = List.from(list[i].data()['photo']);
          // List<String> service = List.from(list[i].data()['service']);
          // List<String> description = List.from(list[i].data()['description']);
          String title = 'title';
          // String type = list[i].data()['type'].toString();
          double rating = 4.5;
          String location = 'location';
          String image =
              'https://media-cdn.tripadvisor.com/media/photo-m/1280/21/dc/28/e0/fortune-pandiyan-hotel.jpg';
          String id = 'id2';
          num price = 1500;
          //num latLang1 = list[i].data()['latLang1'];
          // num latLang2 = list[i].data()['latLang2'];

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                InkWell(
                  onTap: () {
                    /*Navigator.of(context).push(PageRouteBuilder(
                        pageBuilder: (_, __, ___) => new TopChoiceDetail(
                          userId: dataUser,
                          titleD: title,
                          idD: id,
                          imageD: image,
                          latLang1D: latLang1,
                          latLang2D: latLang2,
                          locationD: location,
                          priceD: price,
                          descriptionD: description,
                          photoD: photo,
                          ratingD: rating,
                          serviceD: service,
                          typeD: type,
                        ),
                        transitionDuration: Duration(milliseconds: 600),
                        transitionsBuilder:
                            (_, Animation<double> animation, __, Widget child) {
                          return Opacity(
                            opacity: animation.value,
                            child: child,
                          );
                        }));*/
                  },
                  child: Hero(
                    tag: 'hero-tag-${id}',
                    child: Material(
                      child: Container(
                        height: 220.0,
                        width: 160.0,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(image), fit: BoxFit.cover),
                            color: Colors.black12,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 5.0,
                                  color: Colors.black12.withOpacity(0.1),
                                  spreadRadius: 2.0)
                            ]),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  title,
                  style: TextStyle(
                      fontFamily: "Sofia",
                      fontWeight: FontWeight.w600,
                      fontSize: 17.0,
                      color: Colors.black87),
                ),
                SizedBox(
                  height: 2.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Icon(
                      Icons.location_on,
                      size: 18.0,
                      color: Colors.black12,
                    ),
                    Text(
                      location,
                      style: TextStyle(
                          fontFamily: "Sofia",
                          fontWeight: FontWeight.w500,
                          fontSize: 15.0,
                          color: Colors.black26),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.star,
                      size: 18.0,
                      color: Colors.yellow,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 3.0),
                      child: Text(
                        rating.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontFamily: "Sofia",
                            fontSize: 13.0),
                      ),
                    ),
                    SizedBox(
                      width: 35.0,
                    ),
                    Container(
                      height: 27.0,
                      width: 82.0,
                      decoration: BoxDecoration(
                          color: Color(0xFF09314F),
                          borderRadius:
                              BorderRadius.all(Radius.circular(20.0))),
                      child: Center(
                        child: Text("\$ " + price.toString(),
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 13.0)),
                      ),
                    )
                  ],
                ),
              ],
            ),
          );
        });
  }
}

class cardList extends StatelessWidget {
  final List <His>? hotels;

  final _txtStyleTitle = TextStyle(
    color: Colors.black87,
    fontFamily: "Gotik",
    fontSize: 17.0,
    fontWeight: FontWeight.w800,
  );

  final _txtStyleSub = TextStyle(
    color: Colors.black26,
    fontFamily: "Gotik",
    fontSize: 12.5,
    fontWeight: FontWeight.w600,
  );

  cardList({
    this.hotels,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        primary: false,
        itemCount: hotels?.length ?? 0,
        itemBuilder: (context, i) {
          // List<String> photo = List.from(list[i].data()['photo']);
          //List<String> service = List.from(list[i].data()['service']);
          //List<String> description = List.from(list[i].data()['description']);
          String title = hotels?[i].name ?? '';
          // String type = list[i].data()['type'].toString();
          num rating = hotels?[i].rt ?? 4.5;
          String location = hotels?[i].ad?.city?.name ?? '';
          String image2 =
              'https://www.seleqtionshotels.com/content/dam/seleqtions/Connaugth/TCPD_PremiumBedroom4_1235.jpg/jcr:content/renditions/cq5dam.web.1280.1280.jpeg';
          String image = hotels?[i].img?.first.url ?? image2;
          String id = hotels?[i].id ?? '';
          num price = hotels?[i].pops?.first.tpc ?? 2000;
          String latLang1 = hotels?[i].gl?.ln ?? '';
          String latLang2 = hotels?[i].gl?.lt ?? '';

          return Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 20.0),
            child: InkWell(
              onTap: () {
                Navigator.of(context).push( PageRouteBuilder(
                    pageBuilder: (_, __, ___) => HotelDetail2(
                          titleD: title,
                          idD: id,
                          imageD: image,
                          latLang1D: latLang1,
                          latLang2D: latLang2,
                          locationD: location,
                          priceD: price,
                          ratingD: rating,
                        ),
                    transitionDuration: Duration(milliseconds: 600),
                    transitionsBuilder:
                        (_, Animation<double> animation, __, Widget child) {
                      return Opacity(
                        opacity: animation.value,
                        child: child,
                      );
                    }));
              },
              child: Container(
                height: 250.0,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12.withOpacity(0.1),
                          blurRadius: 3.0,
                          spreadRadius: 1.0)
                    ]),
                child: Column(children: [
                  Hero(
                    tag: 'hero-tag-${id}',
                    child: Material(
                      child: Container(
                        height: 165.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10.0),
                              topLeft: Radius.circular(10.0)),
                          image: DecorationImage(
                              image: NetworkImage(image), fit: BoxFit.cover),
                        ),
                        alignment: Alignment.topRight,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                  width: 210.0,
                                  child: Text(
                                    title,
                                    style: _txtStyleTitle,
                                    overflow: TextOverflow.ellipsis,
                                  )),
                              Padding(padding: EdgeInsets.only(top: 5.0)),
                              Row(
                                children: <Widget>[
                                  ratingbar(
                                    starRating: rating.toDouble(),
                                    color: Color(0xFF09314F),
                                  ),
                                  Padding(padding: EdgeInsets.only(left: 5.0)),
                                  Text(
                                    "(" + rating.toString() + ")",
                                    style: _txtStyleSub,
                                  )
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 4.9),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(
                                      Icons.location_on,
                                      size: 16.0,
                                      color: Colors.black26,
                                    ),
                                    Padding(padding: EdgeInsets.only(top: 3.0)),
                                    Text(location, style: _txtStyleSub)
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              FittedBox(
                                clipBehavior: Clip.antiAlias,
                                child: Text(
                                  "\$" + price.toStringAsFixed(0),
                                  style: TextStyle(
                                      fontSize: 22.0,
                                      color: Color(0xFF09314F),
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "Gotik"),
                                ),
                              ),
                              Text("per night",
                                  style: _txtStyleSub.copyWith(fontSize: 11.0))
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ]),
              ),
            ),
          );
        });
  }
}
