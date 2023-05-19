import 'package:flutter/material.dart';
import 'package:parry_trip2/constants/app_colors.dart';

import 'homeView.dart';

class HotelBookedScreen extends StatelessWidget {
  const HotelBookedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          'Hotel Booked',
          style: TextStyle(
            color: Colors.black,
            fontFamily: "Sofia",
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.check_circle_outline,
                size: 100,
                color: Colors.green,
              ),
              const SizedBox(height: 16.0),
              const Text(
                'Congratulations!',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16.0),
              const Text(
                'Your hotel booking has been confirmed.',
                style: TextStyle(fontSize: 18.0),
              ),
              const SizedBox(height: 32.0),
              /*const Text(
                'Booking Details',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),*/
              /*const SizedBox(height: 16.0),
              const Text(
                'Hotel Name: Grand Hotel',
                style: TextStyle(fontSize: 18.0),
              ),
              const SizedBox(height: 8.0),
              const Text(
                'Check-in Date: 01/04/2023',
                style: TextStyle(fontSize: 18.0),
              ),
              const SizedBox(height: 8.0),
              const Text(
                'Check-out Date: 03/04/2023',
                style: TextStyle(fontSize: 18.0),
              ),*/
              const SizedBox(height: 32.0),
              ElevatedButton(
                onPressed: () {
                  // Navigate back to the home screen
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HotelHomePage(),));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.activeColor,
                  padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
                ),
                child: const Text(
                  'Check Bookings',
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}