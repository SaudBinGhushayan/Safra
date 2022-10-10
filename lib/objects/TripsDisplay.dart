import 'dart:convert';

import 'package:safra/backend/supabase.dart';
import 'package:safra/objects/Trips.dart';

TripsDisplay tripsDisplayFromJson(String str) =>
    TripsDisplay.fromJson(json.decode(str));

String tripsDisplayToJson(TripsDisplay data) => json.encode(data.toJson());

class TripsDisplay {
  TripsDisplay({
    required this.activities,
  });

  List<Trips> activities;

  factory TripsDisplay.fromJson(Map<String, dynamic> json) => TripsDisplay(
        activities:
            List<Trips>.from(json["activities"].map((x) => Trips.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "activities": List<dynamic>.from(activities.map((x) => x.toJson())),
      };
  static Future<TripsDisplay?> displayNearestTripActivities(String uid) async {
    final response = await SupaBase_Manager()
        .client
        .from('trips_info')
        .select('activities(*)')
        .eq('uid', uid)
        .eq('active', 'true')
        .filter('to', 'gt', DateTime.now())
        .execute();

    if (response.error == null) {
      var data = response.data[0].toString();
      data = data.replaceAll('{', '{"');
      data = data.replaceAll(': ', '": "');
      data = data.replaceAll(', ', '", "');
      data = data.replaceAll('}', '"}');
      data = data.replaceAll('}",', '},');
      data = data.replaceAll('"{', '{');
      data = data.replaceAll('"[', '[');
      data = data.replaceAll(']"', ']');
      return tripsDisplayFromJson(data);
    }
  }
}
