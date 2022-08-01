// ignore_for_file: avoid_unnecessary_containers

import 'dart:ui';
import 'package:flutter/material.dart';

import '../../AllWidgets/profile.dart';

class Settings extends StatefulWidget {
  const Settings({Key key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

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
                title: const Text("Sorry"),
                content: const Text(
                    "No course material found for this programme and year."),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
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
                Icons.edit_outlined,
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
            "Settings",
            style: TextStyle(color: Colors.black),
          ),
        ),
        //Body
        body: const SafeArea(
            child: MyWidget(
                name: "Andries Grootnook",
                email: "grrotnookA@gmail.com",
                image: "https://i.imgur.com/8CVSH15.jpg",
                phoneNumber: 0205444117,
                weight: 66,
                height: 176,
                blood: "A+(Positive)",
                gender: "Male",
                birthDay: 05,
                birthMonth: "June",
                birthYear: 1997)));
  }
}
