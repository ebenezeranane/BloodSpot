// ignore_for_file: missing_return

import 'package:bloodspot/AllWidgets/progressDialog.dart';
import 'package:bloodspot/AllWidgets/request.dart';
import 'package:bloodspot/pages/auth/admin_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../DataHandler/appData.dart';

String selectedValue;
bool isAdmin = false;
FirebaseAuth _auth = FirebaseAuth.instance;
String email = _auth.currentUser.email;
    int indexOfAt = email.indexOf('@');
    String getUserFromEmail = email.substring(0, indexOfAt);
   var userName = getUserFromEmail;



void SubmitPage(
  BuildContext ctx,
) {
  showModalBottomSheet(
      isScrollControlled: true,
      elevation: 5,
      context: ctx,
      builder: (ctx) => StreamBuilder(
        stream: FirebaseFirestore.instance
                  .collection('hospitals')
                  .doc('veizUiJPlvLIkuA81i8X')
                  .snapshots(),
        builder: (context,DataSnapshot) {
          if (!DataSnapshot.hasData) {
          return new CircularProgressIndicator();
        }
          return StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('hospitals')
                  .doc('veizUiJPlvLIkuA81i8X')
                  .collection('blood_types')
                  .snapshots(),
              builder: (context, dataSnapshot) {
                // check for chosen hospital on map
                   DocumentSnapshot data =DataSnapshot.data;
                if (Provider.of<AppData>(context).dropOffLocation != null &&
                    Provider.of<AppData>(context).dropOffLocation.placeName ==
                        data['hospital_name']) {
                  return dataSnapshot.hasData
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                              Container(
                                height: 500,
                                child: ListView.builder(
                                    itemCount: dataSnapshot.data.docs.length,
                                    itemBuilder: (BuildContext context, index) {
                                      DocumentSnapshot data =
                                          dataSnapshot.data.docs[index];
                                      return Card(
                                        child: ListTile(
                                          title: Text(
                                              data['blood_types_status']['type']),
                                          leading: const Icon(
                                            Icons.bloodtype_rounded,
                                            color: Colors.red,
                                          ),
                                          onTap: () => {


                                           // check if blood is available and send request
                                            if(data['blood_types_status']['status']=="available"&&checkAdmin()==true){
                                               
                                               FirebaseFirestore.instance.collection('blood_requests').add(
                                                {
                                                  "blood_type":data['blood_types_status']['type'],
                                                  "hospital_name":userName,
                                                  "status":"pending"

                                                }
                                               ),
                                               RequestSucess(ctx)
                                            }

                                            
                                           
                                          },
                                          trailing: data['blood_types_status']
                                                      ['status'] ==
                                                  "available"
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
                            //   checkAdmin() == true
                            //       ? Center(
                            //           child: ElevatedButton(
                            //               onPressed: () {
                            //                 RequestSucess(ctx);
                            //               },
                            //               child: Text('SUMBIT')),
                            //         )
                            //       : Center()
                            ]
                          )
                      : const Center(
                          child: SizedBox(
                            height: 40,
                            child: CircularProgressIndicator(
                              color: Colors.deepPurple,
                            ),
                          ),
                        );
                }else{
                  return const Center(
                          child: SizedBox(
                            height: 40,
                            child: CircularProgressIndicator(
                              color: Colors.deepPurple,
                            ),
                          ),
                        );
                }
              });
        }
      ));
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

