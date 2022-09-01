import 'package:bloodspot/AllWidgets/submitPage.dart';
import 'package:bloodspot/pages/auth/login_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../AllWidgets/bottom_navigation.dart';
import '../../AllWidgets/progressDialog.dart';

class ProfileDetailsPage extends StatefulWidget {
  @override
  _ProfileDetailsPageState createState() => _ProfileDetailsPageState();
}

String gender = "";
String height;
String weight;
String bloodType = "";
String formattedDate;

String date_of_birth;

class _ProfileDetailsPageState extends State<ProfileDetailsPage> {
  TextEditingController dateinput = TextEditingController();

  @override
  void initState() {
    dateinput.text = "";
    super.initState();
  }

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(child: Text("A+"), value: "A+"),
      const DropdownMenuItem(child: Text("B+"), value: "B+"),
      const DropdownMenuItem(child: Text("O+"), value: "O+"),
      const DropdownMenuItem(child: Text("A-"), value: "A-"),
      const DropdownMenuItem(child: Text("B-"), value: "B-"),
      const DropdownMenuItem(child: Text("O-"), value: "O-"),
      const DropdownMenuItem(child: Text("AB+"), value: "AB+"),
      const DropdownMenuItem(child: Text("AB-"), value: "AB-")
    ];

    return menuItems;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: ScrollConfiguration(
        behavior: MyBehavior(),
        child: SingleChildScrollView(
          child: SizedBox(
            height: size.height,
            child: Stack(
              children: [
                SizedBox(
                  height: size.height,
                  child: Image.asset(
                    'assets/images/blood.jpg',
                    fit: BoxFit.fitHeight,
                  ),
                ),
                Center(
                  child: Column(
                    children: [
                      const Expanded(
                        child: SizedBox(),
                      ),
                      Expanded(
                        flex: 7,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaY: 25, sigmaX: 25),
                            child: SizedBox(
                              width: size.width * .9,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                      top: size.width * .15,
                                      bottom: size.width * .1,
                                    ),
                                    child: Text(
                                      'COMPLETE PROFILE',
                                      style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white.withOpacity(.8),
                                      ),
                                    ),
                                  ),

                                  // DATE OF BIRTH
                                  Container(
                                      height: size.width / 8,
                                      width: size.width / 1.25,
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.only(
                                          right: size.width / 30),
                                      decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(.1),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: TextField(
                                        style: TextStyle(
                                            color:
                                                Colors.white.withOpacity(.5)),
                                        controller:
                                            dateinput, //editing controller of this TextField
                                        decoration: InputDecoration(
                                          prefixIcon: Icon(
                                            Icons.calendar_today,
                                            color: Colors.white.withOpacity(.8),
                                          ),
                                          border: InputBorder.none,
                                          hintMaxLines: 1,
                                          hintText: "Date of Birth...",
                                          hintStyle: TextStyle(
                                            fontSize: 14,
                                            color: Colors.white.withOpacity(.5),
                                          ),
                                        ),
                                        readOnly:
                                            true, //set it true, so that user will not able to edit text
                                        onTap: () async {
                                          DateTime pickedDate =
                                              await showDatePicker(
                                                  context: context,
                                                  initialDate: DateTime.now(),
                                                  firstDate: DateTime(
                                                      2000), //DateTime.now() - not to allow to choose before today.
                                                  lastDate: DateTime(2101));

                                          if (pickedDate != null) {
                                            print(
                                                pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                            formattedDate =
                                                DateFormat('yyyy-MM-dd')
                                                    .format(pickedDate);
                                            print(
                                                formattedDate); //formatted date output using intl package =>  2021-03-16
                                            //you can implement different kind of Date Format here according to your requirement

                                            setState(() {
                                              dateinput.text =
                                                  formattedDate; //set output date to TextField value.
                                            });
                                          } else {
                                            print("Date is not selected");
                                          }
                                        },
                                      )),

                                  // BLOOD TYPE
                                  Container(
                                    height: size.width / 8,
                                    width: size.width / 1.25,
                                    alignment: Alignment.center,
                                    padding:
                                        EdgeInsets.only(right: size.width / 30),
                                    decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(.1),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: DropdownButtonFormField(
                                      style:
                                          const TextStyle(color: Colors.black),
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.bloodtype_rounded,
                                          color: Colors.white.withOpacity(.8),
                                        ),
                                        border: InputBorder.none,
                                        hintMaxLines: 1,
                                        hintText: "Blood Type",
                                        hintStyle: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white.withOpacity(.5),
                                        ),
                                      ),
                                      items: dropdownItems,
                                      value: selectedValue,
                                      onChanged: (val) {
                                        setState(() {
                                          bloodType = val;
                                        });
                                      },
                                    ),
                                  ),
                                  // HEIGHT
                                  Container(
                                    height: size.width / 8,
                                    width: size.width / 1.25,
                                    alignment: Alignment.center,
                                    padding:
                                        EdgeInsets.only(right: size.width / 30),
                                    decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(.1),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: TextField(
                                        style: TextStyle(
                                          color: Colors.white.withOpacity(.9),
                                        ),
                                        keyboardType: TextInputType.number,
                                        onChanged: (val) {
                                          setState(() {
                                            height = val;
                                          });
                                        },
                                        decoration: InputDecoration(
                                          prefixIcon: Icon(
                                            Icons.rule_rounded,
                                            color: Colors.white.withOpacity(.8),
                                          ),
                                          border: InputBorder.none,
                                          hintMaxLines: 1,
                                          hintText: "Height...",
                                          hintStyle: TextStyle(
                                            fontSize: 14,
                                            color: Colors.white.withOpacity(.5),
                                          ),
                                        )),
                                  ),

                                  // WEIGHT
                                  Container(
                                    height: size.width / 8,
                                    width: size.width / 1.25,
                                    alignment: Alignment.center,
                                    padding:
                                        EdgeInsets.only(right: size.width / 30),
                                    decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(.1),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: TextField(
                                        keyboardType: TextInputType.number,
                                        style: TextStyle(
                                          color: Colors.white.withOpacity(.9),
                                        ),
                                        onChanged: (val) {
                                          setState(() {
                                            weight = val;
                                          });
                                        },
                                        decoration: InputDecoration(
                                          prefixIcon: Icon(
                                            Icons.monitor_weight_outlined,
                                            color: Colors.white.withOpacity(.8),
                                          ),
                                          border: InputBorder.none,
                                          hintMaxLines: 1,
                                          hintText: "Weight...",
                                          hintStyle: TextStyle(
                                            fontSize: 14,
                                            color: Colors.white.withOpacity(.5),
                                          ),
                                        )),
                                  ),

                                  SizedBox(height: size.width * .3),
                                  InkWell(
                                    splashColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () {
                                      HapticFeedback.lightImpact();
                                      Fluttertoast.showToast(
                                        msg: 'Sign-Up button pressed',
                                      );

                                      // VALIDATE INPUTS
                                      if (weight.isEmpty) {
                                        displayToastMessage(
                                            "Weight must not be empty.",
                                            context);
                                      } else if (height.isEmpty) {
                                        displayToastMessage(
                                            "Height must not be empty",
                                            context);
                                      } else if (bloodType.isEmpty) {
                                        displayToastMessage(
                                            "Blood type must not be empty",
                                            context);
                                      } else {
                                        registerNewUser(context);
                                      }
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(
                                        bottom: size.width * .05,
                                      ),
                                      height: size.width / 8,
                                      width: size.width / 1.25,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(.1),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: const Text(
                                        'Sign-Up',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Expanded(
                        child: SizedBox(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
    BuildContext context,
    Widget child,
    AxisDirection axisDirection,
  ) {
    return child;
  }
}

// Firebase sign up

final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

void registerNewUser(BuildContext context) async {
  ProgressDialog(
    message: "Registering, Please wait...",
  );

  //save user info to database
  if (_firebaseAuth != null) //user created
  {
    DocumentReference<Map<String, dynamic>> users = FirebaseFirestore.instance
        .collection('users')
        .doc(_firebaseAuth.currentUser.uid);

    users
        .update({
          "date_of_birth": formattedDate,
          "height": height,
          "weight": weight,
          "bloodType": bloodType,
        })
        .then((value) => print("user added sucessfully "))
        .catchError((error) => print("Failed to add user: $error"));

    // usersRef.child(firebaseUser.uid).set(userDataMap);
    displayToastMessage(
        "Congratulations, your account has been created.", context);

    Navigator.pushNamed(context, '/home', arguments: {});
  } else {
    Navigator.pop(context);
    //error occured - display error msg
    displayToastMessage("New user account has not been Created.", context);
  }
}

displayToastMessage(String message, BuildContext context) {
  Fluttertoast.showToast(msg: message);
}
