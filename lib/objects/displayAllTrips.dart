import 'dart:convert';

import 'package:safra/backend/supabase.dart';
import 'package:safra/objects/TripsInfo.dart';

List<DisplayTripsInfo> DisplayTripsInfoFromJson(String str) =>
    List<DisplayTripsInfo>.from(
        json.decode(str).map((x) => DisplayTripsInfo.fromJson(x)));

class DisplayTripsInfo {
  DisplayTripsInfo({
    required this.tripsInfo,
  });

  List<TripsInfo> tripsInfo;

  factory DisplayTripsInfo.fromJson(Map<String, dynamic> json) =>
      DisplayTripsInfo(
        tripsInfo: List<TripsInfo>.from(
            json["trips_info"].map((x) => TripsInfo.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "trips_info": List<dynamic>.from(tripsInfo.map((x) => x.toJson())),
      };
  static Future<List<DisplayTripsInfo>?> registeredTrips(String uid) async {
    final response = await SupaBase_Manager()
        .client
        .from('participate')
        .select('trips_info(*)')
        .eq('uid', uid)
        .execute();
    if (response.data.isNotEmpty) {
      var data = response.data.toString();
      data = data.replaceAll('{', '{"');
      data = data.replaceAll(' {"', ' [{"');
      data = data.replaceAll(': ', '": "');
      data = data.replaceAll(', ', '", "');
      data = data.replaceAll('"[{', '[{');
      data = data.replaceAll('}}"', '"}]}');
      data = data.replaceAll(', [{"', ', {"');
      data = data.replaceAll('}}]', '"}]}]');
      return DisplayTripsInfoFromJson(data);
    }
  }
}
