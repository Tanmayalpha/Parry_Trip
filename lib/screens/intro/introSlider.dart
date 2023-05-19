import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:parry_trip2/constants/app_colors.dart';

import 'Welcome.dart';


class Introslider extends StatefulWidget {
  const Introslider({Key? key}) : super(key: key);

  @override
  State<Introslider> createState() => _IntrosliderState();
}

class _IntrosliderState extends State<Introslider> {

  List<Slide> slides = [];

  @override
  void initState() {
    super.initState();
    slides.add(
      Slide(
        title: "Management",
        description:
        'Management is the administration of an organization, whether it is a business,'
            ' a non-profit organization, or a government body. ',
        pathImage: "assets/images/onBoardingImage/onBoarding1.png",
        widthImage: 400,
        backgroundColor: AppColor.activeColor,
      ),
    );
    slides.add(
      Slide(
        title: "Chat",
        description:
        "Chat refers to the process of communicating, interacting and/or exchanging messages over the Internet. "
            "It involves two or more individuals that communicate through a chat-enabled service or software. ",
        pathImage: "assets/images/onBoardingImage/onBoarding2.png",
        heightImage: 370,
        widthImage: 400,
        backgroundColor: AppColor.activeColor,
      ),
    );
    slides.add(
      Slide(
        title: "Leadership",
        description:
        "Leadership is the ability of an individual or a group of individuals to influence and guide followers or other members of an organization.  ",
        pathImage: "assets/images/onBoardingImage/onBoarding3.png",
        heightImage: 370,
        widthImage: 400,
        backgroundColor: AppColor.activeColor,
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return IntroSlider(

      onDonePress: (){
        //introVideo();
        Navigator.push(context, MaterialPageRoute(builder: (context)=>WelcomeScreen()));
      },
      slides: slides,
      colorActiveDot: Colors.white,
    );
  }
}
