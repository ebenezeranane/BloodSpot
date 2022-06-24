import 'package:bloodspot/pages/auth/login.dart';
import 'package:bloodspot/pages/auth/signup.dart';
import 'package:bloodspot/pages/get_started/get_started.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';


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
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        
        primarySwatch: Colors.blue,
      ),
      home: const LogIn(),
    );
  }
}

