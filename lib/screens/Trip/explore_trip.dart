import 'package:carousel_pro_nullsafety/carousel_pro_nullsafety.dart';
import 'package:flutter/material.dart';
import 'package:parry_trip2/Library/rattings.dart';

class ExploreTripScreen extends StatefulWidget {
  const ExploreTripScreen({Key? key}) : super(key: key);

  @override
  State<ExploreTripScreen> createState() => _ExploreTripState();
}

class _ExploreTripState extends State<ExploreTripScreen> {
  final List<String> imgList = [
    'https://images.pexels.com/photos/2245411/pexels-photo-2245411.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
    'https://images.pexels.com/photos/1371360/pexels-photo-1371360.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
    'https://images.pexels.com/photos/871488/pexels-photo-871488.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
    'https://images.pexels.com/photos/3748834/pexels-photo-3748834.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
  ];
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    var _topAnaheim = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 5.0),
        SizedBox(
            height: 320.0,
            child:  card(
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
        const Padding(
          padding: EdgeInsets.only(left: 22.0, right: 20.0),
          child: Text(
            'Recommended',
            style: TextStyle(
                fontFamily: "Sofia",
                fontSize: 20.0,
                fontWeight: FontWeight.w700),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 5.0),
          child: cardList(
            /*dataUser: widget.userId,
            list: snapshot.data.docs,*/
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
      ],
    );
    return  Scaffold(
      body: SingleChildScrollView(child:
          SizedBox(
            height:height,
          child:  ListView(children: [
            Stack(
              children: <Widget>[
                //      _sliderImage,
                SizedBox(
                  height: MediaQuery.of(context).size.height/2.59,
                  child:  Carousel(
                    boxFit: BoxFit.cover,
                    dotColor: Colors.white.withOpacity(0.8),
                    dotSize: 5.5,
                    dotSpacing: 16.0,
                    dotBgColor: Colors.transparent,
                    showIndicator: true,
                    overlayShadow: true,
                    overlayShadowColors: Colors.white.withOpacity(0.9),
                    overlayShadowSize: 0.9,
                    images: imgList.map((i) {
                      return InkWell(
                        onTap: () {},
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
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
                                  color: Colors.black12
                                      .withOpacity(0.03))
                            ],
                            image: DecorationImage(
                                image: NetworkImage(i),
                                fit: BoxFit.cover),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                Container(
                  height: 292.0,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: FractionalOffset(0.0, 0.0),
                      end: FractionalOffset(0.0, 1.0),
                      stops: [0.0, 1.0],
                      colors: <Color>[
                        Color(0x00FFFFFF),
                        Color(0xFFFFFFFF),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 25.0, left: 15.0, right: 15.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      height: 45.0,
                      width: 45.0,
                      decoration: BoxDecoration(
                        color: Colors.black45,
                        borderRadius:
                        BorderRadius.all(Radius.circular(50.0)),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30.0,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20.0, right: 15.0),
              child: Text(
                'discoverNewPlaces',
                style: TextStyle(
                    fontFamily: "Sofia",
                    fontSize: 20.0,
                    fontWeight: FontWeight.w700),
              ),
            ),
            const SizedBox(height: 5.0),
            _topAnaheim,
            SizedBox(
              height: 25.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Top Destination',
                      style: TextStyle(
                          fontFamily: "Sofia",
                          fontSize: 20.0,
                          fontWeight: FontWeight.w700),
                    ),
                    Text(
                      'seeAll',
                      style: TextStyle(
                          fontFamily: "Sofia",
                          fontSize: 16.0,
                          fontWeight: FontWeight.w300),
                    ),
                  ]),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 10.0,
              ),
              child: Container(
                height: 142.0,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    SizedBox(
                      width: 20.0,
                    ),
                    InkWell(
                      onTap: () {
                        /*Navigator.of(context).push(PageRouteBuilder(
                            pageBuilder: (_, __, ___) => new Anaheim(
                              title: AppLocalizations.of(context)
                                  .tr('anaheim'),
                              userId: widget.userId,
                            ),
                            transitionDuration: Duration(milliseconds: 600),
                            transitionsBuilder: (_,
                                Animation<double> animation,
                                __,
                                Widget child) {
                              return Opacity(
                                opacity: animation.value,
                                child: child,
                              );
                            }));*/
                      },
                      child: cardCountry(
                        colorTop: Color(0xFFF07DA4),
                        colorBottom: Color(0xFFF5AE87),
                        image: "assets/icons/amerika.png",
                        title: 'anaheim',
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        /*Navigator.of(context).push(PageRouteBuilder(
                            pageBuilder: (_, __, ___) => new LosAngeles(
                              title: 'Los Angeles',
                              userId: widget.userId,
                            ),
                            transitionDuration: Duration(milliseconds: 600),
                            transitionsBuilder: (_,
                                Animation<double> animation,
                                __,
                                Widget child) {
                              return Opacity(
                                opacity: animation.value,
                                child: child,
                              );
                            }));*/
                      },
                      child: cardCountry(
                          colorTop: Color(0xFF63CCD1),
                          colorBottom: Color(0xFF75E3AC),
                          image: "assets/icons/amerika.png",
                          title: 'losAngeles'),
                    ),
                    InkWell(
                      onTap: () {
                        /*Navigator.of(context).push(PageRouteBuilder(
                            pageBuilder: (_, __, ___) => new Florida(
                              title: AppLocalizations.of(context)
                                  .tr('florida'),
                              userId: widget.userId,
                            ),
                            transitionDuration: Duration(milliseconds: 600),
                            transitionsBuilder: (_,
                                Animation<double> animation,
                                __,
                                Widget child) {
                              return Opacity(
                                opacity: animation.value,
                                child: child,
                              );
                            }));*/
                      },
                      child: cardCountry(
                          colorTop: Color(0xFF9183FC),
                          colorBottom: Color(0xFFDB8EF6),
                          image: "assets/icons/amerika.png",
                          title: 'florida'),
                    ),
                    InkWell(
                      onTap: () {
                        /*Navigator.of(context).push(PageRouteBuilder(
                            pageBuilder: (_, __, ___) => new LasVegas(
                              title: AppLocalizations.of(context)
                                  .tr('lasVegas'),
                              userId: widget.userId,
                            ),
                            transitionDuration: Duration(milliseconds: 600),
                            transitionsBuilder: (_,
                                Animation<double> animation,
                                __,
                                Widget child) {
                              return Opacity(
                                opacity: animation.value,
                                child: child,
                              );
                            }));*/
                      },
                      child: cardCountry(
                          colorTop: Color(0xFF56AB2F),
                          colorBottom: Color(0xFFA8E063),
                          image: "assets/icons/amerika.png",
                          title: 'lasVegas'),
                    ),
                    InkWell(
                      onTap: () {
                       /* Navigator.of(context).push(PageRouteBuilder(
                            pageBuilder: (_, __, ___) => new NewYork(
                              title: AppLocalizations.of(context)
                                  .tr('newYork'),
                              userId: widget.userId,
                            ),
                            transitionDuration: Duration(milliseconds: 600),
                            transitionsBuilder: (_,
                                Animation<double> animation,
                                __,
                                Widget child) {
                              return Opacity(
                                opacity: animation.value,
                                child: child,
                              );
                            }));*/
                      },
                      child: cardCountry(
                          colorTop: Color(0xFF74EBD5),
                          colorBottom: Color(0xFFACB6E5),
                          image: "assets/icons/amerika.png",
                          title: 'newYork'),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 25.0,
            ),
            _recommended

          ],),),


      ),
    );
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
  final String? dataUser;
  final List? list;

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
    this.dataUser,
    this.list,
  });
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        primary: false,
        itemCount: 10,
        itemBuilder: (context, i) {
          // List<String> photo = List.from(list[i].data()['photo']);
          //List<String> service = List.from(list[i].data()['service']);
          //List<String> description = List.from(list[i].data()['description']);
          String title = 'title';
          // String type = list[i].data()['type'].toString();
          double rating = 4.5;
          String location = 'location';
          String image = 'https://www.seleqtionshotels.com/content/dam/seleqtions/Connaugth/TCPD_PremiumBedroom4_1235.jpg/jcr:content/renditions/cq5dam.web.1280.1280.jpeg';
          String id = 'id3';
          num price = 2000;
          //num latLang1 = list[i].data()['latLang1'];
          // num latLang2 = list[i].data()['latLang2'];

          return Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 20.0),
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
                          padding: const EdgeInsets.only(left: 15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                  width: 220.0,
                                  child: Text(
                                    title,
                                    style: _txtStyleTitle,
                                    overflow: TextOverflow.ellipsis,
                                  )),
                              Padding(padding: EdgeInsets.only(top: 5.0)),
                              Row(
                                children: <Widget>[
                                  ratingbar(
                                    starRating: rating,
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
                          padding: const EdgeInsets.only(right: 13.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "\$" + price.toString(),
                                style: TextStyle(
                                    fontSize: 25.0,
                                    color: Color(0xFF09314F),
                                    fontWeight: FontWeight.w500,
                                    fontFamily: "Gotik"),
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

class cardCountry extends StatelessWidget {
  final Color colorTop, colorBottom;
  final String image, title;
  cardCountry({required this.colorTop, required this.colorBottom, required this.title, required this.image});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 4.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 105.0,
            width: 105.0,
            decoration: BoxDecoration(
              boxShadow: [BoxShadow(blurRadius: 8.0, color: Colors.black12)],
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              gradient: LinearGradient(
                  colors: [colorTop, colorBottom],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight),
            ),
            child: Padding(
              padding: const EdgeInsets.only(right: 4.0),
              child: Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    image,
                    height: 60,
                    color: Colors.white,
                  )),
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: Text(
              title,
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: "Sofia",
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600),
            ),
          )
        ],
      ),
    );
  }
}



