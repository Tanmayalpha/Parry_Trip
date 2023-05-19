import 'package:flutter/material.dart';
import 'package:parry_trip2/screens/HomeScreen/Hotel/ratting.dart';

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({Key? key}) : super(key: key);

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'reviews',
          style: TextStyle(
              fontFamily: "Sofia",
              fontSize: 19.0,
              color: Colors.black,
              fontWeight: FontWeight.w700),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 20.0,
            ),
              ratingCard(userId: "", ),
            SizedBox(
              height: 15.0,
            )
          ],
        ),
      ),
      floatingActionButton:  FloatingActionButton(
          elevation: 0.0,
          child:  Icon(Icons.add),
          backgroundColor: new Color(0xFF09314F),
          onPressed: () {
            Navigator.of(context).push(PageRouteBuilder(
                pageBuilder: (_, __, ___) =>  RattingScreen(
                  documentId: 'title',
                  name: 'name',
                  photoProfile: 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png',
                )));
          }),
    );
  }
}
class ratingCard extends StatelessWidget {
  final String? userId;
  ratingCard({this.list, this.userId});
  final List? list;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          primary: false,
          itemCount: 3,
          itemBuilder: (context, i) {
            String pp = 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png';
            String review = 'Detail rating';
            String name = 'Name';
            String rating = 'rating';
            return Padding(
              padding: const EdgeInsets.only(left: 0.0, right: 0.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        height: 40.0,
                        width: 40.0,
                        decoration: BoxDecoration(
                          color: Color(0xFF09314F).withOpacity(0.1),
                          image: DecorationImage(
                              image: NetworkImage(
                                pp,
                              ),
                              fit: BoxFit.cover),
                          borderRadius: BorderRadius.all(Radius.circular(50.0)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              name,
                              style: TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 18.0),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.star,
                              size: 22.0,
                              color: Colors.yellow,
                            ),

                            Padding(
                              padding: const EdgeInsets.only(top: 3.0),
                              child: Text(
                                rating,
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontFamily: "Sofia",
                                    fontSize: 16.0),
                              ),
                            ),

                            // Text("(233 Rating)",style: TextStyle(fontWeight: FontWeight.w500,fontFamily: "Sofia",fontSize: 11.0,color: Colors.black38),),
                            SizedBox(
                              width: 35.0,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding:
                    const EdgeInsets.only(left: 0.0, right: 0.0, top: 10.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width - 40,
                      padding: EdgeInsets.only(
                          left: 15.0, top: 15.0, bottom: 15.0, right: 15.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(30.0),
                            bottomLeft: Radius.circular(30.0),
                            topRight: Radius.circular(30.0),
                            topLeft: Radius.circular(30.0),
                          ),
                          color: Color(0xFF09314F).withOpacity(0.1)),
                      child: Text(
                        review,
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Colors.black54,
                            fontSize: 17.5),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}

