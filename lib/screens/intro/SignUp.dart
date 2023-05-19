import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:parry_trip2/constants/app_colors.dart';
import 'package:parry_trip2/constants/constant.dart';
import 'package:parry_trip2/screens/bottomNavBar/bottom_Nav_bar.dart';
import 'package:parry_trip2/screens/intro/login.dart';
import 'package:parry_trip2/widgets/AppBtn.dart';
import 'package:http/http.dart' as http;

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController nameController = TextEditingController();
  TextEditingController lastController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _registerFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: colors.whiteTemp,
          body: SingleChildScrollView(
            child: Form(
              key: _registerFormKey,
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
                          padding: EdgeInsets.only(left: 5),
                          child: Text(
                            "Signup",
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
                                  controller: nameController,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                      prefixIcon: Icon(
                                          Icons.perm_identity_sharp,
                                          color:
                                              colors.black54.withOpacity(0.2)),
                                      hintText: 'First Name',
                                      hintStyle: TextStyle(
                                          fontSize: 15.0,
                                          color:
                                              colors.black54.withOpacity(0.2)),
                                      border: InputBorder.none,
                                      contentPadding:
                                          EdgeInsets.only(left: 10, top: 10)),
                                  validator: (v) {
                                    if (v!.isEmpty) {
                                      return "UserName is required";
                                    }
                                    if (!v.contains("@")) {
                                      return "Enter Valid UserName";
                                    }
                                  },
                                ),
                                Divider(
                                  color: colors.black54.withOpacity(0.2),
                                ),
                                TextFormField(
                                  controller: lastController,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                      prefixIcon: Icon(
                                          Icons.perm_identity_sharp,
                                          color:
                                              colors.black54.withOpacity(0.2)),
                                      hintText: 'Last Name',
                                      hintStyle: TextStyle(
                                          fontSize: 15.0,
                                          color:
                                              colors.black54.withOpacity(0.2)),
                                      border: InputBorder.none,
                                      contentPadding:
                                          EdgeInsets.only(left: 10, top: 10)),
                                  validator: (v) {
                                    if (v!.isEmpty) {
                                      return "UserName is required";
                                    }
                                    if (!v.contains("@")) {
                                      return "Enter Valid UserName";
                                    }
                                  },
                                ),
                                Divider(
                                  color: colors.black54.withOpacity(0.2),
                                ),
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
                                      builder: (context) => Login()));
                            },
                            child: Text(
                              "Login",
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
                              loading: loading ? true : false,
                              title: 'Signup',
                              onPress: () {
                                if (nameController.text.length < 2) {
                                  Fluttertoast.showToast(
                                      msg: "Please Enter Valid First Name");
                                  return;
                                }
                                if (lastController.text.length < 2) {
                                  Fluttertoast.showToast(
                                      msg: "Please Enter Valid Last Name");
                                  return;
                                }
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
    try {
      Map param = {
        "first_name": nameController.text,
        "last_name": lastController.text,
        "email": emailController.text,
        "password": passwordController.text,
        "term": "testing",
      };
      print(param);
      var response =
          await http.post(Uri.parse("${baseUrl}auth/register"), body: param);
      Map data = jsonDecode(response.body);
      setState(() {
        loading = false;
      });
      print("${baseUrl}auth/register");
      print(response.body);
      if (data['status']) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Login()));
      } else {
        Fluttertoast.showToast(msg: "Server Error");
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
