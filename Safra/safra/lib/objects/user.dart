import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:math';

class Users {
  String uid;
  final String name;
  final String phoneNumber;
  final String email;
  final String username;

  // String doc = "user's_Doc${Random().nextInt(100)}";
  Users(
      {required this.uid,
      required this.name,
      required this.phoneNumber,
      required this.email,
      required this.username});
  Map<String, dynamic> toJson() => {
        'uid': uid,
        'name': name,
        'phoneNumber': phoneNumber,
        'email': email,
        'username': username
      };

  String get getUsername {
    return username;
  }

  static Users readFromJson(Map<String, dynamic> json) => Users(
      uid: json['uid'],
      name: json['name'],
      phoneNumber: json['phoneNumber'],
      email: json['email'],
      username: json['username']);
}

Future createUser(
    {required String uid,
    required String name,
    required String phoneNumber,
    required String email,
    required String username}) async {
  final user = Users(
      uid: uid,
      name: name,
      phoneNumber: phoneNumber,
      email: email,
      username: username);
  final userDocument = FirebaseFirestore.instance.collection('Users').doc(uid);

  await userDocument.set(user.toJson());
}
