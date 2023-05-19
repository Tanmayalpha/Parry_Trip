import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parry_trip2/screens/Trip/explore_trip.dart';

class TripScreen extends StatefulWidget {
  const TripScreen({Key? key}) : super(key: key);

  @override
  State<TripScreen> createState() => _TripScreenState();
}

class _TripScreenState extends State<TripScreen> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return  Scaffold(

      body: Stack(children: [

        Image.asset(
          "assets/images/destinationPopuler/tripBackground.png",
          height: height,
          fit: BoxFit.cover,
          width: double.infinity,
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'WHERE'.tr,
                  style: TextStyle(
                      fontFamily: "Sofia",
                      fontWeight: FontWeight.w700,
                      fontSize: 28.0),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  'START_PLANING'.tr,
                  style: TextStyle(
                      fontFamily: "Sofia",
                      fontWeight: FontWeight.w300,
                      fontSize: 18.0,
                      color: Colors.black45),
                ),
                SizedBox(
                  height: 11.0,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ExploreTripScreen(),));
                  },
                  child: Container(
                    height: 45.0,
                    width: 140.0,
                    decoration: BoxDecoration(
                        borderRadius:
                        BorderRadius.all(Radius.circular(5.0)),
                        border: Border.all(
                            color: Color(0xFF8DA2BF), width: 1.0)),
                    child: Center(
                      child: Text(
                        'EXPLORE_TRIP'.tr,
                        style: TextStyle(
                            fontFamily: "Sofia",
                            fontWeight: FontWeight.w500,
                            fontSize: 16.0,
                            color: Color(0xFF8DA2BF)),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.0)
              ],
            ),
          ),
        )

      ],),

    );
  }
}
