import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parry_trip2/Library/rattings.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({Key? key}) : super(key: key);

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
       appBar: AppBar(
         backgroundColor: Colors.white,
         centerTitle: false,
         elevation: 0.0,
         title: Padding(
           padding: const EdgeInsets.only(top: 20.0, left: 5.0),
           child: Text(
             'RESERVATIONS'.tr,
             style: const TextStyle(
                 fontFamily: "Sofia",
                 fontSize: 36.0,
                 fontWeight: FontWeight.w800,
                 color: Colors.black),
           ),
         ),
       ),
      body: Container(
        child: ListView(children: [

          Padding(
              padding:EdgeInsets.only(top: 20.0, bottom: 0.0),
            child:  dataFirestore(
                /*userId: widget.idUser,
                list: snapshot.data.docs*/),

          )

        ],),

      ),
    );
  }
}

class dataFirestore extends StatelessWidget {
  final String? userId;
  dataFirestore({this.list, this.userId});
  final List? list;
  var _txtStyleTitle = TextStyle(
    color: Colors.black87,
    fontFamily: "Gotik",
    fontSize: 17.0,
    fontWeight: FontWeight.w800,
  );

  var _txtStyleSub = TextStyle(
    color: Colors.black26,
    fontFamily: "Gotik",
    fontSize: 12.5,
    fontWeight: FontWeight.w600,
  );

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var imageOverlayGradient = DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: FractionalOffset.bottomCenter,
          end: FractionalOffset.topCenter,
          colors: [
            const Color(0xFF000000),
            const Color(0x00000000),
            Colors.black,
            Colors.black,
            Colors.black,
            Colors.black,
          ],
        ),
      ),
    );

    return SizedBox.fromSize(
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          primary: false,
          itemCount: 10,
          itemBuilder: (context, i) {
            //List<String> photo = List.from(list[i].data()['photo']);
           // List<String> service = List.from(list[i].data()['service']);
           // List<String> description = List.from(list[i].data()['description']);
            String title = 'title';
            //String type = 'type';
            double rating = 4.5;
            String image = 'https://www.seleqtionshotels.com/content/dam/seleqtions/Connaugth/TCPD_PremiumBedroom4_1235.jpg/jcr:content/renditions/cq5dam.web.1280.1280.jpeg';
            String id = 'id';
            String checkIn = 'Check In';
            String checkOut = 'Check Out';
            String count = 'Count';
            String locationReservision = 'Location';
            String rooms = 'Rooms';
            String roomName = 'Room Name';
            String information = 'Information Room';

            num priceRoom = 250;
            num price = 150;
           // num latLang1 = list[i].data()['latLang1'];
            //num latLang2 = list[i].data()['latLang2'];

            //DocumentSnapshot _list = list[i];

            return InkWell(
              onTap: () {
                /*Navigator.of(context).push(PageRouteBuilder(
                    pageBuilder: (_, __, ___) => new BookingDetail(
                      userId: userId,
                      titleD: title,
                      idD: id,
                      imageD: image,
                      information: information,
                      priceRoom: priceRoom,
                      roomName: roomName,
                      latLang1D: latLang1,
                      latLang2D: latLang2,
                      priceD: price,
                      listItem: _list,
                      descriptionD: description,
                      photoD: photo,
                      ratingD: rating,
                      serviceD: service,
                      typeD: type,
                      checkIn: checkIn,
                      checkOut: checkOut,
                      count: count,
                      locationReservision: locationReservision,
                      rooms: rooms,
                    ),
                    transitionDuration: Duration(milliseconds: 1000),
                    transitionsBuilder:
                        (_, Animation<double> animation, __, Widget child) {
                      return Opacity(
                        opacity: animation.value,
                        child: child,
                      );
                    }));*/
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 20.0),
                child: Container(
                  height: 280.0,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black12.withOpacity(0.1),
                            blurRadius: 3.0,
                            spreadRadius: 1.0)
                      ]),
                  child: Column(children: [
                    Container(
                      height: 165.0,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(10.0),
                            topLeft: Radius.circular(10.0)),
                        image: DecorationImage(
                            image: NetworkImage(image), fit: BoxFit.cover),
                      ),
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10.0, right: 10.0),
                        child: CircleAvatar(
                            radius: 20.0,
                            backgroundColor: Colors.black54,
                            child: InkWell(
                              onTap: () {
                                /*showDialog(
                                    context: context,
                                    builder: (_) => NetworkGiffyDialog(
                                      image: Image.network(
                                        image,
                                        fit: BoxFit.cover,
                                      ),
                                      title: Text(
                                          'CANCEL_BOOKING'.tr,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontFamily: "Gotik",
                                              fontSize: 22.0,
                                              fontWeight: FontWeight.w600)),
                                      description: Text(
                                       'ARE_YOU_WANT'.tr +
                                            title,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontFamily: "Popins",
                                            fontWeight: FontWeight.w300,
                                            color: Colors.black26),
                                      ),
                                      onOkButtonPressed: () {
                                        Navigator.pop(context);

                                        FirebaseFirestore.instance
                                            .runTransaction(
                                                (transaction) async {
                                              DocumentSnapshot snapshot =
                                              await transaction
                                                  .get(list[i].reference);
                                              await transaction
                                                  .delete(snapshot.reference);
                                              SharedPreferences prefs =
                                              await SharedPreferences
                                                  .getInstance();
                                              prefs.remove(title);
                                            });
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content: Text(
                                              AppLocalizations.of(context)
                                                  .tr('cancelBooking2') +
                                                  title),
                                          backgroundColor: Colors.red,
                                          duration: Duration(seconds: 3),
                                        ));
                                      },
                                    ));*/

                              },
                              child: const Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                            )),
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
                                      Text(locationReservision, style: _txtStyleSub)
                                    ],
                                  ),
                                ),
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
                                Text('PER_NIGHT'.tr,
                                    style: _txtStyleSub.copyWith(fontSize: 11.0))
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 6.9),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                  'CHECK_IN'.tr +
                                      " : \t",
                                  style: _txtStyleSub.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black)),
                              Padding(padding: EdgeInsets.only(top: 3.0)),
                              Text(checkIn, style: _txtStyleSub)
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 6.9),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                  'CHECK_OUT'.tr +
                                      " : \t",
                                  style: _txtStyleSub.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black)),
                              Padding(padding: EdgeInsets.only(top: 3.0)),
                              Text(checkOut, style: _txtStyleSub)
                            ],
                          ),
                        )
                      ],
                    ),
                  ]),
                ),
              ),
            );
          },
        ));
  }
}
