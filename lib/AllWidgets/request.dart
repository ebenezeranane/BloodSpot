// ignore_for_file: deprecated_member_use, non_constant_identifier_names

import 'package:flutter/material.dart';

void RequestSucess(BuildContext ctx) {
  showModalBottomSheet(
      isScrollControlled: true,
      elevation: 5,
      context: ctx,
      builder: (ctx) => Padding(
            padding: EdgeInsets.only(
                top: 40,
                left: 15,
                right: 15,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircleAvatar(
                  backgroundColor: Color.fromARGB(255, 28, 176, 33),
                  child: Icon(Icons.check),
                ),
                const SizedBox(height: 20),
                const Text("REQUEST SENT",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
                const SizedBox(height: 20),
                const Text("Your request has been sent to the nearest hospital",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
                const SizedBox(height: 20),
                RaisedButton(
                  color: Color.fromARGB(255, 28, 176, 33),
                  child: const Text("OK",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                  onPressed: () {
                    var nav = Navigator.of(ctx);
                    nav.pop();
                    nav.pop();
                    // Navigator.pop(ctx);
                  },
                ),
              ],
            ),
          ));
}

void RequestFailed(BuildContext ctx) {
  showModalBottomSheet(
      isScrollControlled: true,
      elevation: 5,
      context: ctx,
      builder: (ctx) => Padding(
            padding: EdgeInsets.only(
                top: 40,
                left: 15,
                right: 15,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircleAvatar(
                  backgroundColor: Colors.red,
                  child: Icon(Icons.close),
                ),
                const SizedBox(height: 20),
                const Text("REQUEST FAILED",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
                const SizedBox(height: 20),
                const Text("Your request has failed. Please try again later",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
                const SizedBox(height: 20),
                RaisedButton(
                  color: Colors.red,
                  child: const Text("OK",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                  onPressed: () {
                    var nav = Navigator.of(ctx);
                    nav.pop();
                    nav.pop();
                  },
                ),
              ],
            ),
          ));
}
