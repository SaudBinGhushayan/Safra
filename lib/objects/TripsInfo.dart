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
    required this.uid,
    required this.active,
    required this.from,
    required this.to,
  });

  String tripId;
  String trip_name;
  String uid;
  String active;
  DateTime from;
  DateTime to;

  factory TripsInfo.fromJson(Map<String, dynamic> json) => TripsInfo(
        tripId: json["trip_id"],
        trip_name: json["trip_name"],
        uid: json['uid'],
        active: json["active"],
        from: DateTime.parse(json["from"]),
        to: DateTime.parse(json["to"]),
      );

  Map<String, dynamic> toJson() => {
        "trip_id": tripId,
        "trip_name": trip_name,
        "uids": uid,
        "active": active,
        "from":
            "${from.year.toString().padLeft(4, '0')}-${from.month.toString().padLeft(2, '0')}-${from.day.toString().padLeft(2, '0')}",
        "to":
            "${to.year.toString().padLeft(4, '0')}-${to.month.toString().padLeft(2, '0')}-${to.day.toString().padLeft(2, '0')}",
      };
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

  static Future<List<TripsInfo>?> displayNearestTrip(String uid) async {
    final response = await SupaBase_Manager()
        .client
        .from('trips_info')
        .select()
        .eq('active', 'true')
        .eq('uid', uid)
        .filter('to', 'gt', DateTime.now())
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

  static Future<List<TripsInfo>?> addMember(String uid) async {
    final response = await SupaBase_Manager()
        .client
        .from('trips_info')
        .select()
        .eq('active', 'true')
        .eq('uid', uid)
        .filter('to', 'gt', DateTime.now())
        .execute();
    if (response.error == null) {
      var data = response.data.toString();
      data = data.replaceAll('{', '{"');
      data = data.replaceAll(': ', '": "');
      data = data.replaceAll(', ', '", "');
      data = data.replaceAll('}', '"}');
      data = data.replaceAll('}",', '},');
      data = data.replaceAll('"{', '{');
      data = data.replaceAll(']"', ']');
      data = data.replaceAll(' "[', ' ["');
      data = data.replaceAll(']}]', '"]}]');

      return tripsInfoFromJson(data);
    }
  }
}
