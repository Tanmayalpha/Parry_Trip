import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:parry_trip2/Helper/helper.dart';
import 'package:parry_trip2/extentions/app_extentions.dart';
import 'package:parry_trip2/screens/Bus/BusHome.dart';
import 'package:parry_trip2/screens/FLight/FlightHome.dart';
import 'package:parry_trip2/screens/HomeScreen/Hotel/hotel_details_chepter2.dart';
import 'package:parry_trip2/screens/Hotel/homeView.dart';

import '../../Library/rattings.dart';
import 'Destination/hotel_list_View.dart';
import 'Recommendation/recommendationDetailScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home',
            style: TextStyle(
                fontWeight: FontWeight.w900,
                fontFamily: "Gotik",
                fontSize: 28.0,
                color: Colors.black)),
        backgroundColor: Colors.white,
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 10),
        child: Column(
          children: [
            _searchBox,
            slider(context),
            vacation(),
            _recomendedbookitngo(context),
            _destinationPopuler(),
            _recommendedFeatured(),
            _recommendedRooms(),
          ],
        ),
      ),
    );
  }

  final _searchBox = Padding(
    padding: EdgeInsets.only(left: 15.0, right: 15.0, bottom: 10.0),
    child: InkWell(
      onTap:
          () {} /* Navigator.of(context).push(PageRouteBuilder(
        pageBuilder: (_, __, ___) => new Search(
          userId: widget.userID,
        ),
        transitionsBuilder:
            (_, Animation<double> animation, __, Widget child) {
          return Opacity(
            opacity: animation.value,
            child: child,
          );
        },
        transitionDuration: Duration(milliseconds: 500),
      ))*/
      ,
      child: Container(
        height: 43.0,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(9.0)),
          boxShadow: [
            BoxShadow(
              color: Colors.black12.withOpacity(0.1),
              spreadRadius: 1.0,
              blurRadius: 3.0,
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 15.0, right: 10.0),
          child: Row(
            children: <Widget>[
              Icon(
                Icons.search,
                color: Color(0xFF09314F),
                size: 25.0,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Text(
                    /*AppLocalizations.of(context).tr('findDoYouWant')*/
                    'findDoYouWant',
                    style: TextStyle(
                        color: Colors.black26,
                        fontFamily: "Gotik",
                        fontWeight: FontWeight.w300,
                        fontSize: 15.0)),
              ),
            ],
          ),
        ),
      ),
    ),
  );

  Widget slider(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: CarouselSlider(
        options: CarouselOptions(
          height: 190,
          aspectRatio: 24 / 18,
          viewportFraction: 0.9,
          initialPage: 0,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: true,
          autoPlayInterval: Duration(seconds: 3),
          autoPlayAnimationDuration: Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastOutSlowIn,
          enlargeCenterPage: true,
          scrollDirection: Axis.horizontal,
        ),
        items: [0, 1, 2, 3, 4].map((i) {
          return Container(
            height: 190.0,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        "https://i.pinimg.com/564x/be/17/88/be17880995d36aed7fab5679d01faa00.jpg"),
                    fit: BoxFit.cover)),
          );
          ;
        }).toList(),
      ),
    );
  }

  Widget vacation() {
    return Container(
      padding: EdgeInsets.only(top: 20.0),
      height: 177.0,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
              padding:
                  const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    /*AppLocalizations.of(context).tr('vacations')*/
                    'vacations',
                    style: CustomTextStyle.txtStyle,
                  ),
                  Text(
                    "",
                    style: CustomTextStyle.txtStyle
                        .copyWith(color: Colors.black26, fontSize: 13.5),
                  )
                ],
              )),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //scrollDirection: Axis.horizontal,
              children: <Widget>[
                /*Padding(
                  padding: EdgeInsets.only(left: 15.0),
                ),*/
                InkWell(
                  onTap: () {
                    /*Navigator.of(context).push(PageRouteBuilder(
                      pageBuilder: (_, __, ___) => new Beaches(
                        title: AppLocalizations.of(context).tr('beaches'),
                        userId: widget.userID,
                      ),
                      transitionDuration: Duration(milliseconds: 600),
                      transitionsBuilder:
                          (_, Animation<double> animation, __, Widget child) {
                        return Opacity(
                          opacity: animation.value,
                          child: child,
                        );
                      }));*/

                    Navigator.push(context, MaterialPageRoute(builder: (context) => HotelHomePage(),));
                  },
                  child: cardVacations(
                    txt: /*AppLocalizations.of(context).tr('beaches')*/
                        'Hotel',
                    desc: /*AppLocalizations.of(context).tr('descBeaches')*/
                        'descBeaches',
                    img: 'assets/icons/beach.png',
                  ),
                ),
                InkWell(
                  onTap: () {
                    /* Navigator.of(context).push(PageRouteBuilder(
                      pageBuilder: (_, __, ___) => new Mountains(
                        title:
                        AppLocalizations.of(context).tr('mountains'),
                        userId: widget.userID,
                      ),
                      transitionDuration: Duration(milliseconds: 600),
                      transitionsBuilder:
                          (_, Animation<double> animation, __, Widget child) {
                        return Opacity(
                          opacity: animation.value,
                          child: child,
                        );
                      }));*/
                    Navigator.push(context, MaterialPageRoute(builder: (context) => FlightBooking(),));
                  },
                  child: cardVacations(
                    txt: /*AppLocalizations.of(context).tr('mountains')*/
                        'Flight',
                    desc: /*AppLocalizations.of(context).tr('descMountains')*/
                        'descMountains',
                    img: 'assets/icons/mountain.png',
                  ),
                ),
                InkWell(
                  onTap: () {
                    /*Navigator.of(context).push(PageRouteBuilder(
                      pageBuilder: (_, __, ___) => new Sun(
                        title: AppLocalizations.of(context).tr('sun'),
                        userId: widget.userID,
                      ),
                      transitionDuration: Duration(milliseconds: 600),
                      transitionsBuilder:
                          (_, Animation<double> animation, __, Widget child) {
                        return Opacity(
                          opacity: animation.value,
                          child: child,
                        );
                      }));*/
                    Navigator.push(context, MaterialPageRoute(builder: (context) => BusHomeScreen(),));
                  },
                  child: cardVacations(
                    txt: /*AppLocalizations.of(context).tr('sun')*/ 'Bus',
                    desc: /*AppLocalizations.of(context).tr('detaileSun')*/
                        'Bus',
                    img: 'assets/icons/sun.png',
                  ),
                ),
                /*InkWell(
                  onTap: () {
                    *//*Navigator.of(context).push(PageRouteBuilder(
                      pageBuilder: (_, __, ___) => new Tropical(
                        title:
                        AppLocalizations.of(context).tr('tropical'),
                        userId: widget.userID,
                      ),
                      transitionDuration: Duration(milliseconds: 600),
                      transitionsBuilder:
                          (_, Animation<double> animation, __, Widget child) {
                        return Opacity(
                          opacity: animation.value,
                          child: child,
                        );
                      }));*//*
                  },
                  child: cardVacations(
                    txt: *//*AppLocalizations.of(context).tr('tropical')*//*
                        'tropical',
                    desc: *//*AppLocalizations.of(context).tr('descTropical')*//*
                        'descTropical',
                    img: 'assets/icons/tropical.png',
                  ),
                ),*/
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _recomendedbookitngo(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 40.0),
      height: 350.0,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.only(bottom: 10.0, left: 20.0, right: 20.0),
            child: Text(
              /*AppLocalizations.of(context).tr('recommended')*/
              'recommended',
              style: CustomTextStyle.txtStyle,
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(
                top: 10.0,
              ),
              child: cardSuggeted(
                list: [],
                dataUser: '',
              )),
        ],
      ),
    );
  }

  Widget _destinationPopuler() {
    return Container(
      padding: EdgeInsets.only(top: 30.0),
      height: 287.0,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
              padding:
                  const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    /*AppLocalizations.of(context).tr('popularDestination')*/
                    'popularDestination',
                    style: CustomTextStyle.txtStyle,
                  ),
                  // Text(
                  //   AppLocalizations.of(context).tr('seeMore'),
                  //   style: _txtStyle.copyWith(
                  //       color: Colors.black26, fontSize: 13.5),
                  // )
                ],
              )),
          Expanded(
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 15.0),
                ),
                InkWell(
                  onTap: () {
                    /*Navigator.of(context).push(PageRouteBuilder(
                      pageBuilder: (_, __, ___) => new Anaheim(
                        title: AppLocalizations.of(context).tr('anaheim'),
                        userId: widget.userID,
                      ),
                      transitionDuration: Duration(milliseconds: 600),
                      transitionsBuilder:
                          (_, Animation<double> animation, __, Widget child) {
                        return Opacity(
                          opacity: animation.value,
                          child: child,
                        );
                      }));*/
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AnaheimScreen(title: 'anaheim'),
                        ));
                  },
                  child: cardDestinationPopuler(
                    txt: /*AppLocalizations.of(context).tr('anaheim')*/
                        'anaheim',
                    img:
                        'https://images.pexels.com/photos/374870/pexels-photo-374870.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
                  ),
                ),
                InkWell(
                  onTap: () {
                    /*Navigator.of(context).push(PageRouteBuilder(
                      pageBuilder: (_, __, ___) => new LosAngeles(
                        title:
                        AppLocalizations.of(context).tr('losAngeles'),
                        userId: widget.userID,
                      ),
                      transitionDuration: Duration(milliseconds: 600),
                      transitionsBuilder:
                          (_, Animation<double> animation, __, Widget child) {
                        return Opacity(
                          opacity: animation.value,
                          child: child,
                        );
                      }));*/
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              AnaheimScreen(title: 'losAgeles'),
                        ));
                  },
                  child: cardDestinationPopuler(
                    txt: /*AppLocalizations.of(context).tr('losAngeles')*/
                        'losAngeles',
                    img:
                        'https://images.pexels.com/photos/373912/pexels-photo-373912.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500',
                  ),
                ),
                InkWell(
                  onTap: () {
                    /*Navigator.of(context).push(PageRouteBuilder(
                      pageBuilder: (_, __, ___) => new Florida(
                        title: AppLocalizations.of(context).tr('florida'),
                        userId: widget.userID,
                      ),
                      transitionDuration: Duration(milliseconds: 600),
                      transitionsBuilder:
                          (_, Animation<double> animation, __, Widget child) {
                        return Opacity(
                          opacity: animation.value,
                          child: child,
                        );
                      }));*/
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AnaheimScreen(title: 'Florida'),
                        ));
                  },
                  child: cardDestinationPopuler(
                    txt: /*AppLocalizations.of(context).tr('florida')*/
                        'florida',
                    img:
                        'https://images.pexels.com/photos/3643461/pexels-photo-3643461.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500',
                  ),
                ),
                InkWell(
                  onTap: () {
                    /*Navigator.of(context).push(PageRouteBuilder(
                      pageBuilder: (_, __, ___) => new LasVegas(
                        title:
                        AppLocalizations.of(context).tr('lasVegas'),
                        userId: widget.userID,
                      ),
                      transitionDuration: Duration(milliseconds: 600),
                      transitionsBuilder:
                          (_, Animation<double> animation, __, Widget child) {
                        return Opacity(
                          opacity: animation.value,
                          child: child,
                        );
                      }));*/
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              AnaheimScreen(title: 'LasVegas'),
                        ));
                  },
                  child: cardDestinationPopuler(
                    txt: /*AppLocalizations.of(context).tr('lasVegas')*/
                        'lasVegas',
                    img:
                        'https://images.pexels.com/photos/2837909/pexels-photo-2837909.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
                  ),
                ),
                InkWell(
                  onTap: () {
                    /*Navigator.of(context).push(PageRouteBuilder(
                      pageBuilder: (_, __, ___) => new NewYork(
                        title: AppLocalizations.of(context).tr('newYork'),
                        userId: widget.userID,
                      ),
                      transitionDuration: Duration(milliseconds: 600),
                      transitionsBuilder:
                          (_, Animation<double> animation, __, Widget child) {
                        return Opacity(
                          opacity: animation.value,
                          child: child,
                        );
                      }));*/
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AnaheimScreen(title: 'newYork'),
                        ));
                  },
                  child: cardDestinationPopuler(
                    txt: /*AppLocalizations.of(context).tr('newYork')*/
                        'newYork',
                    img:
                        'https://images.pexels.com/photos/2190283/pexels-photo-2190283.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _recommendedFeatured() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 20.0, top: 30.0, right: 20.0),
          child: Text(
            /*AppLocalizations.of(context).tr('featured')*/
            'featured',
            style: CustomTextStyle.txtStyle,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 10.0,
          ),
          child: cardLastActivity(
            dataUser: '',
            list: [],
          ),
        )
      ],
    );
  }

  Widget _recommendedRooms() {
    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.only(left: 20.0, top: 40.0, right: 20.0),
              child: /*Text(AppLocalizations.of(context).tr('recommendedRoom')*/
                  Text('recommendedRoom', style: CustomTextStyle.txtStyle),
            ),

            /// To set GridView item
            ///
            GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 0.795, crossAxisCount: 2),
                itemCount: 10,
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 10.0),
                primary: false,
                itemBuilder: (BuildContext context, int i) {
                  /*List<String> photo =
                    List.from(list[i].data()['photo']);*/
                  /*List<String> service =
                    List.from(list[i].data()['service']);*/
                  /*List<String> description =
                    List.from(list[i].data()['description'])*/
                  ;
                  String title = 'title';
                  String type = 'type';
                  double rating = 4.5;
                  String location = 'location';
                  String image =
                      'https://images.unsplash.com/photo-1611892440504-42a792e24d32?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8aG90ZWwlMjByb29tfGVufDB8fDB8fA%3D%3D&w=1000&q=80';
                  String id = 'id';
                  double price = 150;
                  List<String> photo = [
                    'https://images.unsplash.com/photo-1611892441796-ae6af0ec2cc8?',
                    'https://media.istockphoto.com/id/174893699/photo/good-night-hotel-room-with-2-beds.jpg?s=170667a&w=0&k=20&c=MGWcmoOiZBd1jhXCkIJYRMZHMzkh_4p2MT8R9tRe0jA=',
                    'https://media.istockphoto.com/id/815091140/photo/interior-modren-bedroom.jpg?s=170667a&w=0&k=20&c=QCZpJF-jIrLzFk6vyS6oPrCYxj0UKhlSlE9p0k1G7cc=',
                    'https://media.istockphoto.com/id/174893699/photo/good-night-hotel-room-with-2-beds.jpg?s=170667a&w=0&k=20&c=MGWcmoOiZBd1jhXCkIJYRMZHMzkh_4p2MT8R9tRe0jA=',
                    'https://media.istockphoto.com/id/90612742/photo/hotel-room-interior.jpg?s=612x612&w=0&k=20&c=oio-TXohwmE3I4UM8QCEEPgq00UZHuJzLUhRllGtjMo=',
                    'https://media.istockphoto.com/id/182721675/photo/twin-beds.jpg?s=612x612&w=0&k=20&c=X95xzcOX_boQQPd7RkeM2iymk2gK-W3tbNNUNUWGriI=',
                    'https://media.istockphoto.com/id/172196396/photo/hotel-room.jpg?s=612x612&w=0&k=20&c=XcE43VyP12zeHVyOQRTGjL1LtHrVOSbzdonlZazhZIQ='
                  ];
                  List<String> service = ['service', 'service2', 'service3', 'service4'];
                  List<String> description = [
                    'hfskdjhsfshdfs fsfksfhshksdjsdhf ',
                    'fjkhffs jfhsdkjfhkf sdfhskfh djfhsjdfh',
                    'jhjfh jfhsjkdhfkjhf sfkjsfhks',
                    'fhdskfdjlfskfslffsjdfjf sjfsjf'
                  ];
                  // num latLang1 = 'latLang1';
                  //num latLang2 = 'latLang2';

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        /*Navigator.of(context).push(PageRouteBuilder(
                                pageBuilder: (_, __, ___) =>
                                new hotelDetail2(
                                  userId: widget.userID,
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
                                transitionDuration:
                                Duration(milliseconds: 600),
                                transitionsBuilder: (_,
                                    Animation<double> animation,
                                    __,
                                    Widget child) {
                                  return Opacity(
                                    opacity: animation.value,
                                    child: child,
                                  );
                                }));*/
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HotelDetail2(
                                idD: 'id4',
                                imageD: image,
                                titleD: title,
                                priceD: price,
                               // latLang1D: 22.7177,
                                locationD: location,
                               // latLang2D: 75.8545,
                                ratingD: rating,
                               // descriptionD: description,
                               // photoD: photo,
                               // serviceD: service,
                              ),
                            ));
                      },
                      child: Container(
                        height: 1000.0,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xFF656565).withOpacity(0.15),
                                blurRadius: 4.0,
                                spreadRadius: 1.0,
                                //           offset: Offset(4.0, 10.0)
                              )
                            ]),
                        child: Wrap(
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Hero(
                                  tag: 'hero-tag-${id}',
                                  child: Material(
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              5.8,
                                      width: 200.0,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(7.0),
                                              topRight: Radius.circular(7.0)),
                                          image: DecorationImage(
                                              image: NetworkImage(image),
                                              fit: BoxFit.cover)),
                                    ),
                                  ),
                                ),
                                const Padding(
                                    padding: EdgeInsets.only(top: 5.0)),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10.0, right: 10.0),
                                  child: Container(
                                    width: 130.0,
                                    child: Text(
                                      title,
                                      style: TextStyle(
                                          letterSpacing: 0.5,
                                          color: Colors.black54,
                                          fontFamily: "Sans",
                                          fontWeight: FontWeight.w600,
                                          fontSize: 13.0),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                                Padding(padding: EdgeInsets.only(top: 2.0)),
                                Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10.0, right: 0.0),
                                      child: Text(
                                        price.toString(),
                                        style: TextStyle(
                                            color: Colors.black54,
                                            fontFamily: "Gotik",
                                            fontWeight: FontWeight.w800,
                                            fontSize: 14.0),
                                      ),
                                    ),
                                    const Text(
                                      /*AppLocalizations.of(context)
                                              .tr('night')*/
                                      'night',
                                      style: TextStyle(
                                          color: Colors.black54,
                                          fontFamily: "Gotik",
                                          fontWeight: FontWeight.w400,
                                          fontSize: 10.0),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10.0, right: 15.0, top: 5.0),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          ratingbar(
                                            starRating: rating,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 12.0),
                                            child: Text(
                                              rating.toString(),
                                              style: const TextStyle(
                                                  fontFamily: "Sans",
                                                  color: Colors.black26,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 12.0),
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }
}

class cardVacations extends StatelessWidget {
  final String img, txt, desc;

  cardVacations({required this.img, required this.txt, required this.desc});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          left: 10.0, right: 10.0, top: 8.0, bottom: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 70.0,
            width: 70.0,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Colors.black12.withOpacity(0.04),
                    blurRadius: 3.0,
                    spreadRadius: 1.0)
              ],
              image: DecorationImage(
                image: AssetImage(
                  img,
                ),
                fit: BoxFit.cover,
              ),
              color: Colors.white,
              border:
                  Border.all(color: Colors.grey.withOpacity(0.05), width: 1.0),
              borderRadius: BorderRadius.all(Radius.circular(60)),
            ),
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Text(
                txt,
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: "Sofia",
                    fontSize: 13.0,
                    fontWeight: FontWeight.w400),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class cardSuggeted extends StatelessWidget {
  final String dataUser;
  final List list;

  cardSuggeted({
    Key? key,
    required this.dataUser,
    required this.list,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 260.0,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          primary: false,
          itemCount: 3,
          itemBuilder: (context, i) {
            String title = 'House';
            String image = 'https://images2.imgbox.com/a9/7e/JkiFnCo3_o.png';
            String textImage = 'Hotel';
            String desc =
                'khkhkhkjfhsjhfj sfhdjshfkjdhfs shfhsjfhsd shfkjhasdf kjsshfkjhs fkjhsd sfhkjsd ksdfhks sfhkjsf skdfks ';
            String key = 'key';

            return Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 12.0, top: 8.0, bottom: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      /*Navigator.of(context).push(PageRouteBuilder(
                          pageBuilder: (_, __, ___) => new RecommendedDetail(
                            keyID: key,
                            title: title,
                            userId: dataUser,
                          )));*/

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RecommendationDetailScreen(
                              title: title,
                            ),
                          ));
                    },
                    child: Container(
                      width: 285.0,
                      height: 135.0,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(image), fit: BoxFit.cover),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xFF656565).withOpacity(0.15),
                              blurRadius: 2.0,
                              spreadRadius: 1.0,
                            )
                          ]),
                      child: Center(
                        child: Text(
                          textImage,
                          style: TextStyle(
                              fontFamily: 'Amira',
                              color: Colors.white,
                              fontSize: 40.0,
                              letterSpacing: 2.0,
                              shadows: [
                                Shadow(
                                  color: Colors.black12.withOpacity(0.1),
                                  blurRadius: 2.0,
                                )
                              ]),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 10.0),
                    child: Text(
                      title,
                      style: TextStyle(
                        fontFamily: "Sans",
                        fontSize: 16.0,
                        fontWeight: FontWeight.w800,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 5.0),
                    child: Container(
                        width: 270.0,
                        child: Text(
                          desc,
                          overflow: TextOverflow.clip,
                          maxLines: 3,
                          style: TextStyle(
                            fontFamily: "Sans",
                            fontSize: 13.0,
                            fontWeight: FontWeight.w400,
                            color: Colors.black26,
                          ),
                        )),
                  ),
                ],
              ),
            );
          }),
    );
  }
}

class cardDestinationPopuler extends StatelessWidget {
  final String img, txt;

  cardDestinationPopuler({required this.img, required this.txt});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 400.0,
        width: 140.0,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            image: DecorationImage(
              image: NetworkImage(img),
              fit: BoxFit.cover,
            ),
            boxShadow: [
              BoxShadow(
                  color: Colors.black12.withOpacity(0.1),
                  blurRadius: 2.0,
                  spreadRadius: 1.0)
            ]),
        child: Center(
          child: Text(
            txt,
            style: TextStyle(
                fontFamily: 'Amira',
                color: Colors.white,
                fontSize: 32.0,
                letterSpacing: 2.0,
                shadows: [
                  Shadow(
                    color: Colors.black,
                    blurRadius: 2.0,
                  )
                ]),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

class cardLastActivity extends StatelessWidget {
  final String dataUser;
  final List list;

  cardLastActivity({
    required this.dataUser,
    required this.list,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 190.0,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          primary: false,
          itemCount: 5,
          itemBuilder: (context, i) {
            List<String> photo = [
              'https://images.unsplash.com/photo-1611892441796-ae6af0ec2cc8?',
              'https://media.istockphoto.com/id/174893699/photo/good-night-hotel-room-with-2-beds.jpg?s=170667a&w=0&k=20&c=MGWcmoOiZBd1jhXCkIJYRMZHMzkh_4p2MT8R9tRe0jA=',
              'https://media.istockphoto.com/id/815091140/photo/interior-modren-bedroom.jpg?s=170667a&w=0&k=20&c=QCZpJF-jIrLzFk6vyS6oPrCYxj0UKhlSlE9p0k1G7cc=',
              'https://media.istockphoto.com/id/174893699/photo/good-night-hotel-room-with-2-beds.jpg?s=170667a&w=0&k=20&c=MGWcmoOiZBd1jhXCkIJYRMZHMzkh_4p2MT8R9tRe0jA=',
              'https://media.istockphoto.com/id/90612742/photo/hotel-room-interior.jpg?s=612x612&w=0&k=20&c=oio-TXohwmE3I4UM8QCEEPgq00UZHuJzLUhRllGtjMo=',
              'https://media.istockphoto.com/id/182721675/photo/twin-beds.jpg?s=612x612&w=0&k=20&c=X95xzcOX_boQQPd7RkeM2iymk2gK-W3tbNNUNUWGriI=',
              'https://media.istockphoto.com/id/172196396/photo/hotel-room.jpg?s=612x612&w=0&k=20&c=XcE43VyP12zeHVyOQRTGjL1LtHrVOSbzdonlZazhZIQ='
            ];
            List<String> service = ['service', 'service2', 'service3', 'service4'];
            List<String> description = [
              'hfskdjhsfshdfs fsfksfhshksdjsdhf ',
              'fjkhffs jfhsdkjfhkf sdfhskfh djfhsjdfh',
              'jhjfh jfhsjkdhfkjhf sfkjsfhks',
              'fhdskfdjlfskfslffsjdfjf sjfsjf'
            ];
            String title = 'title';
            String type = 'type';
            double rating = 4.5;
            String location = 'location';
            String image =
                'https://images.unsplash.com/photo-1611892440504-42a792e24d32?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8aG90ZWwlMjByb29tfGVufDB8fDB8fA%3D%3D&w=1000&q=80';
            String id = 'id';
            double price = 150;

            return Padding(
              padding:
                  const EdgeInsets.only(left: 18.0, top: 10.0, bottom: 8.0),
              child: InkWell(
                onTap: () {
                  /*Navigator.of(context).push(PageRouteBuilder(
                      pageBuilder: (_, __, ___) => new hotelDetail2(
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

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HotelDetail2(
                          idD: 'id3',
                          imageD: image,
                          titleD: title,
                          priceD: price,
                          //latLang1D: 22.7177,
                          locationD: location,
                          //latLang2D: 75.8545,
                          ratingD: rating,
                         // descriptionD: description,
                         // photoD: photo,
                         // serviceD: service,
                        ),
                      ));
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFF656565).withOpacity(0.15),
                          blurRadius: 4.0,
                          spreadRadius: 1.0,
                        )
                      ]),
                  child: Wrap(
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Hero(
                            tag: 'hero-tag-${id}',
                            child: Material(
                              child: Container(
                                height: 100.0,
                                width: 140.0,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(7.0),
                                        topRight: Radius.circular(7.0)),
                                    image: DecorationImage(
                                        image: NetworkImage(image),
                                        fit: BoxFit.cover)),
                              ),
                            ),
                          ),
                          Padding(padding: EdgeInsets.only(top: 5.0)),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 10.0, right: 10.0),
                            child: Container(
                              width: 110.0,
                              child: Text(
                                title,
                                style: TextStyle(
                                    letterSpacing: 0.5,
                                    color: Colors.black54,
                                    fontFamily: "Sans",
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13.0),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          Padding(padding: EdgeInsets.only(top: 2.0)),
                          Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10.0, right: 0.0),
                                child: Text(
                                  "\$ " + price.toString(),
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontFamily: "Gotik",
                                      fontWeight: FontWeight.w800,
                                      fontSize: 14.0),
                                ),
                              ),
                              Text(
                                /*AppLocalizations.of(context).tr('night')*/
                                '/night',
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontFamily: "Gotik",
                                    fontWeight: FontWeight.w400,
                                    fontSize: 10.0),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 10.0, right: 15.0, top: 3.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    ratingbar(
                                      starRating: rating,
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 12.0),
                                      child: Text(
                                        rating.toString(),
                                        style: TextStyle(
                                            fontFamily: "Sans",
                                            color: Colors.black26,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12.0),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
