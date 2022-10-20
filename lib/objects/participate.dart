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
      {required this.tripId,
      required this.participate_id,
      required this.uid,
      required this.active,
      required this.username});

  String tripId;
  String participate_id;
  String uid;
  String active;
  String username;

  factory Participate.fromJson(Map<String, dynamic> json) => Participate(
        tripId: json["trip_id"],
        username: json["username"],
        active: json["active"],
        participate_id: json["participate_id"],
        uid: json["uid"],
      );

  Map<String, dynamic> toJson() => {
        "trip_id": tripId,
        "username": username,
        "active": active,
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

  static Future<bool> inMember(String tripId, String username) async {
    final docPar = await SupaBase_Manager()
        .client
        .from('participate')
        .select()
        .eq('trip_id', tripId)
        .eq('username', username)
        .execute();
    if (docPar.data.isNotEmpty) {
      return true;
    } else {
      return false;
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

  static Future<List<Participate>?> readParticipants(String trip_id) async {
    final response = await SupaBase_Manager()
        .client
        .from('participate')
        .select()
        .eq('trip_id', trip_id)
        .execute();
    if (response.error == null) {
      var data = response.data.toString();
      data = data.replaceAll('{', '{"');
      data = data.replaceAll(': ', '": "');
      data = data.replaceAll(', ', '", "');
      data = data.replaceAll('}', '"}');
      data = data.replaceAll('}",', '},');
      data = data.replaceAll('"{', '{');
      return participateFromJson(data);
    }
  }
}

Future addMember(
    {required String uid,
    required String participate_id,
    required String trip_id,
    required String active,
    required String username}) async {
  final participate = Participate(
      uid: uid,
      tripId: trip_id,
      active: active,
      participate_id: participate_id,
      username: username);

  await SupaBase_Manager()
      .client
      .from('participate')
      .insert([participate.toJson()]).execute();
}
