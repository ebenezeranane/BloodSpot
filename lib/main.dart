import 'package:bloodspot/AllWidgets/bottom_navigation.dart';
import 'package:bloodspot/pages/Maps/map.dart';
import 'package:bloodspot/pages/auth/admin_auth.dart';
import 'package:bloodspot/pages/auth/choose_auth.dart';
import 'package:bloodspot/pages/auth/login_page.dart';
import 'package:bloodspot/pages/auth/signup_page.dart';
import 'package:bloodspot/pages/get_started/get_started.dart';
import 'package:bloodspot/pages/home/home.dart';
import 'package:bloodspot/pages/searchScreen.dart';
import 'package:bloodspot/pages/userProfileDetail.dart';

import 'package:bloodspot/pages/auth/signup_page.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'DataHandler/appData.dart';

Future<Null> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

DatabaseReference usersRef =
    // ignore: deprecated_member_use
    FirebaseDatabase.instance.reference().child("users");

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (BuildContext context) => AppData(),
        child: MaterialApp(
          initialRoute: '/',
          routes: {
            '/': (context) => ChooseAuth(),
            '/adminlogin': (context) => AdminLoginPage(),
            '/signup': ((context) => SignUpPage()),
            '/home': (context) => const CustomBottomNavigation(),
            '/profilepage': (context) => ProfileDetailsPage(),
            '/': (context) => SignUpPage(),
            '/home': (context) => const CustomBottomNavigation()
          },
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
        ));
  }
}
