import 'package:flutter/material.dart';
import 'package:parry_trip2/Helper/custom_nav_bar/custom_nav_bar.dart';
import 'package:parry_trip2/constants/ApiBaseHelper.dart';
import 'package:parry_trip2/constants/common.dart';
import 'package:parry_trip2/constants/constant.dart';
import 'package:parry_trip2/screens/BookingScreen/booking_screen.dart';
import 'package:parry_trip2/screens/HomeScreen/home_screen.dart';
import 'package:parry_trip2/screens/MessageScreen/message_screen.dart';
import 'package:parry_trip2/screens/Profile/profile.dart';
import 'package:parry_trip2/screens/Trip/trip_screen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int currentIndex = 0;
  Widget callPage(int current) {
    switch (current) {
      case 0:
        return const HomeScreen(
            /*userID: widget.userID*/
            );
        break;
      case 1:
        return const MessageScreen(
            /*userID: widget.userID,*/
            );
        break;

      case 2:
        return const TripScreen(
            /*userID: widget.userID,*/
            );
        break;

      case 3:
        return const BookingScreen(
            /*idUser: widget.userID,*/
            );
        break;

      case 4:
        return const ProfileScreen(
            /*userID: widget.userID,*/
            );
        break;
      default:
        return const HomeScreen(
            /*userID: widget.userID,*/
            );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProfile();
  }

  ApiBaseHelper apiBaseHelper = ApiBaseHelper();
  getProfile() async {
    await App.init();
    Map response =
        await apiBaseHelper.getAPICall(Uri.parse("${baseUrl}auth/me"));
    if (response['data'] != null) {
      name = response['data']['name'] ?? "";
      firstName = response['data']['first_name'] ?? "";
      lastName = response['data']['last_name'] ?? "";
      email = response['data']['email'] ?? "";
      password = App.localStorage.getString("password") ?? "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: callPage(currentIndex),
        bottomNavigationBar: BottomNavigationDotBar(
            color: Colors.black26,
            items: <BottomNavigationDotBarItem>[
              BottomNavigationDotBarItem(
                  icon: const IconData(0xe900, fontFamily: 'home'),
                  onTap: () {
                    setState(() {
                      currentIndex = 0;
                    });
                  }),
              BottomNavigationDotBarItem(
                  icon: const IconData(0xe900, fontFamily: 'message'),
                  onTap: () {
                    setState(() {
                      currentIndex = 1;
                    });
                  }),
              BottomNavigationDotBarItem(
                  icon: const IconData(
                    0xe900,
                    fontFamily: 'trip',
                  ),
                  onTap: () {
                    setState(() {
                      currentIndex = 2;
                    });
                  }),
              BottomNavigationDotBarItem(
                  icon: const IconData(
                    0xe900,
                    fontFamily: 'hearth',
                  ),
                  onTap: () {
                    setState(() {
                      currentIndex = 3;
                    });
                  }),
              BottomNavigationDotBarItem(
                  icon: const IconData(0xe900, fontFamily: 'profile'),
                  onTap: () {
                    setState(() {
                      currentIndex = 4;
                    });
                  }),
            ]));
  }
}
