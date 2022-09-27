// ignore_for_file: missing_return

import 'package:bloodspot/AllWidgets/progressDialog.dart';
import 'package:bloodspot/AllWidgets/request.dart';
import 'package:bloodspot/pages/auth/admin_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../DataHandler/appData.dart';

String selectedValue;
bool isAdmin = false;
FirebaseAuth _auth = FirebaseAuth.instance;
CollectionReference blood =
    FirebaseFirestore.instance.collection('available_blood_types');

void SubmitPage(
  BuildContext ctx,
) {
  showModalBottomSheet(
      isScrollControlled: true,
      elevation: 5,
      context: ctx,
      builder: (ctx) => FutureBuilder<DocumentSnapshot>(
          future: blood.doc('r68ushRnslSnFcHXVmBK').get(),
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

              // List of available blood types

              for (int indice = 0; indice < data['bloods'].length; indice++) {
                if (Provider.of<AppData>(context).dropOffLocation != null &&
                    Provider.of<AppData>(context).dropOffLocation.placeName ==
                        data['bloods'][indice]['hospital_name']) {
                  
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 420,
                            child: ListView.builder(
                                itemCount:

                                data['bloods'][indice]
                                        ['available_blood_types']['available_blood']
                                    .length,

                                itemBuilder: (BuildContext context, index) {
                                  return Card(
                                    child: ListTile(
                                      title: Text(data['bloods'][indice]
                                              ['available_blood_types']
                                          ['available_blood'][index]['type']),

                                      leading: const Icon(
                                        Icons.bloodtype_rounded,
                                        color: Colors.red,
                                      ),

                                      trailing: data['bloods'][indice]
                                                      ['available_blood_types']
                                                  ['available_blood'][index]['status']==true
                                          ? Container(
                                              decoration: BoxDecoration(
                                                color: Color.fromARGB(
                                                    19, 39, 231, 65),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(5)),
                                                border: Border.all(
                                                    color: Colors.green),
                                              ),
                                              //padding: EdgeInsets.only(right: 10.0),
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  .05,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .35,
                                              child: const Center(
                                                child: Text(
                                                  'AVAILABLE',
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.green),
                                                ),
                                              ),
                                            )
                                          : Container(
                                              decoration: BoxDecoration(
                                                color: Color.fromARGB(
                                                    19, 39, 231, 65),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(5)),
                                                border: Border.all(
                                                    color: Colors.red),
                                              ),
                                              //padding: EdgeInsets.only(right: 10.0),
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  .05,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .35,
                                              child: const Center(
                                                child: Text(
                                                  'UNAVAILABLE',
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.red),
                                                ),
                                              ),
                                            ),
                                    ),
                                  );
                                }),
                          ),
                          // checkAdmin() == true
                          //     ? Center(
                          //         child: ElevatedButton(
                          //             onPressed: () {
                          //               RequestSucess(ctx);
                          //             },
                          //             child: Text('SUMBIT')),
                          //       )
                          //     : Center()
                        ],
                      );
                    }
                  }
                  // } else {
                  //   return Column(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: [
                  //       Container(
                  //         child: const Center(
                  //           child:
                  //               Text("BLOOD UNAVAILABLE FOR THIS HOSPITAL"),
                  //         ),
                  //       ),
                  //       checkAdmin() == true
                  //           ? Center(
                  //               child: ElevatedButton(
                  //                   onPressed: () {
                  //                     RequestSucess(ctx);
                  //                   },
                  //                   child: Text('SUMBIT')),
                  //             )
                  //           : Center()
                  //     ],
                  //   );
                  // }
                }
            
            return const Center(
              child: SizedBox(
                height: 40,
                child: CircularProgressIndicator(
                  color: Colors.deepPurple,
                ),
              ),
            );
          }));
}

// Check if user is admin
checkAdmin() {
  FirebaseFirestore.instance.collection("admins").get().then((querySnapshot) {
    for (var result in querySnapshot.docs) {
      if (_auth.currentUser.email == result['email']) {
        print("true");
        isAdmin = true;
      }
    }
  });
  return isAdmin;
}
