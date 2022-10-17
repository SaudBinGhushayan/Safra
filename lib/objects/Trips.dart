// To parse this JSON data, do
//
//     final trips = tripsFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:safra/backend/supabase.dart';
import 'package:safra/objects/TripsInfo.dart';
import 'package:safra/objects/participate.dart';

List<Trips> TripsFromJson(String str) =>
    List<Trips>.from(json.decode(str).map((x) => Trips.fromJson(x)));

class Trips {
  Trips({
    required this.uid,
    required this.fsq_id,
    required this.name,
    required this.rating,
    required this.tel,
    required this.country,
    required this.region,
    required this.price,
    required this.description,
    required this.active,
    required this.trip_id,
    required this.trip_name,
    required this.categories,
    required this.photo_url,
    required this.translated_description,
  });

  String uid;
  String trip_name;
  String fsq_id;
  String name;
  String rating;
  String tel;
  String country;
  String region;
  String price;
  String description;
  String active;
  String trip_id;
  String translated_description;
  String categories;
  String photo_url;

  factory Trips.fromJson(Map<String, dynamic> json) => Trips(
        trip_name: json["trip_name"],
        uid: json["uid"],
        translated_description: json["translated_description"],
        categories: json["categories"],
        photo_url: json["photo_url"],
        fsq_id: json['fsq_id'],
        trip_id: json["trip_id"],
        name: json['name'],
        country: json['country'],
        price: json['price'],
        rating: json['rating'],
        region: json['region'],
        tel: json['tel'],
        active: json["active"],
        description: json['description'],
      );

  Map<String, dynamic> toJson() => {
        "trip_name": trip_name,
        "uid": uid,
        "translated_description": translated_description,
        "categories": categories,
        "photo_url": photo_url,
        "fsq_id": fsq_id,
        "trip_id": trip_id,
        "name": name,
        "country": country,
        "price": price,
        "rating": rating,
        "region": region,
        "tel": tel,
        "active": active,
        "description": description
      };

  static Future<bool> availableTrip(String uid) async {
    final docTrip = await SupaBase_Manager()
        .client
        .from('activities')
        .select()
        .eq('uid', uid)
        .execute();
    if (docTrip.data.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  static Future<List<Trips>?> readTrips(String uid) async {
    final response = await SupaBase_Manager()
        .client
        .from('activities')
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
      return TripsFromJson(data);
    }
  }

  static Future<List<Trips>?> displayNearestTripActivities(String uid) async {
    final response = await SupaBase_Manager()
        .client
        .rpc('display_activities', params: {'userid': uid}).execute();
    if (response.error == null) {
      var data = response.data.toString();
      data = data.replaceAll('{', '{"');
      data = data.replaceAll(': ', '": "');
      data = data.replaceAll(', ', '", "');
      data = data.replaceAll('}', '"}');
      data = data.replaceAll('}",', '},');
      data = data.replaceAll('"{', '{');
      return TripsFromJson(data);
    }
  }
}

Future createTrip(
    {required String uid,
    required String fsq_id,
    required String name,
    required String rating,
    required String tel,
    required String country,
    required String region,
    required String price,
    required String description,
    required String active,
    required String trip_id,
    required DateTime from,
    required DateTime to,
    required String trip_name,
    required String participate_id,
    required String photo_url,
    required String translated_description,
    required String categories,
    required String username}) async {
  final trips = Trips(
      uid: uid,
      fsq_id: fsq_id,
      photo_url: photo_url,
      categories: categories,
      translated_description: translated_description,
      name: name,
      rating: rating,
      tel: tel,
      country: country,
      region: region,
      price: price,
      description: description,
      active: active,
      trip_name: trip_name,
      trip_id: trip_id);

  final trips_Info = TripsInfo(
      tripId: trip_id,
      active: active,
      uid: uid,
      from: from,
      to: to,
      trip_name: trip_name);

  final participate = Participate(
    participate_id: participate_id,
    username: username,
    tripId: trip_id,
    uid: uid,
  );

  await SupaBase_Manager()
      .client
      .from('trips_info')
      .insert([trips_Info.toJson()]).execute();
  await SupaBase_Manager()
      .client
      .from('activities')
      .insert([trips.toJson()]).execute();
  await SupaBase_Manager()
      .client
      .from('participate')
      .insert([participate.toJson()]).execute();
}

Future appendTrip(
    {required String uid,
    required String fsq_id,
    required String name,
    required String rating,
    required String tel,
    required String country,
    required String region,
    required String price,
    required String description,
    required String active,
    required String trip_name,
    required String photo_url,
    required String translated_description,
    required String categories,
    required String trip_id}) async {
  final trips = Trips(
      trip_name: trip_name,
      uid: uid,
      photo_url: photo_url,
      categories: categories,
      translated_description: translated_description,
      fsq_id: fsq_id,
      name: name,
      rating: rating,
      tel: tel,
      country: country,
      region: region,
      price: price,
      description: description,
      active: active,
      trip_id: trip_id);

  await SupaBase_Manager()
      .client
      .from('activities')
      .insert([trips.toJson()]).execute();
}
