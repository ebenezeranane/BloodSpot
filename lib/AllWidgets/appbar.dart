import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Customappbar extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String userName;
  final String userImage;
  Customappbar({Key key, this.userName, this.userImage}) : super(key: key);

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
            //profile logo
            Stack(
              children: [
                Container(
                  height: 60,
                  // padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(15),
                    ),
                    border: Border.all(
                      width: 1,
                      color: Colors.white,
                      style: BorderStyle.solid,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(15),
                      topLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                    ),
                    child:
                        //Image.network(userImage.toString(), fit: BoxFit.cover),
                        Image.asset('assets/images/1.jpg'),
                  ),
                ),
                Positioned(
                  left: 0,
                  bottom: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        width: 1,
                        color: Colors.white,
                        style: BorderStyle.solid,
                      ),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.green,
                        // borderRadius: BorderRadius.all(
                        //   Radius.circular(10),
                        // ),
                        border: Border.all(
                          width: 3,
                          color: Colors.green,
                          style: BorderStyle.solid,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ]), // Row),,
          const Padding(
            padding: EdgeInsets.only(top: 5),
          ),
        ]));
  }
}
