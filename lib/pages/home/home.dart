import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../AllWidgets/appbar.dart';
import '../../AllWidgets/card.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    

    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomCenter,
              colors: [Color.fromARGB(255, 78, 54, 255), Colors.white])),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
              child: Column(
            children: [
              Customappbar(
                  userName: "",
                  userImage: "https://i.imgur.com/kQbx35z.jpg"),
              Container(
                width: MediaQuery.of(context).size.width / 2,
                margin: const EdgeInsets.only(bottom: 30),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(80, 192, 192, 192),
                  borderRadius: BorderRadius.circular(20),
                ),
                height: MediaQuery.of(context).size.height * 0.04,
                child: const Center(
                  child: Text("Swipe Right to See Next",
                      style: TextStyle(color: Colors.white70)),
                ),
              ),
              Expanded(
                  child: PageView(
                controller: PageController(
                  viewportFraction: 0.85,
                  initialPage: 0,
                ),
                scrollDirection: Axis.horizontal,
                children: const [
                  MyCard(
                   
                    day: "Today",
                    distance: 11.5,
                   
                    image: 'assets/images/blood_donation.jpeg',
                  ),
                  MyCard(
                    
                    day: "Yesterday",
                    distance: 2,
                   
                    image: 'assets/images/blood_donation.jpeg',

                  ),
                  MyCard(
                    
                    day: "Today",
                    distance: 11.5,
                   
                    image: 'assets/images/blood_donation.jpeg',
                    urlshare: 'www.google.com',
                  ),
                  MyCard(
                    
                    day: "Yesterday",
                    distance: 2,
                    
                    image: 'assets/images/blood_donation.jpeg',

                    urlshare: 'www.facebook.com',
                  ),
                  MyCard(
                    
                    day: "Today",
                    distance: 11.5,
                   
                    image: 'assets/images/blood_donation.jpeg',
                    urlshare: 'www.instagram.com',
                  ),
                ],
              )),
              SizedBox(
                  height: 50,
                  child: Container(
                      //color: Colors.black
                      )),
            ],
          ))),
    );
  }
}
