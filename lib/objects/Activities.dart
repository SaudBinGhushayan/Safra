import 'package:cloud_firestore/cloud_firestore.dart';

class Activities {
  final String city;
  final String activity;
  final String date;

  Activities({
    required this.city,
    required this.activity,
    required this.date,
  });

  static Activities readFromJson(Map<String, dynamic> json) => Activities(
        city: json['city'],
        activity: json['activity'],
        date: json['date'],
      );
  Map<String, dynamic> toJson() => {
        'city': city,
        'activity': activity,
        'date': date,
      };
}
