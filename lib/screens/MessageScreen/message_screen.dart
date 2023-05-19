import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parry_trip2/Helper/helper.dart';
import 'package:parry_trip2/constants/app_colors.dart';

class MessageScreen  extends StatefulWidget {
  const MessageScreen ({Key? key}) : super(key: key);

  @override
  State<MessageScreen > createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen > {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return  Scaffold(
      appBar: AppBar(
      backgroundColor: Colors.white,
      elevation: 0.0,
      title: Text(
         'CHAT'.tr,
        style: const TextStyle(
            fontFamily: "Sofia",
            color: Colors.black,
            fontWeight: FontWeight.w800,
            fontSize: 29.5,
            wordSpacing: 0.1),
      ),
      actions: <Widget>[],
    ),
      body: Stack(children: [

        Image.asset(
          "assets/images/destinationPopuler/destination1.png",
          height: height,
          fit: BoxFit.cover,
          width: double.infinity,
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 210.0,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 20.0,
                        color: Colors.black12.withOpacity(0.08))
                  ]),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 13.0, bottom: 10.0),
                    child: Text(
                       'bookItGo',
                      style: const TextStyle(
                          fontFamily: "Sofia",
                          fontSize: 23.0,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, right: 20.0),
                    child: Text(
                        'descBot',
                      style: const TextStyle(
                        color: Colors.black26,
                        fontFamily: "Sofia",
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  InkWell(
                    onTap: () {
                      /*Navigator.of(context).push(PageRouteBuilder(
                          pageBuilder: (_, __, ___) =>
                              chatBot()));*/
                    },
                    child: Container(
                      height: 45.0,
                      width: 180.0,
                      color: AppColor.activeColor,
                      child: Center(
                        child: Text(
                           'START_CHAT'.tr,
                          style: const TextStyle(
                              color: Colors.white,
                              fontFamily: "Sofia"),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        )


      ]),
    );
  }
}
