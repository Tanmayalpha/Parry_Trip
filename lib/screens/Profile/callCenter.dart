import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parry_trip2/constants/app_colors.dart';
import 'package:parry_trip2/screens/Profile/profile.dart';
import 'package:parry_trip2/widgets/AppBtn.dart';



class CallCenter extends StatefulWidget {
  const CallCenter({Key? key}) : super(key: key);

  @override
  State<CallCenter> createState() => _CallCenterState();
}

class _CallCenterState extends State<CallCenter> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController problemController = TextEditingController();
  final _profileFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: colors.whiteTemp,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: colors.whiteTemp,
          elevation: 0,
          title: Text("Call Center",style: TextStyle(
              fontSize: 14,fontWeight: FontWeight.normal
          ),),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _profileFormKey,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Call Center",style: TextStyle(color: colors.blackTemp,fontWeight: FontWeight.bold),),
                  SizedBox(height: 5,),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                     color: colors.yellow2.withOpacity(0.4),
                     border: Border.all(color: colors.yellow)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(" parryTrip parryTrip"
                          "parryTrip parryTrip parryTrip parryTrip parryTrip parryTrip parryTrip parryTripparryTrip"),
                    ),
                  ),
                  SizedBox(height: 15,),
                  Text("Name",style: TextStyle(color: colors.blackTemp,fontWeight: FontWeight.bold),),
                  SizedBox(height: 5,),
                  Container(
                    height: 50,
                    child: TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(
                        hintText: 'Input your name', hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                        fontFamily: "verdana_regular",
                        fontWeight: FontWeight.w400,
                      ),
                        focusColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                          const BorderSide(color: colors.grad2Color, width: 1.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                    ),
                      validator: (v) {
                        if (v!.isEmpty) {
                          return "Name is required";
                        }
                        if (!v.contains(" ")) {
                          return "Enter Valid Name";
                        }
                      },

                    ),
                  ),
                  SizedBox(height: 15,),
                  Text("Email",style: TextStyle(color: colors.blackTemp,fontWeight: FontWeight.bold),),
                  SizedBox(height: 5,),
                  Container(
                    height: 50,
                    child: TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        hintText: 'Input your Email', hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                        fontFamily: "verdana_regular",
                        fontWeight: FontWeight.w400,
                      ),
                        focusColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                          const BorderSide(color:colors.grad2Color, width: 1.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      validator: (v) {
                        if (v!.isEmpty) {
                          return "Email is required";
                        }
                        if (!v.contains("@")) {
                          return "Enter Valid Email Id";
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 15,),
                  Text("Details Problem",style: TextStyle(color: colors.blackTemp,fontWeight: FontWeight.bold),),
                  SizedBox(height: 5,),
                  Container(
                    height: 150,
                    child: TextFormField(
                      controller: problemController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(bottom: 80,left: 10),
                        hintText: 'Input your Problem', hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                        fontFamily: "verdana_regular",
                        fontWeight: FontWeight.w400,
                      ),
                        focusColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                          const BorderSide(color: colors.grad2Color, width: 1.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      validator: (v) {
                        if (v!.isEmpty) {
                          return "Problem is required";
                        }
                        if (!v.contains(" ")) {
                          return "Enter Valid Problem";
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 30,),
                  Btn1(
                      height: 50,
                      width: 320,
                      title: 'Input Data ',
                      onPress: () {
                        if (_profileFormKey.currentState!.validate()) {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) =>ProfileScreen()));
                        } else {
                          const snackBar = SnackBar(
                            content: Text('All Fields are required!'),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          //Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
                        }

                      }

                  ),
                ],
              ),
            ),
          ),
        ),

      ),
    );
  }
}
