import 'package:bloodspot/AllWidgets/bottom_navigation.dart';
import 'package:bloodspot/pages/Maps/map.dart';
import 'package:bloodspot/pages/auth/login_page.dart';
import 'package:bloodspot/pages/auth/signup_page.dart';
import 'package:bloodspot/pages/get_started/get_started.dart';
import 'package:bloodspot/pages/home/home.dart';
import 'package:bloodspot/pages/searchScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'DataHandler/appData.dart';


Future<Null>main() async{
  WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();
  
  runApp( MyApp());
}

DatabaseReference usersRef =
    FirebaseDatabase.instance.reference().child("users");

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) =>AppData(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          
          primarySwatch: Colors.blue,
        ),
        home: GetStartedPage()     ),
    );
  }
}

