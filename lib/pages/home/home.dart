import 'package:bloodspot/AllWidgets/progressDialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../AllWidgets/appbar.dart';
import '../../AllWidgets/card.dart';

List<GetCampaign> campaigns = [];

// get data from Firebase
// void initFirebase() {
//   FirebaseFirestore.instance
//       .collection("hospitals_db")
//       .get()
//       .then((querySnapshot) {
//     for (var result in querySnapshot.docs) {
//       FirebaseFirestore.instance
//           .collection("hospitals_db")
//           .doc(result.id)
//           .collection("donation_campaigns")
//           .get()
//           .then((querySnapshot) {
//         for (var result in querySnapshot.docs) {
//           print(result.data());
//           print(result['posted_by']);

//         }
//       });
//     }
//   });
// }

class GetCampaign extends StatelessWidget {
  final String documentId;

  GetCampaign(this.documentId);

  @override
  Widget build(BuildContext context) {
    CollectionReference campaigns =
        FirebaseFirestore.instance.collection('donation_campaigns');

    return FutureBuilder<DocumentSnapshot>(
      future: campaigns.doc(documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data.data() as Map<String, dynamic>;

          return MyCard(
            image: "assets/images/blood_donation.jpeg",
            hospitalName: data['posted_by'],
            time: data['time'].toString(),
            title: data['title'],
            day: data['day'],
            distance: data['distance'],
          );
        }

        return const Center(
          child: SizedBox(
            height: 40,
            child: CircularProgressIndicator(
              color: Colors.deepPurple,
              
            ),
          ),
        );
      },
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();

    FirebaseFirestore.instance
        .collection("donation_campaigns")
        .get()
        .then((querySnapshot) {
      for (var result in querySnapshot.docs) {
        if (campaigns.length < querySnapshot.size) {
          campaigns.add(GetCampaign(result.id));
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return (Container(
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
              Customappbar(userName: "", userImage: "assets/images/user.png"),
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
                      children: campaigns)),
              SizedBox(
                  height: 50,
                  child: Container(
                      //color: Colors.black
                      )),
            ],
          ))),
    ));
  }
}
