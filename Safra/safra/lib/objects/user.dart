import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:math';

class Users {
  int uid;
  final String name;
  final String phoneNumber;
  final String email;

  String doc = "user's_Doc${Random().nextInt(100)}";
  Users(
      {required this.uid,
      required this.name,
      required this.phoneNumber,
      required this.email});
  Map<String, dynamic> toJson() =>
      {'uid': uid, 'name': name, 'phoneNumber': phoneNumber, 'email': email};

  String get getDoc {
    return doc;
  }

  static Users readFromJson(Map<String, dynamic> json) => Users(
      uid: json['uid'],
      name: json['name'],
      phoneNumber: json['phoneNumber'],
      email: json['email']);
}

Future createUser(
    {required int uid,
    required String name,
    required String phoneNumber,
    required String email}) async {
  final user =
      Users(uid: uid, name: name, phoneNumber: phoneNumber, email: email);
  final userDocument =
      FirebaseFirestore.instance.collection('Users').doc(user.getDoc);

  await userDocument.set(user.toJson());
}
