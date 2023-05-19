import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:parry_trip2/constants/app_colors.dart';
import 'package:parry_trip2/constants/common.dart';
import 'package:parry_trip2/constants/constant.dart';
import 'package:parry_trip2/screens/bottomNavBar/bottom_Nav_bar.dart';
import 'package:parry_trip2/widgets/AppBtn.dart';
import 'package:http/http.dart' as http;
import 'SignUp.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _registerFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: colors.whiteTemp,
          body: Form(
            key: _registerFormKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height / 2.3,
                    width: MediaQuery.of(context).size.width / 1,
                    child: Stack(
                      children: [
                        Positioned(
                            height: MediaQuery.of(context).size.height / 2.3,
                            width: MediaQuery.of(context).size.width / 1,
                            child: Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/loginbg.png'),
                                      fit: BoxFit.fill)),
                            )),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 8),
                          child: Text(
                            "Login",
                            style: TextStyle(
                                color: colors.blackTemp,
                                fontWeight: FontWeight.bold,
                                fontSize: 25),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            elevation: 5,
                            child: Container(
                                child: Column(
                              children: [
                                TextFormField(
                                  controller: emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.email_outlined,
                                          color:
                                              colors.black54.withOpacity(0.2)),
                                      hintText: 'Email',
                                      hintStyle: TextStyle(
                                          fontSize: 15.0,
                                          color:
                                              colors.black54.withOpacity(0.2)),
                                      border: InputBorder.none,
                                      contentPadding:
                                          EdgeInsets.only(left: 10, top: 10)),
                                  validator: (v) {
                                    if (v!.isEmpty) {
                                      return "Email is required";
                                    }
                                    if (!v.contains("@")) {
                                      return "Enter Valid Email Id";
                                    }
                                  },
                                ),
                                Divider(
                                  color: colors.black54.withOpacity(0.2),
                                ),
                                TextFormField(
                                  controller: passwordController,
                                  obscureText: true,
                                  keyboardType: TextInputType.name,
                                  decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.lock_open_rounded,
                                          color:
                                              colors.black54.withOpacity(0.2)),
                                      hintText: 'Password',
                                      hintStyle: TextStyle(
                                          fontSize: 15.0,
                                          color:
                                              colors.black54.withOpacity(0.2)),
                                      border: InputBorder.none,
                                      contentPadding:
                                          EdgeInsets.only(left: 10, top: 12)),
                                  validator: (v) {
                                    if (v!.isEmpty) {
                                      return "Password is required";
                                    }
                                  },
                                ),
                              ],
                            ))),
                        SizedBox(
                          height: 25,
                        ),
                        Center(
                          child: InkWell(
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignUp()));
                            },
                            child: Text(
                              "Create Account",
                              style: TextStyle(
                                  color: Colors.black,
                                  decoration: TextDecoration.underline,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 16),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Center(
                          child: Btn1(
                              height: 50,
                              width: 320,
                              title: 'Signin',
                              loading: loading,
                              onPress: () {
                                if (!emailController.text.contains("@") ||
                                    !emailController.text.contains(".")) {
                                  Fluttertoast.showToast(
                                      msg: "Please Enter Valid Email");
                                  return;
                                }
                                if (passwordController.text.length < 8) {
                                  Fluttertoast.showToast(
                                      msg:
                                          "Please Enter Valid Password minimum character is 8");
                                  return;
                                }
                                setState(() {
                                  loading = true;
                                });
                                loginApi();
                                /*if (_registerFormKey.currentState!.validate()) {

                                } else {
                                  const snackBar = SnackBar(
                                    content: Text('All Fields are required!'),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                  //Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
                                }*/
                              }),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }

  bool loading = false;
  void loginApi() async {
    await App.init();
    try {
      Map param = {
        "email": emailController.text,
        "password": passwordController.text,
        "device_name": Platform.isAndroid ? "Android" : "IOS",
      };
      print(param);
      var response =
          await http.post(Uri.parse("${baseUrl}auth/login"), body: param);
      Map data = jsonDecode(response.body);
      setState(() {
        loading = false;
      });
      print(response.body);
      if (data['token'] != null) {
        App.localStorage.setString("token", data['token']);
        App.localStorage.setString("password", passwordController.text);

        Navigator.push(
            context, MaterialPageRoute(builder: (context) => BottomNavBar()));
      } else {
        Fluttertoast.showToast(msg: "Invalid Credentials");
      }
    } catch (e) {
      setState(() {
        loading = false;
      });
      /*Navigator.push(
          context, MaterialPageRoute(builder: (context) => BottomNavBar()));*/
    } finally {
      setState(() {
        loading = false;
      });
    }
  }
}
