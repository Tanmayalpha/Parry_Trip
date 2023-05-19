import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:parry_trip2/constants/ApiBaseHelper.dart';
import 'package:parry_trip2/constants/app_colors.dart';
import 'package:parry_trip2/constants/common.dart';
import 'package:parry_trip2/constants/constant.dart';
import 'package:parry_trip2/screens/Profile/profile.dart';
import 'package:parry_trip2/widgets/AppBtn.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController nameController = TextEditingController();
  TextEditingController lastController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _profileFormKey = GlobalKey<FormState>();

  File? imageFile;
  final ImagePicker _picker = ImagePicker();

  Future<bool> showExitPopup() async {
    return await showDialog(
          //show confirm dialogue
          //the return value will be from "Yes" or "No" options
          context: context,
          builder: (context) => AlertDialog(
              title: Text('Select Image'),
              content: Row(
                // crossAxisAlignment: CrossAxisAlignment.s,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _getFromCamera();
                    },
                    //return false when click on "NO"
                    child: Text('Camera'),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _getFromGallery();
                      // Navigator.pop(context,true);
                      // Navigator.pop(context,true);
                    },
                    //return true when click on "Yes"
                    child: Text('Gallery'),
                  ),
                ],
              )),
        ) ??
        false; //if showDialouge had returned null, then return false
  }

  _getFromGallery() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 100);
    /* PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );*/
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
      Navigator.pop(context);
    }
  }

  _getFromCamera() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.camera, imageQuality: 100);
    /*  PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
    );*/
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
      Navigator.pop(context);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController.text = firstName;
    lastController.text = lastName;
    emailController.text = email;
    passwordController.text = password;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: colors.whiteTemp,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: AppColor.activeColor,
          elevation: 0,
          title: Text(
            "Edit Profile",
            style: TextStyle(
                fontFamily: "Gotik", fontSize: 16.0, color: Colors.white),
          ),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _profileFormKey,
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                Center(
                  child: SizedBox(
                    height: 140,
                    width: 140,
                    child: Stack(
                      children: [
                        CircleAvatar(
                            backgroundImage: FileImage(imageFile ?? File(" ")),
                            backgroundColor: colors.black54,
                            radius: 60,
                            child: Icon(
                              Icons.person,
                              size: 60,
                              color: colors.blackTemp,
                            ) //Text
                            ),
                        Positioned(
                            right: 8,
                            bottom: 13,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                    color: colors.primary,
                                    borderRadius: BorderRadius.circular(20)),
                                child: InkWell(
                                    onTap: () {
                                      showExitPopup();
                                    },
                                    child: Center(
                                        child: Icon(
                                      Icons.camera_alt,
                                      color: colors.whiteTemp,
                                      size: 18,
                                    ))),
                              ),
                            )),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  child: Column(
                    children: [
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        elevation: 5,
                        child: Container(
                          width: MediaQuery.of(context).size.width / 1.0,
                          height: 50,
                          child: TextFormField(
                            controller: nameController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                                hintText: 'First Name',
                                hintStyle: TextStyle(
                                    fontSize: 15.0,
                                    color: colors.black54.withOpacity(0.2)),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(left: 10)),
                            validator: (v) {
                              if (v!.isEmpty) {
                                return "Name is required";
                              }
                              if (!v.contains("")) {
                                return "Enter Valid Name";
                              }
                            },
                          ),
                        ),
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        elevation: 5,
                        child: Container(
                          width: MediaQuery.of(context).size.width / 1.0,
                          height: 50,
                          child: TextFormField(
                            controller: lastController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                                hintText: 'Last Name',
                                hintStyle: TextStyle(
                                    fontSize: 15.0,
                                    color: colors.black54.withOpacity(0.2)),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(left: 10)),
                            validator: (v) {
                              if (v!.isEmpty) {
                                return "Name is required";
                              }
                              if (!v.contains("")) {
                                return "Enter Valid Name";
                              }
                            },
                          ),
                        ),
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        elevation: 5,
                        child: Container(
                          width: MediaQuery.of(context).size.width / 1.0,
                          height: 50,
                          child: TextFormField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                                hintText: 'Email',
                                hintStyle: TextStyle(
                                    fontSize: 15.0,
                                    color: colors.black54.withOpacity(0.2)),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(left: 10)),
                            validator: (v) {
                              if (v!.isEmpty) {
                                return "Name is required";
                              }
                              if (!v.contains("")) {
                                return "Enter Valid Name";
                              }
                            },
                          ),
                        ),
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        elevation: 5,
                        child: Container(
                          width: MediaQuery.of(context).size.width / 1.0,
                          height: 50,
                          child: TextFormField(
                            obscureText: true,
                            controller: passwordController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                                hintText: 'Password',
                                hintStyle: TextStyle(
                                    fontSize: 15.0,
                                    color: colors.black54.withOpacity(0.2)),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(left: 10)),
                            validator: (v) {
                              if (v!.isEmpty) {
                                return "Name is required";
                              }
                              if (!v.contains("")) {
                                return "Enter Valid Name";
                              }
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Btn1(
                          height: 50,
                          width: 320,
                          loading: loading,
                          title: 'Update Profile',
                          onPress: () {
                            setState(() {
                              loading = true;
                            });
                            loginApi();
                          }),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool loading = false;
  ApiBaseHelper apiBaseHelper = ApiBaseHelper();
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
      Map response = await apiBaseHelper.postAPICall(
          Uri.parse("${baseUrl}auth/me"), param);
      setState(() {
        loading = false;
      });
      if (response['status']) {
        name = "${nameController.text} ${lastController.text}";
        email = emailController.text;
        App.localStorage.setString("password", passwordController.text);
        Fluttertoast.showToast(msg: "Profile Updated");
        Navigator.pop(context);
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
