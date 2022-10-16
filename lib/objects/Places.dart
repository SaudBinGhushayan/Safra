// To parse this JSON data, do
//
//     final places = placesFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/cupertino.dart';

List<Places> placesFromJson(String str) =>
    List<Places>.from(json.decode(str).map((x) => Places.fromJson(x)));

String placesToJson(List<Places> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Places {
  Places({
    required this.fsq_id,
    required this.name,
    required this.rating,
    required this.tel,
    required this.country,
    required this.region,
    required this.price,
    required this.description,

    // added
    // required this.translated_description,
    // required this.categories,
    // required this.photo_url
  });

  String fsq_id;
  String name;
  String rating;
  String tel;
  String country;
  String region;
  String price;
  String description;
  // added
  // String translated_description;
  // String categories;
  // String photo_url;

  factory Places.fromJson(Map<String, dynamic> json) => Places(
        fsq_id: json["fsq_id"],
        name: json["name"],
        rating: json["rating"],
        tel: json["tel"],
        country: json["country"],
        region: json["region"],
        price: json["price"],
        description: json["description"],
        // translated_description: json['translated_description'],
        // categories: json['categories'],
        // photo_url: json['photo_url']
      );

  Map<String, dynamic> toJson() => {
        "fsq_id": fsq_id,
        "name": name,
        "rating": rating,
        "tel": tel,
        "country": country,
        "region": region,
        "price": price,
        "description": description,
        // "translated_description": translated_description,
        // "categories": categories,
        // "photo_url": photo_url
      };
}
