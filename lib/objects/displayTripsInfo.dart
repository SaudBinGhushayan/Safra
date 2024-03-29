import 'dart:convert';

import 'package:safra/backend/supabase.dart';
import 'package:safra/objects/TripsInfo.dart';

List<displayTripsInfo> displayTripsInfoFromJson(String str) =>
    List<displayTripsInfo>.from(
        json.decode(str).map((x) => displayTripsInfo.fromJson(x)));

String displayTripsInfoToJson(List<TripsInfo> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class displayTripsInfo {
  displayTripsInfo({
    required this.tripsInfo,
  });

  TripsInfo tripsInfo;

  factory displayTripsInfo.fromJson(Map<String, dynamic> json) =>
      displayTripsInfo(
        tripsInfo: TripsInfo.fromJson(json["trips_info"]),
      );

  Map<String, dynamic> toJson() => {
        "trips_info": tripsInfo.toJson(),
      };
  static Future<List<displayTripsInfo>?> displayNearestTrip(String uid) async {
    await Future.delayed(Duration(seconds: 1));
    final response = await SupaBase_Manager()
        .client
        .from('participate')
        .select('trips_info(*)')
        .eq('active', 'true')
        .eq('uid', uid)
        .filter('trips_info.to', 'gt', DateTime.now())
        .execute();
    if (response.data.isNotEmpty) {
      var data = response.data[0].toString();
      data = data.replaceAll('{', '[{"');
      data = data.replaceAll(': ', '": "');
      data = data.replaceAll(', ', '", "');
      data = data.replaceAll('}', '"}');
      data = data.replaceAll('}",', '},');
      data = data.replaceAll('"{', '{');
      data = data.replaceAll('"}"}', '"}}]');
      data = data.replaceAll('"[{', '{');
      return displayTripsInfoFromJson(data);
    }
  }
}
