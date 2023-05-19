import 'dart:async';
import 'package:flutter/material.dart';
import 'package:parry_trip2/AuthenticationView/login_page.dart';
import 'package:parry_trip2/constants/app_colors.dart';
import 'package:parry_trip2/constants/common.dart';
import 'package:parry_trip2/screens/intro/introSlider.dart';

import '../screens/bottomNavBar/bottom_Nav_bar.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String? uid;
  String? type;
  bool? isSeen;

  // void checkingLogin() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     uid = prefs.getString('USERID');
  //     type = prefs.getString('Role');
  //   });
  // }

  // checkFirstSeen() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   bool _seen = (prefs.getBool('seen') ?? false);
  //
  //   if (_seen) {
  //     print("this is working here");
  //     if(uid == "" || uid == null ){
  //       // return SeekerDrawerScreen();
  //       Navigator.push(context, MaterialPageRoute(builder: (context) => WelcomeScreen()));
  //     }
  //     else{
  //       print("hello user here  ${uid} and ${type}");
  //       if(type == "seeker") {
  //         print("working this here");
  //         Navigator.push(context,
  //             MaterialPageRoute(builder: (context) => Dashboard()));
  //       }
  //       else{
  //         print("working now here ");
  //         Navigator.push(context,
  //             MaterialPageRoute(builder: (context) => RecruiterDashboard()));
  //         /// jsut for ddummy data RecruiterDashboard data is use
  //       }
  //       // Navigator.push(context,
  //       //     MaterialPageRoute(builder: (context) => RecruiterDashboard()));
  //     }
  //
  //     // Navigator.of(context).pushReplacement(
  //     //     new MaterialPageRoute(builder: (context) => new LoginScreen()));
  //   } else {
  //     await prefs.setBool('seen', true);
  //     Navigator.of(context).pushReplacement(
  //         new MaterialPageRoute(builder: (context) => new IntroSlider()));
  //   }
  // }

  @override
  void initState() {
    // TODO: implement initState
    // Future.delayed(Duration(milliseconds: 500),(){
    //   return ch eckingLogin();
    // });

    // Timer(Duration(seconds: 3), () {Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> IntroSlider()));});
    super.initState();
    checkLogin();
  }

  void checkLogin() async {
    await App.init();
    if (App.localStorage.getString("token") != null) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => BottomNavBar()));
    } else {
      Future.delayed(Duration(seconds: 3), () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Introslider()));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Container(
            decoration: BoxDecoration(
              color: AppColor.halfWhite,
            ),
            child: Center(
              child: Image.asset(
                'assets/images/parry_trip_logo.png',
                scale: 2,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
