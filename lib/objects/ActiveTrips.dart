import 'dart:isolate';

import 'package:cloud_firestore/cloud_firestore.dart';

class activeTrips {
  final String uid;
  final String city;

  activeTrips({required this.uid, required this.city});

  static activeTrips readFromJson(Map<String, dynamic> json) =>
      activeTrips(uid: json['uid'], city: json['city']);
  Map<String, dynamic> toJson() => {'uid': uid, 'city': city};
}

Future createActiveTrip({required String uid, required String city}) async {
  final activeTrip = activeTrips(uid: uid, city: city);
  final tripDocument =
      FirebaseFirestore.instance.collection('ActiveTrips').doc(uid);

  await tripDocument.set(activeTrip.toJson());
}
