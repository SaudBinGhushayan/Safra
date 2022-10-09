import 'dart:convert';

import 'package:safra/backend/supabase.dart';

List<TripsInfo> TripsInfoFromJson(String str) =>
    List<TripsInfo>.from(json.decode(str).map((x) => TripsInfo.fromJson(x)));

String tripsInfoToJson(TripsInfo data) => json.encode(data.toJson());

class TripsInfo {
  TripsInfo({
    required this.tripId,
    required this.active,
    required this.from,
    required this.to,
    required this.uid,
  });

  String tripId;
  String active;
  String uid;
  DateTime from;
  DateTime to;

  factory TripsInfo.fromJson(Map<String, dynamic> json) => TripsInfo(
        tripId: json["trip_id"],
        uid: json["uid"],
        active: json["active"],
        from: DateTime.parse(json["from"]),
        to: DateTime.parse(json["to"]),
      );

  Map<String, dynamic> toJson() => {
        "trip_id": tripId,
        "active": active,
        "uid": uid,
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

      return TripsInfoFromJson(data);
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

      return TripsInfoFromJson(data);
    }
  }
}

Future createTrip_Info({
  required String tripId,
  required String active,
  required String uid,
  required DateTime from,
  required DateTime to,
}) async {
  final trips_Info = TripsInfo(
    tripId: tripId,
    active: active,
    uid: uid,
    from: from,
    to: to,
  );

  final docTrip_Info = await SupaBase_Manager()
      .client
      .from('trips_info')
      .insert([trips_Info.toJson()]).execute();
}
