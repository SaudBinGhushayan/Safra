import 'dart:convert';

import 'package:safra/backend/supabase.dart';

List<TripsInfo> tripsInfoFromJson(String str) =>
    List<TripsInfo>.from(json.decode(str).map((x) => TripsInfo.fromJson(x)));

String tripsInfoToJson(List<TripsInfo> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TripsInfo {
  TripsInfo({
    required this.tripId,
    required this.trip_name,
    required this.country,
    required this.uid,
    required this.active,
    required this.from,
    required this.to,
  });

  String tripId;
  String trip_name;
  String uid;
  String active;
  String country;
  DateTime from;
  DateTime to;

  factory TripsInfo.fromJson(Map<String, dynamic> json) => TripsInfo(
        tripId: json["trip_id"],
        trip_name: json["trip_name"],
        country: json["country"],
        uid: json['uid'],
        active: json["active"],
        from: DateTime.parse(json["from"]),
        to: DateTime.parse(json["to"]),
      );

  Map<String, dynamic> toJson() => {
        "trip_id": tripId,
        "trip_name": trip_name,
        "country": country,
        "uid": uid,
        "active": active,
        "from":
            "${from.year.toString().padLeft(4, '0')}-${from.month.toString().padLeft(2, '0')}-${from.day.toString().padLeft(2, '0')}",
        "to":
            "${to.year.toString().padLeft(4, '0')}-${to.month.toString().padLeft(2, '0')}-${to.day.toString().padLeft(2, '0')}",
      };
  static Future<bool> userHasTrip(String uid) async {
    final response = await SupaBase_Manager()
        .client
        .from('trips_info')
        .select('participate(*)inner(trips_info(*)')
        .eq('uid', uid)
        .execute();
    if (response.data.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> validateLeader(String uid, String trip_id) async {
    final response = await SupaBase_Manager()
        .client
        .from('trips_info')
        .select()
        .eq('uid', uid)
        .eq('trip_id', trip_id)
        .execute();
    if (response.data.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  static Future<List<TripsInfo>?> readTrips_Info(String uid) async {
    final response = await SupaBase_Manager()
        .client
        .from('trips_info')
        .select()
        .eq('active', 'true')
        .eq('uid', uid)
        .execute();
    if (response.error == null) {
      var data = response.data.toString();
      data = data.replaceAll('{', '{"');
      data = data.replaceAll(': ', '": "');
      data = data.replaceAll(', ', '", "');
      data = data.replaceAll('}', '"}');
      data = data.replaceAll('}",', '},');
      data = data.replaceAll('"{', '{');
      return tripsInfoFromJson(data);
    }
  }
}
