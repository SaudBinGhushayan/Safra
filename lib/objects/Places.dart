import 'package:cloud_firestore/cloud_firestore.dart';

class Places {
  final String city;
  final String place;

  Places({
    required this.city,
    required this.place,
  });

  static Places readFromJson(Map<String, dynamic> json) => Places(
        city: json['city'],
        place: json['place'],
      );
  Map<String, dynamic> toJson() => {
        'city': city,
        'place': place,
      };
}
