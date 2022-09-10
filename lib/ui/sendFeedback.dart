import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:safra/backend/snackBar.dart';
import 'package:safra/backend/storage.dart';
import 'package:safra/objects/user.dart';
import 'package:safra/ui/stngs.dart';

class sendFeedback extends StatefulWidget {
  const sendFeedback({Key? key}) : super(key: key);

  @override
  State<sendFeedback> createState() => _sendFeedbackState();
}

class _sendFeedbackState extends State<sendFeedback> {
  final feedback = TextEditingController();
  final user = FirebaseAuth.instance.currentUser!;
  final FirebaseStorage storage = FirebaseStorage.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: FutureBuilder<Users?>(
            future: Users.readUser(user.uid),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final users = snapshot.data!;
                return Scaffold(
                    resizeToAvoidBottomInset: false,
                    body: Container(
                        //////1st column
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                          image: AssetImage(
                              'images/BackgroundPics/AltBackground.jpg'),
                          fit: BoxFit.fill,
                        )),
                        child: Column(children: [
                          const SizedBox(height: 50),
                          Container(
                              alignment: Alignment.topLeft,
                              child: IconButton(
                                  icon: const Icon(Icons.arrow_back_ios),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const stngs()));
                                  })),
                          const SizedBox(height: 100),
                          const SizedBox(height: 10),
                          Container(
                              alignment: Alignment.topCenter,
                              child: const Text('Send Us a Feedback',
                                  style: TextStyle(
                                      fontSize: 33,
                                      color: Color.fromARGB(255, 75, 74, 74)))),
                          const SizedBox(height: 30),
                          Container(
                              alignment: Alignment.topLeft,
                              margin: const EdgeInsets.only(left: 20),
                              child: const Text(
                                  '''Do you have any suggestions or bugs to report?

please type what you please in the below text field''',
                                  style: TextStyle(
                                      color: Colors.blueGrey, fontSize: 17))),
                          const SizedBox(height: 20),
                          TextField(
                            controller: feedback,
                            textAlign: TextAlign.left,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                  borderSide:
                                      const BorderSide(color: Colors.blue)),
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 60),
                              filled: true,
                              fillColor: Colors.white,
                              hintText: "   Please type what concerns you",
                              hintStyle: const TextStyle(
                                color: Colors.grey,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          const SizedBox(height: 60),
                          ElevatedButton(
                              onPressed: () async {
                                Random rnd = new Random();
                                if (feedback.text.isNotEmpty) {
                                  final userDocument = FirebaseFirestore
                                      .instance
                                      .collection('Feedbacks')
                                      .doc(users.username +
                                          rnd.nextInt(100).toString());

                                  await userDocument
                                      .set({'feedback': feedback.text});

                                  snackBar.showSnackBarGreen(
                                      "Thanks for your feedback we'll look at it as soon as possible");
                                } else {
                                  snackBar.showSnackBarRed('Invalid Input');
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  primary:
                                      const Color.fromARGB(255, 2, 95, 172),
                                  textStyle: const TextStyle(fontSize: 20),
                                  padding: const EdgeInsets.fromLTRB(
                                      120, 10, 120, 10)),
                              child: const Text("Send Feedback")),
                        ])));
              } else {
                return Center(
                    child: SpinKitCircle(
                  size: 140,
                  itemBuilder: (context, index) {
                    final colors = [Colors.blue, Colors.cyan];
                    final color = colors[index % colors.length];
                    return DecoratedBox(
                        decoration: BoxDecoration(color: color));
                  },
                ));
              }
            }));
  }
}
