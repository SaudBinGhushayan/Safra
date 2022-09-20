// To parse this JSON data, do
//
//     final places = placesFromJson(jsonString);

import 'dart:convert';

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
  });

  String fsq_id;
  String name;
  String rating;
  String tel;
  String country;
  String region;
  String price;
  String description;

  factory Places.fromJson(Map<String, dynamic> json) => Places(
        fsq_id: json["fsq_id"],
        name: json["name"],
        rating: json["rating"],
        tel: json["tel"],
        country: json["country"],
        region: json["region"],
        price: json["price"],
        description: json["description"],
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
      };
}
