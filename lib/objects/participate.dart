// To parse this JSON data, do
//
//     final participate = participateFromJson(jsonString);

import 'dart:convert';

import 'package:safra/backend/supabase.dart';

List<Participate> participateFromJson(String str) => List<Participate>.from(
    json.decode(str).map((x) => Participate.fromJson(x)));

String participateToJson(List<Participate> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Participate {
  Participate(
      {required this.tripId, required this.participate_id, required this.uid});

  String tripId;
  String participate_id;
  String uid;

  factory Participate.fromJson(Map<String, dynamic> json) => Participate(
        tripId: json["trip_id"],
        participate_id: json["participate_id"],
        uid: json["uid"],
      );

  Map<String, dynamic> toJson() => {
        "trip_id": tripId,
        "participate_id": participate_id,
        "uid": uid,
      };
  static Future<bool> validTripId(String tripId) async {
    final docPar = await SupaBase_Manager()
        .client
        .from('participate')
        .select()
        .eq('trip_id', tripId)
        .execute();
    if (docPar.data.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  static Future<bool> validUserForTrip(String uid, String trip_id) async {
    final docTrip = await SupaBase_Manager()
        .client
        .from('participate')
        .select()
        .eq('uid', uid)
        .eq('trip_id', trip_id)
        .execute();
    if (docTrip.data.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }
}

Future addMember(
    {required String uid,
    required String participate_id,
    required String trip_id}) async {
  final participate =
      Participate(uid: uid, tripId: trip_id, participate_id: participate_id);

  await SupaBase_Manager()
      .client
      .from('participate')
      .insert([participate.toJson()]).execute();
}
