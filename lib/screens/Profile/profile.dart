import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:parry_trip2/Splash/Splash.dart';
import 'package:parry_trip2/constants/app_colors.dart';
import 'package:parry_trip2/constants/common.dart';
import 'package:parry_trip2/constants/constant.dart';
import 'package:parry_trip2/screens/intro/login.dart';
import 'callCenter.dart';
import 'editprofile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: colors.whiteTemp,
          body: ListView(
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height / 3.1,
                        width: MediaQuery.of(context).size.width / 1,
                        child: Stack(
                          children: [
                            Positioned(
                                height:
                                    MediaQuery.of(context).size.height / 3.1,
                                width: MediaQuery.of(context).size.width / 1,
                                child: Container(
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              'assets/images/bannerProfile.png'),
                                          fit: BoxFit.fill)),
                                )),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 25),
                              child: Positioned(
                                  top: 0,
                                  right: 0,
                                  left: 10,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          CircleAvatar(
                                              // backgroundImage:
                                              // FileImage(imageFile ?? File(" ")),
                                              backgroundColor: colors.black54,
                                              radius: 40,
                                              child: Icon(
                                                Icons.person,
                                                size: 60,
                                                color: colors.blackTemp,
                                              ) //Text
                                              ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                name,
                                                style: TextStyle(
                                                    color: colors.blackTemp,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                email,
                                                style: TextStyle(
                                                    color: colors.black54),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ],
                                  )),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => EditProfile()));
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Image.asset(
                                        "assets/icons/profile.png",
                                        height: 25,
                                        width: 25,
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        "Edit Profile",
                                        style: TextStyle(
                                            color: colors.black54,
                                            fontSize: 12),
                                      ),
                                    ],
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    color: colors.black54,
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                              thickness: 1,
                              color: colors.black54.withOpacity(0.2),
                              height: MediaQuery.of(context).size.height / 14.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                      "assets/icons/card.png",
                                      height: 25,
                                      width: 25,
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      "Create Card",
                                      style: TextStyle(
                                          color: colors.black54, fontSize: 12),
                                    ),
                                  ],
                                ),
                                InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  EditProfile()));
                                    },
                                    child: Icon(
                                      Icons.arrow_forward_ios,
                                      color: colors.black54,
                                    )),
                              ],
                            ),
                            Divider(
                              thickness: 1,
                              color: colors.black54.withOpacity(0.2),
                              height: MediaQuery.of(context).size.height / 14.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                      "assets/icons/callCenter.png",
                                      height: 25,
                                      width: 25,
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      "Call Center",
                                      style: TextStyle(
                                          color: colors.black54, fontSize: 12),
                                    ),
                                  ],
                                ),
                                InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  CallCenter()));
                                    },
                                    child: Icon(
                                      Icons.arrow_forward_ios,
                                      color: colors.black54,
                                    )),
                              ],
                            ),
                            Divider(
                              thickness: 1,
                              color: colors.black54.withOpacity(0.2),
                              height: MediaQuery.of(context).size.height / 14.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                      "assets/icons/language.png",
                                      height: 25,
                                      width: 25,
                                      color: colors.black54,
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      "Change Language",
                                      style: TextStyle(
                                          color: colors.black54, fontSize: 12),
                                    ),
                                  ],
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: colors.black54,
                                ),
                              ],
                            ),
                            // Divider(thickness: 1,color:colors.black54.withOpacity(0.2),height: MediaQuery.of(context).size.height/14.0,),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //   children: [
                            //     Row(
                            //       children: [
                            //         Image.asset("assets/images/box.png",height: 25,width: 25,color: colors.black54,),
                            //         SizedBox(width: 8,),
                            //         Text("Get Source Code",style: TextStyle(color: colors.black54,fontSize: 12),),
                            //       ],
                            //     ),
                            //     Icon(Icons.arrow_forward_ios,color: colors.black54,),
                            //   ],
                            // ),
                            Divider(
                              thickness: 1,
                              color: colors.black54.withOpacity(0.2),
                              height: MediaQuery.of(context).size.height / 14.0,
                            ),
                            InkWell(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text("Logout"),
                                        content:
                                            Text("Do you want to proceed?"),
                                        actions: <Widget>[
                                          ElevatedButton(
                                            child: Text('No'),
                                            /*   textColor: Theme.of(context).colorScheme.primary,
                              shape: RoundedRectangleBorder(
                                  side: BorderSide(color: Colors.transparent)),*/
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                          ),
                                          ElevatedButton(
                                              child: Text('Yes'),
                                              /* shape: RoundedRectangleBorder(
                                    side: BorderSide(color: Colors.transparent)),
                                textColor: Theme.of(context).colorScheme.primary,*/
                                              onPressed: () async {
                                                await App.init();
                                                App.localStorage.clear();
                                                //Common().toast("Logout");
                                                Navigator.pushAndRemoveUntil(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            SplashScreen()),
                                                    (route) => false);
                                              }),
                                        ],
                                      );
                                    });
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.login,
                                        color: colors.black54,
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        "Logout",
                                        style: TextStyle(
                                            color: colors.black54,
                                            fontSize: 12),
                                      ),
                                    ],
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    color: colors.black54,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
