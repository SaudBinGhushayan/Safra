// To parse this JSON data, do
//
//     final trips = tripsFromJson(jsonString);

import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

List<Trips> tripsFromJson(String str) =>
    List<Trips>.from(json.decode(str).map((x) => Trips.fromJson(x)));

String tripsToJson(List<Trips> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Trips {
  Trips({
    required this.uid,
    required this.fsq_id,
    required this.name,
    required this.rating,
    required this.tel,
    required this.country,
    required this.region,
    required this.price,
    required this.description,
    required this.active,
  });

  String uid;
  List<String> fsq_id;
  List<String> name;
  List<String> rating;
  List<String> tel;
  List<String> country;
  List<String> region;
  List<String> price;
  List<String> description;
  bool active;

  static Trips fromJson(Map<String, dynamic> json) => Trips(
        uid: json["uid"],
        fsq_id: List<String>.from(json["fsq_id"].map((x) => x)),
        name: List<String>.from(json["name"].map((x) => x)),
        rating: List<String>.from(json["rating"].map((x) => x)),
        tel: List<String>.from(json["tel"].map((x) => x)),
        country: List<String>.from(json["country"].map((x) => x)),
        region: List<String>.from(json["region"].map((x) => x)),
        price: List<String>.from(json["price"].map((x) => x)),
        description: List<String>.from(json["description"].map((x) => x)),
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "fsq_id": List<dynamic>.from(fsq_id.map((x) => x)),
        "name": List<dynamic>.from(name.map((x) => x)),
        "rating": List<dynamic>.from(rating.map((x) => x)),
        "tel": List<dynamic>.from(tel.map((x) => x)),
        "country": List<dynamic>.from(country.map((x) => x)),
        "region": List<dynamic>.from(region.map((x) => x)),
        "price": List<dynamic>.from(price.map((x) => x)),
        "description": List<dynamic>.from(description.map((x) => x)),
        "active": active,
      };
  static Future<bool> availableActivity(String name) async {
    final result = await FirebaseFirestore.instance
        .collection('Trips')
        .where('name', isEqualTo: name)
        .get();
    if (result.docs.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> availableTrip(String uid) async {
    final docUser = FirebaseFirestore.instance.collection('Trips').doc(uid);
    final snapshot = await docUser.get();

    if (snapshot.exists) {
      return true;
    } else {
      return false;
    }
  }
}

Future createTrip(
    {required String uid,
    required List<String> fsq_id,
    required List<String> name,
    required List<String> rating,
    required List<String> tel,
    required List<String> country,
    required List<String> region,
    required List<String> price,
    required List<String> description,
    required bool active}) async {
  final trips = Trips(
      uid: uid,
      fsq_id: fsq_id,
      name: name,
      rating: rating,
      tel: tel,
      country: country,
      region: region,
      price: price,
      description: description,
      active: active);
  final tripDocument = FirebaseFirestore.instance.collection('Trips').doc(uid);

  await tripDocument.set(trips.toJson());
}

Future appendTrip(
    {required String uid,
    required List<String> fsq_id,
    required List<String> name,
    required List<String> rating,
    required List<String> tel,
    required List<String> country,
    required List<String> region,
    required List<String> price,
    required List<String> description,
    required bool active}) async {
  final trips = Trips(
      uid: uid,
      fsq_id: fsq_id,
      name: name,
      rating: rating,
      tel: tel,
      country: country,
      region: region,
      price: price,
      description: description,
      active: active);
  List<dynamic> e_name = [];
  FirebaseFirestore.instance
      .collection('Trips')
      .doc(uid)
      .get()
      .then((value) => e_name = value.get('name'));
  e_name.add(name);

  final tripDocument = FirebaseFirestore.instance.collection('Trips').doc(uid);

  await tripDocument.set({'name': e_name});

  // await tripDocument.update({
  //   'fsq_id': FieldValue.arrayUnion(fsq_id.toList()),
  //   'name': FieldValue.arrayUnion(name.toList()),
  //   'rating': FieldValue.arrayUnion(rating.toList()),
  //   'tel': FieldValue.arrayUnion(tel.toList()),
  //   'country': FieldValue.arrayUnion(country.toList()),
  //   'region': FieldValue.arrayUnion(region.toList()),
  //   'price': FieldValue.arrayUnion(price.toList()),
  //   'description': FieldValue.arrayUnion(description.toList()),
  // }
  // );
}
