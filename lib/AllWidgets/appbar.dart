import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String userName;
  final String userImage;
  CustomAppbar({Key key, this.userName, this.userImage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // get user  from email
    String email = _auth.currentUser.email;
    int indexOfAt = email.indexOf('@');
    String getUserFromEmail = email.substring(0, indexOfAt);
    userName = getUserFromEmail;

    return Padding(
        padding: const EdgeInsets.all(15),
        child: Column(children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Welcome",
                    style: TextStyle(fontSize: 25, color: Colors.white)),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  "Hello $userName",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
            
          ]), // Row),,
          const Padding(
            padding: EdgeInsets.only(top: 5),
          ),
        ]));
  }
}
