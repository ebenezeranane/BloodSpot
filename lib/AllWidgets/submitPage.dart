// ignore_for_file: non_constant_identifier_names

import 'package:bloodspot/AllWidgets/request.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

final List<String> genderItems = [
  'Male',
  'Female',
];
String selectedValue;

final _formKey = GlobalKey<FormState>();

void SubmitPage(BuildContext ctx) {
  showModalBottomSheet(
      isScrollControlled: true,
      elevation: 5,
      context: ctx,
      builder: (ctx) => Padding(
            padding: EdgeInsets.only(
                top: 40,
                left: 15,
                right: 15,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // const TextField(
                //   keyboardType: TextInputType.name,
                //   decoration: InputDecoration(labelText: 'Name'),
                // ),
                // const TextField(
                //   keyboardType: TextInputType.number,
                //   decoration: InputDecoration(labelText: 'Age'),
                // ),
                const Padding(
                  padding: EdgeInsets.only(left: 25, bottom: 5),
                  child: Text(
                    "Confirmation",
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: Column(
                      children: [
                        //Full Name text
                        Container(
                          padding: const EdgeInsets.only(left: 10.0, top: 50.0),
                          height: 30,
                          width: double.infinity,
                          child: const Text(
                            "Full Name",
                          ),
                        ),
                        TextFormField(
                          readOnly: true,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 20,
                            ),
                            hintText: 'Enter Your Full Name.',
                            hintStyle: const TextStyle(fontSize: 14),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 10.0, top: 10.0),
                          height: 30,
                          width: double.infinity,
                          child: const Text(
                            "Gender",
                          ),
                        ),
                        TextFormField(
                          readOnly: true,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 20,
                            ),
                            hintText: 'Enter Your Full Name.',
                            hintStyle: const TextStyle(fontSize: 14),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                        Container(
                            padding:
                                const EdgeInsets.only(left: 10.0, top: 10.0),
                            height: 30,
                            width: double.infinity,
                            child: const Text(
                              "Blood Group",
                            )),
                        DropdownButtonFormField2(
                          decoration: InputDecoration(
                            //Add isDense true and zero Padding.
                            //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                            isDense: true,
                            contentPadding: EdgeInsets.zero,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            //Add more decoration as you want here
                            //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                          ),
                          isExpanded: true,
                          hint: const Text(
                            'Select Your Blood Group',
                            style: TextStyle(fontSize: 14),
                          ),
                          icon: const Icon(
                            Icons.arrow_drop_down,
                            color: Colors.black45,
                          ),
                          iconSize: 30,
                          buttonHeight: 60,
                          buttonPadding:
                              const EdgeInsets.only(left: 20, right: 10),
                          dropdownDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          items: genderItems
                              .map((item) => DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: const TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ))
                              .toList(),
                          validator: (value) {
                            if (value == null) {
                              return 'Please select gender.';
                            }
                          },
                          onChanged: (value) {
                            //Do something when changing the item if you want.
                          },
                          onSaved: (value) {
                            selectedValue = value.toString();
                          },
                        ),
                        Container(
                            padding:
                                const EdgeInsets.only(left: 10.0, top: 10.0),
                            height: 30,
                            width: double.infinity,
                            child: const Text(
                              "Height",
                            )),
                        TextFormField(
                          readOnly: true,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 20,
                            ),
                            hintText: 'Enter Your Height',
                            hintStyle: const TextStyle(fontSize: 14),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                        Container(
                            padding:
                                const EdgeInsets.only(left: 10.0, top: 10.0),
                            height: 30,
                            width: double.infinity,
                            child: const Text(
                              "Weight",
                            )),
                        TextFormField(
                          readOnly: true,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 20,
                            ),
                            hintText: 'Enter Your Weight',
                            hintStyle: const TextStyle(fontSize: 14),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),

                        Center(
                            child: ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState.validate()) {
                                    _formKey.currentState.save();

                                    RequestSucess(ctx);
                                  }
                                },
                                child: const Text('Submit')))
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ));
}
