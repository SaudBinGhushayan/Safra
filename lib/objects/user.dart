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

  static Future<bool> availableUsername(String username) async {
    final result = await FirebaseFirestore.instance
        .collection('Users')
        .where('username', isEqualTo: username)
        .get();
    if (result.docs.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  static Future<Users?> readUser(String id) async {
    final docUser = FirebaseFirestore.instance.collection('Users').doc(id);
    final snapshot = await docUser.get();

    if (snapshot.exists) {
      return Users.readFromJson(snapshot.data()!);
    }
  }
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
