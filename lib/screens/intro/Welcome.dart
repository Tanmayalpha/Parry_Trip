import 'dart:async';
import 'package:flutter/material.dart';
import 'package:parry_trip2/AuthenticationView/login_page.dart';
import 'package:parry_trip2/constants/app_colors.dart';
import 'package:parry_trip2/screens/intro/SignUp.dart';
import 'package:parry_trip2/widgets/AppBtn.dart';

import 'login.dart';

/// Component UI
class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

/// Component UI
class _WelcomeScreenState extends State<WelcomeScreen>
    with TickerProviderStateMixin {
  /// Declare Animation
  ///

  late AnimationController animationController;
  var tapLogin = 0;
  var tapSignup = 0;

  @override

  /// Declare animation in initState
  void initState() {
    // TODO: implement initState
    /// Animation proses duration
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300))
          ..addStatusListener((statuss) {
            if (statuss == AnimationStatus.dismissed) {
              setState(() {
                tapLogin = 0;
                tapSignup = 0;
              });
            }
          });
    super.initState();
  }

  /// To dispose animation controller
  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  /// Play animation set forward reverse
  Future<Null> _Playanimation() async {
    try {
      await animationController.forward();
      await animationController.reverse();
    } on TickerCanceled {}
  }

  /// Component Widget layout UI
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    mediaQuery.devicePixelRatio;
    mediaQuery.size.height;
    mediaQuery.size.width;

    // var data = EasyLocalizationProvider.of(context).data;
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Stack(
              children: <Widget>[
                ///
                /// Set background video
                ///
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                              "assets/images/onBoardingImage/onBoarding.gif"),
                          fit: BoxFit.cover)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 5.1,
                      ),
                      SizedBox(
                        width: 70,
                        height: 30,
                        child: Divider(
                          thickness: 1,
                          color: colors.whiteTemp.withOpacity(0.4),
                        ),
                      ),
                      Text(
                        "Welcome to parryTrip",
                        style:
                            TextStyle(color: colors.whiteTemp.withOpacity(0.6)),
                      ),
                      SizedBox(
                        width: 40,
                        height: 30,
                        child: Divider(
                          thickness: 1,
                          color: colors.whiteTemp.withOpacity(0.4),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 6.2,
                      ),
                      Btn(
                          height: 50,
                          width: 320,
                          title: 'Signup',
                          onPress: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUp()));
                          }),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 70,
                            height: 30,
                            child: Divider(
                              endIndent: 5,
                              thickness: 1,
                              color: colors.whiteTemp.withOpacity(0.4),
                            ),
                          ),
                          Text(
                            "Or",
                            style: TextStyle(
                                color: colors.whiteTemp.withOpacity(0.6)),
                          ),
                          SizedBox(
                            width: 70,
                            height: 30,
                            child: Divider(
                              indent: 5,
                              thickness: 1,
                              color: colors.whiteTemp.withOpacity(0.4),
                            ),
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Login()));
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 18),
                          margin: EdgeInsets.symmetric(horizontal: 18),
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: colors.red),
                          ),
                          child: Center(
                            child: Text(
                              "Signin",
                              style: TextStyle(color: colors.whiteTemp),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                    top: 0,
                    right: 0,
                    left: 0,
                    child: Image.asset("assets/images/parry_trip_logo.png"))
              ],
            ),
          ],
        ));
  }
}

/// Button Custom widget
// ignore: must_be_immutable
class ButtonCustom extends StatelessWidget {
  late String txt;
  late GestureTapCallback ontap;
  late Color gradient1;
  late Color gradient2;
  late Color border;

  // ButtonCustom({required this.txt, required this.gradient1, required this.gradient2, required this.border});
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: Colors.white,
        child: LayoutBuilder(builder: (context, constraint) {
          return Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: Container(
              height: 55.0,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 2.0,
                  color: border,
                ),
                borderRadius: BorderRadius.circular(10.0),
                gradient: LinearGradient(colors: [
                  gradient1,
                  gradient2,
                ]),
              ),
              child: Center(
                  child: Text(
                txt,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 19.0,
                    fontWeight: FontWeight.w600,
                    fontFamily: "Sofia",
                    letterSpacing: 0.5),
              )),
            ),
          );
        }),
      ),
    );
  }
}

/// Set Animation Login if user click button login
