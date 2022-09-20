import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

class Trips {
  final tripId;
  final String city;
  final String go;
  final String date;
  final String uid;

  Trips({
    required this.tripId,
    required this.city,
    required this.go,
    required this.date,
    required this.uid,
  });
  Map<String, dynamic> toJson() =>
      {'tripID': tripId, 'uid': uid, 'city': city, 'date': date, 'go': go};
  static Trips readFromJson(Map<String, dynamic> json) => Trips(
        tripId: json['tripId'],
        city: json['city'],
        go: json['go'],
        date: json['date'],
        uid: json['uid'],
      );

  static Future<bool> availableTrip(String activity) async {
    final result = await FirebaseFirestore.instance
        .collection('Trips')
        .where('go', isEqualTo: activity)
        .get();
    if (result.docs.isEmpty) {
      return true;
    } else {
      return false;
    }
  }
}

Future createTrip({
  required String tripId,
  required String uid,
  required String city,
  required String go,
  required String date,
}) async {
  final trip = Trips(tripId: tripId, uid: uid, city: city, go: go, date: date);
  final tripDocument =
      FirebaseFirestore.instance.collection('Trips').doc(tripId);

  await tripDocument.set(trip.toJson());
}
