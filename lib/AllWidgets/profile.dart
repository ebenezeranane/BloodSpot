import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyWidget extends StatelessWidget {
  final String name;
  final String email;
  final String image;
  final int phoneNumber;
  final String weight;
  final String height;
  final String blood;
  final String gender;

  const MyWidget({
    Key key,
    this.name,
    this.email,
    this.image,
    this.phoneNumber,
    this.weight,
    this.height,
    this.blood,
    this.gender,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String userName;

    FirebaseAuth _auth = FirebaseAuth.instance;
    CollectionReference user = FirebaseFirestore.instance.collection('users');

    // get user  from email
    String email = _auth.currentUser.email;
    int indexOfAt = email.indexOf('@');
    String getUserFromEmail = email.substring(0, indexOfAt);
    userName = getUserFromEmail;

    return FutureBuilder<DocumentSnapshot>(
      future: user.doc('1CBqVwLthtGSpkniVfxv').get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data.exists) {
          return const Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data.data() as Map<String, dynamic>;
          return Column(
            children: <Widget>[
              Expanded(
                flex: 3, // 20%
                child: Column(
                  children: [
                    Expanded(
                      flex: 8,
                      child: Container(
                        decoration: BoxDecoration(
                          // color: Colors.white,
                          border: Border.all(color: Colors.white, width: 2),
                          shape: BoxShape.circle,
                          boxShadow: const [
                            BoxShadow(
                                blurRadius: 5,
                                color: Color.fromARGB(255, 205, 205, 205),
                                spreadRadius: 4)
                          ],
                        ),
                        margin: const EdgeInsets.only(top: 20),
                        //color: Colors.indigo,
                        child: const Center(
                            child: SizedBox(
                          height: 115,
                          width: 115,
                          child: CircleAvatar(
                            backgroundImage: AssetImage("assets/images/1.jpg"),
                          ),
                        )),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Center(
                        child: Text(userName,
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.02,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 10, // 60%
                child: Container(
                    margin: const EdgeInsets.only(top: 15),
                    //color: Colors.purple,
                    child: Column(
                      children: [
                        //GENDER AND BLOOD GROUP
                        Expanded(
                          flex: 1,
                          child: Container(
                            decoration: BoxDecoration(
                              //color: Colors.yellow,
                              border: Border(
                                top: BorderSide(
                                    width: 1.0, color: Colors.grey.shade300),
                              ),
                            ),

                            //Gender and Bloodgroup
                            child: Row(
                              children: [
                                //Gender
                                Expanded(
                                  child: Container(
                                    margin: const EdgeInsets.all(10),
                                    child: Row(
                                      children: [
                                        //Icon
                                        Expanded(
                                          flex: 3,
                                          child: Container(
                                            //color: Colors.tealAccent,
                                            padding: const EdgeInsets.all(10),
                                            child: const Center(
                                              child: Icon(
                                                Icons.male_rounded,
                                                size: 40,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ),
                                        ),
                                        //Gender Text
                                        Expanded(
                                          flex: 7,
                                          child: Container(
                                            //color: Colors.pink,
                                            padding: const EdgeInsets.only(
                                                right: 10),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Text("Gender"),
                                                Text(data['gender']),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                VerticalDivider(
                                    thickness: 3, color: Colors.grey.shade300),
                                //Bloddgroup
                                Expanded(
                                  child: Container(
                                    //color: Colors.blue,
                                    margin: const EdgeInsets.all(10),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 3,
                                          child: Container(
                                            //color: Colors.tealAccent,
                                            padding: const EdgeInsets.all(10),
                                            child: const Center(
                                              child: Icon(
                                                Icons.male_rounded,
                                                size: 40,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 7,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text("Blood Group"),
                                              Text(data['blood_group'])
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        //DATE OF BIRTH
                        Expanded(
                          flex: 1,
                          child: Container(
                            decoration: BoxDecoration(
                              //color: Colors.orange,
                              border: Border(
                                top: BorderSide(
                                    width: 1.0, color: Colors.grey.shade300),
                              ),
                            ),
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    //color: Colors.tealAccent,
                                    padding: const EdgeInsets.all(10),
                                    child: const Center(
                                      child: Icon(
                                        Icons.calendar_today,
                                        size: 30,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 12,
                                  child: Container(
                                    //color: Colors.pink,
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text("Date of Birth"),
                                        Text(data['birth_date']),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        //EMAIL
                        Expanded(
                          flex: 1,
                          child: Container(
                            decoration: BoxDecoration(
                              //color: Colors.amber,
                              border: Border(
                                top: BorderSide(
                                    width: 1.0, color: Colors.grey.shade300),
                              ),
                            ),
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    //color: Colors.tealAccent,
                                    padding: const EdgeInsets.all(10),
                                    child: const Center(
                                      child: Icon(
                                        Icons.call_rounded,
                                        size: 30,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 12,
                                  child: Container(
                                    //color: Colors.pink,
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text("Phone Number"),
                                        Text(data['phone'].toString()),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        //CALL NUMBER
                        Expanded(
                          flex: 1,
                          child: Container(
                            decoration: BoxDecoration(
                              //color: Colors.amber,
                              border: Border(
                                top: BorderSide(
                                    width: 1.0, color: Colors.grey.shade300),
                              ),
                            ),
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    //color: Colors.tealAccent,
                                    padding: const EdgeInsets.all(10),
                                    child: const Center(
                                      child: Icon(
                                        Icons.mail_outline_rounded,
                                        size: 30,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 9,
                                  child: Container(
                                    //color: Colors.pink,
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text("Email"),
                                        Text(_auth.currentUser.email)
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 4,
                                  child: Container(
                                    //color: Colors.tealAccent,
                                    padding: const EdgeInsets.all(10),
                                    child: InkWell(
                                      onTap: () {},
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              20, 231, 39, 39),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(5)),
                                          border: Border.all(color: Colors.red),
                                        ),
                                        //padding: EdgeInsets.only(right: 10.0),
                                        height:
                                            MediaQuery.of(context).size.height *
                                                .05,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .25,
                                        child: const Center(
                                          child: Text(
                                            'CHANGE',
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.red),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        //HEIGHT
                        Expanded(
                          flex: 1,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              border: Border(
                                top: BorderSide(
                                    width: 1.0, color: Colors.grey.shade300),
                              ),
                            ),
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    //color: Colors.tealAccent,
                                    padding: const EdgeInsets.all(10),
                                    child: const Center(
                                        child: Icon(Icons.rule_rounded)),
                                  ),
                                ),
                                Expanded(
                                  flex: 8,
                                  child: Container(
                                    //color: Colors.pink,
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: const [
                                        Text("Height"),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 4,
                                  child: Container(
                                    //color: Colors.tealAccent,
                                    padding: const EdgeInsets.all(10),
                                    child: Center(
                                      child: Text(
                                        data['height'],
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        //WEIGHT
                        Expanded(
                          flex: 1,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              border: Border(
                                top: BorderSide(
                                    width: 1.0, color: Colors.grey.shade300),
                                bottom: BorderSide(
                                    width: 1.0, color: Colors.grey.shade300),
                              ),
                            ),
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    //color: Colors.tealAccent,
                                    padding: const EdgeInsets.all(10),
                                    child: const Center(
                                      child:
                                          Icon(Icons.monitor_weight_outlined),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 8,
                                  child: Container(
                                    //color: Colors.pink,
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: const [
                                        Text("Weight"),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 4,
                                  child: Container(
                                    //color: Colors.tealAccent,
                                    padding: const EdgeInsets.all(5),
                                    child: Center(
                                      child: Text(
                                        data['weight'],
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
              Expanded(
                flex: 1,
                child: Container(),
              )
            ],
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
