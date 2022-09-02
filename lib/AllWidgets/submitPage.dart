// ignore_for_file: missing_return

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

String selectedValue;
FirebaseAuth _auth = FirebaseAuth.instance;
CollectionReference blood = FirebaseFirestore.instance.collection('available_blood_types');


final List<String> genderItems = [
  'Male',
  'Female',
];

final _formKey = GlobalKey<FormState>();

void SubmitPage(BuildContext ctx) {
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
              
              
                return Container(
                      height: 420,
                      child: ListView.builder(
                          itemCount: data['available_blood_types'].length,
                          itemBuilder: (BuildContext context, index) {
                            return Card(
                              child: ListTile(
                                title: Text(data['available_blood_types'][index]),
                                leading: const Icon(
                                  
                                  Icons.bloodtype_rounded,
                                  color: Colors.red,),
                                  trailing:   Container(
                                                    decoration: BoxDecoration(
                                                      color: Color.fromARGB(19, 39, 231, 65),
                                                      borderRadius: const BorderRadius.all(
                                                          Radius.circular(5)),
                                                      border: Border.all(color: Colors.green),
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
                                                        'AVAILABLE',
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            color: Colors.green),
                                                      ),
                                                    ),
                                                  ),

                              ),
                            );
                          }),
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
          }));}