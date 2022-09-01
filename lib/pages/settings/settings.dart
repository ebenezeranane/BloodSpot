// ignore_for_file: avoid_unnecessary_containers

import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../AllWidgets/profile.dart';

class Settings extends StatefulWidget {
  const Settings({Key key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

FirebaseAuth _auth = FirebaseAuth.instance;

class _SettingsState extends State<Settings> {
  void editDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 5.0,
              sigmaY: 5.0,
            ),
            child: AlertDialog(
                title: const Text("Log Out"),
                content: const Text("Are you sure you want to log out?"),
                actions: [
                  TextButton(
                    onPressed: () {
                      _auth.signOut();
                      Navigator.pushReplacementNamed(context, '/');
                    },
                    child: const Text("OK"),
                  ),
                ]),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //AppBAr
        appBar: AppBar(
          elevation: 0.5,
          // leading: const Icon(
          //   Icons.arrow_back,
          //   color: Colors.black,
          // ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.power_settings_new,
                color: Colors.black,
              ),
              onPressed: () {
                // Display the edit dialog
                editDialog();
              },
            )
          ],
          backgroundColor: Colors.white,
          title: const Text(
            "Profile",
            style: TextStyle(color: Colors.black),
          ),
        ),
        //Body
        body: const SafeArea(
            child: MyWidget(
          name: "Andries Grootnook",
          email: "grrotnookA@gmail.com",
          image: "https://i.imgur.com/8CVSH15.jpg",
          phoneNumber: 7678678678678,
          weight: "33",
          height: "23",
          blood: "A+(Positive)",
          gender: "Male",
        )));
  }
}
